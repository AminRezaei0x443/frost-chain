source /home/a27rezae/.boot.sh

project="$1"
n="$2"
configs="$3"

sudo killall ignite
sudo killall "$project"d

sudo rm -rf "$configs"
# sudo rm -rf ~/."$project"

for (( i = 0; i <$n ; i++ )); do
    printf -v tv "%02d" $i
    sudo rm -rf ~/."$project-$tv"
done
# sudo rm -rf ~/."$project"*
sudo rm -rf ~/.ignite/relayer

rm -rf bench-logs
mkdir bench-logs

echo "generating configs into $configs/"
python3 gconf.py $project $n $configs

for (( i = 0; i <$n ; i++ )); do
    printf -v tv "%02d" $i
    echo "launching chain $configs/$project-$tv.yml"
    ignite chain serve -c $configs/$project-$tv.yml > bench-logs/$project-$tv.log 2>&1 &
    echo "waiting to spawn"

    if [ $i -eq 0 ]
    then
        sleep 20
    else
        sleep 20
    fi
done

for (( i = 1; i <$n ; i++ )); do
    s_rpc=$(( 10001 + 4 ))
    s_faucet=$(( 10007 ))
    t_rpc=$(( 10001 + 7 * $i + 4 ))
    t_faucet=$(( 10001 + 7 * $i + 6))
    echo "configuring relayer source(rpc: $s_rpc, faucet: $s_faucet) -> target(rpc: $t_rpc, faucet: $t_faucet)"
    ignite relayer configure -a \
    --source-rpc "http://0.0.0.0:${s_rpc}" \
    --source-faucet "http://0.0.0.0:${s_faucet}" \
    --source-port "blog" \
    --source-version "blog-1" \
    --source-gasprice "0.0000025stake" \
    --source-prefix "cosmos" \
    --source-gaslimit 300000 \
    --source-account "default" \
    --target-rpc "http://0.0.0.0:${t_rpc}" \
    --target-faucet "http://0.0.0.0:${t_faucet}" \
    --target-port "blog" \
    --target-version "blog-1" \
    --target-gasprice "0.0000025stake" \
    --target-prefix "cosmos" \
    --target-gaslimit 300000 \
    --target-account "default" > bench-logs/relayer-c-"$i".log 2>&1
done

ignite relayer connect > bench-logs/relayer.log 2>&1 &
source /home/a27rezae/.boot.sh

project="$1"

for i in {1..1000}
do
    "$1" tx blog send-ibc-post blog channel-0 "Hello" "Hello Mars, I'm Alice from Earth" --from alice --chain-id frost-01 --home ~/.frost-01
   frostd keys add user"$i" --home ~/."$1" >> accounts-"$1".log
done





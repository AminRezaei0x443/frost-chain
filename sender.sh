project="$1"

rm ibc-send.log

for trial in {1..10000}
do
    for node in {1..4}
    do
        for i in {1..24}
        do 
            echo $trial $node $i $(date +%s%3N) >> ibc-send.log
            "$1"d --chain-id "$project"-0"$node" --home /root/."$project"-0"$node" tx blog send-ibc-post blog channel-0 "Hello $trial - $i" "Msg $trial - $i ..." --from user$i --packet-timeout-timestamp 15000000000 -y &
            sleep 0.5
        done
    done
done
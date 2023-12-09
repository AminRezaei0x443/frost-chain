for trial in {6..100}
do
    ignite relayer connect | ./predate.sh > bench-logs/relayer$i.log
    sleep 90
done
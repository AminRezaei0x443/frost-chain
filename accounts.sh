for i in {1001..1200}
do
   frostd keys add user"$i" --home ~/."$1" >> accounts-"$1".log
done

for i in {0..100}
do
   frostd keys add user"$i" --home ~/."$1" >> accounts-"$1".log
done

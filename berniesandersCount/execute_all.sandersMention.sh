#! /bin/bash
for ((i=1; i <= 7 ; i++))
do
   hive -f hive_scripts/more.candidates/berniesandersCount/sandersMention.count.$(printf '%d' $i).sql
done

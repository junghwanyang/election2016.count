#! /bin/bash
for ((i=1; i <= 7 ; i++))
do
   hive -f hive_scripts/more.candidates/donaldtrumpCount/trumpMention.count.$(printf '%d' $i).sql
done

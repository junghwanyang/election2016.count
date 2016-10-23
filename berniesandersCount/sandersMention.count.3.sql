insert overwrite local directory 'keyword.count/sandersMention.count.3'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2015
    and
    month>6
    and
    month<=9
    and
    --lower(text) regexp '\\scruz\\W'
    --and
    (
        lower(text) like '%@berniesanders%'
        or
        lower(text) like '%@sensanders%'
    )
    and
    lower(text) not like '%RT @berniesanders%'
    and
    lower(text) not like '%RT @sensanders%'
    and
    lower(user.screen_name) not like '%berniesanders%'
    and
    lower(user.screen_name) not like '%sensanders%'
    and
    (
        (retweeted_status.user.screen_name is not NULL
        and
        lower(retweeted_status.user.screen_name) not like '%berniesanders%'
        )
    or
        (retweeted_status.user.screen_name is not NULL
        and
        lower(retweeted_status.user.screen_name) not like '%sensanders%'
        )
    or
        retweeted_status.user.screen_name is NULL
    )
group by year, month, day;

-- This script counts tweets with '@BernieSanders' or '@SenSanders' except Bernie Sanders's own tweet and retweets of Bernie Sanders's tweet (RT @BernieSanders, RT @SenSanders)

-- @BernieSanders
-- @SenSanders

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
insert overwrite local directory 'keyword.count/sandersRT.count.1'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2015
    and
    month<=3
    and
    --lower(text) regexp '\\scruz\\W'
    --and
    (
        lower(text) like '%RT @berniesanders%'
        or
        lower(text) like '%RT @sensanders%'
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            lower(retweeted_status.user.screen_name) like '%berniesanders%'
        )
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            lower(retweeted_status.user.screen_name) like '%sensanders%'
        )
    )
group by year, month, day;

-- This script counts retweets of ted cruz's tweet (RT @berniesanders, RT @sensanders)

-- @berniesanders
-- @sensanders

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
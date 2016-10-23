insert overwrite local directory 'keyword.count/cruzRT.count.7'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2016
    and
    month>6
    and
    month<=9
    and
    --lower(text) regexp '\\scruz\\W'
    --and
    (
        lower(text) like '%RT @tedcruz%'
        or
        lower(text) like '%RT @sentedcruz%'
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            lower(retweeted_status.user.screen_name) like '%tedcruz%'
        )
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            lower(retweeted_status.user.screen_name) like '%sentedcruz%'
        )
    )
group by year, month, day;

-- This script counts retweets of ted cruz's tweet (RT @tedcruz, RT @SenTedCruz)

-- @tedcruz
-- @SenTedCruz

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
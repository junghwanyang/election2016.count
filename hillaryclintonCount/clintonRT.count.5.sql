insert overwrite local directory 'keyword.count/clintonRT.count.5'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2016
    and
    month<=3
    and
    --lower(text) regexp '\\scruz\\W'
    --and
    (
        lower(text) like '%RT @hillaryclinton%'
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            lower(retweeted_status.user.screen_name) like '%hillaryclinton%'
        )
    )
group by year, month, day;

-- This script counts retweets of hillary clinton's tweet (RT @hillaryclinton)

-- @hillaryclinton

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
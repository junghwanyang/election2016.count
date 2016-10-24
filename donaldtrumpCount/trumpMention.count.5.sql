insert overwrite local directory 'keyword.count/trumpMention.count.5'
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
    lower(text) like '%@realdonaldtrump%'
    and
    lower(text) not like '%RT @realdonaldtrump%'
    and
    lower(user.screen_name) not like '%realdonaldtrump%'
    and
    (
        (retweeted_status.user.screen_name is not NULL
        and
        lower(retweeted_status.user.screen_name) not like '%realdonaldtrump%'
        )
    or
        retweeted_status.user.screen_name is NULL
    )
group by year, month, day;

-- This script counts tweets with '@realdonaldtrump' except donald trump's own tweet and retweets of donald trump's tweet (RT @realdonaldtrump)

-- @realdonaldtrump

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
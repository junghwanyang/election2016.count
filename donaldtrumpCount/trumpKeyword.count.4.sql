insert overwrite local directory 'keyword.count/trumpKeyword.count.4'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2015
    and
    month>9
    and
    lower(text) like regexp '\\strump\\W'
    and
    lower(text) not like '%@realdonaldtrump%'
    and
    lower(user.screen_name) not like 'realdonaldtrump'
    and
    (
        retweeted_status.user.screen_name is not NULL
        and
        lower(retweeted_status.user.screen_name) like 'realdonaldtrump'
    )
group by year, month, day;

-- This script counts tweets with 'trump' mentions except for @realdonaldtrump or RT @realdonaldtrump

-- @realdonaldtrump

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
insert overwrite local directory 'keyword.count/trumpKeyword.id_str'
row format delimited
fields terminated by '\t'
select year, month, day, created_at, id_str
from gh_rc2
where
    (
        year=2015
    or
        (year=2016
        and
        month<=9)
    )
    and
    lower(text) rlike '\(^|\\s|\\#\)trump\(\\W|$\)'
    and
    lower(text) not like '%@realdonaldtrump%'
    and
    lower(user.screen_name) not like 'realdonaldtrump'
    and
    (
        retweeted_status.user.screen_name is not NULL
        and
        lower(retweeted_status.user.screen_name) not like 'realdonaldtrump'
    );

-- This script download tweets with 'trump' mentions except for @realdonaldtrump or RT @realdonaldtrump

-- @realdonaldtrump

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
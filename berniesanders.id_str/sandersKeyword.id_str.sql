insert overwrite local directory 'keyword.count/sandersKeyword.id_str'
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
    (
        lower(text) rlike '\(^|\\s|\\#\)bernie\(\\W|$\)'
        or
        lower(text) rlike '\(^|\\s|\\#\)sanders\(\\W|$\)'
    )
    and
    lower(text) rlike '^\(\(?!^.*\\b*@berniesanders\\b.*$\).\)*$'
    and
    lower(text) rlike '^\(\(?!^.*\\b*@sensanders\\b.*$\).\)*$'
    and
    lower(user.screen_name) not like 'berniesanders'
    and
    lower(user.screen_name) not like 'sensanders'
    and
    (
        retweeted_status.user.screen_name is not NULL
        and
        (
            lower(retweeted_status.user.screen_name) not like 'berniesanders'
            or
            lower(retweeted_status.user.screen_name) not like 'sensanders'
        )
    );

-- This script download tweets with 'bernie sanders' mentions except for @berniesanders or RT @berniesanders or @sensanders or RT @sensanders 

-- @berniesanders
-- @sensanders

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
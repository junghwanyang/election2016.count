insert overwrite local directory 'elex2016/clinton.id_str.keyword'
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
        lower(text) rlike '\(^|\\s|\\#\)hillary\(\\W|$\)'
        or
        lower(text) rlike '\(^|\\s|\\#\)clinton\(\\W|$\)'
    )
    and
    lower(text) rlike '^\(\(?!^.*\\b*@hillaryclinton\\b.*$\).\)*$'
    and
    lower(user.screen_name) not like 'hillaryclinton'
    and
    (
        retweeted_status.user.screen_name is not NULL
        and
        lower(retweeted_status.user.screen_name) not like 'hillaryclinton'
    );

-- This script download tweets with 'hillary' mentions except for @hillaryclinton or RT @hillaryclinton

-- @hillaryclinton

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
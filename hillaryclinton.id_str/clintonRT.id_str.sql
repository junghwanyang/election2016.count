insert overwrite local directory 'elex2016/clinton.id_str.RT'
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
        lower(text) rlike '\\brt\\s*@hillaryclinton\\b'
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            lower(retweeted_status.user.screen_name) like 'hillaryclinton'
        )
    );

-- This script download retweets with 'RT @hillaryclinton' except hillary clinton's own tweet and mentions of hillary clinton's tweet

-- @hillaryclinton

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
insert overwrite local directory 'keyword.count/trumpKeyword.count.6'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2016
    and
    month>3
    and
    month<=6
    and
    (
        (lower(text) regexp '\\shillary\\W')
        or
        (
            (lower(text) like '%clinton%')
            and
            (lower(text) not like '%bill%')
        )
        or
        (
            (lower(text) like '%clinton%')
            and
            (lower(text) not like '%foundation%')
        )
    )
    and
    lower(text) not like '%@hillaryclinton%'
    and
    lower(user.screen_name) not like 'hillaryclinton'
    and
    (
        (
            retweeted_status.user.screen_name is not NULL
            and
            (lower(retweeted_status.user.screen_name) not like 'hillaryclinton')
        )
        or
        (
            retweeted_status.user.screen_name is NULL
        )
    )
group by year, month, day;

-- This script counts tweets with 'trump' mentions except for @realdonaldtrump or RT @realdonaldtrump

-- @realdonaldtrump

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
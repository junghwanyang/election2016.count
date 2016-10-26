insert overwrite local directory 'keyword.count/clintonKeyword.count.7'
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
    (
        (lower(text) like '%hillary%')
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

-- This script counts tweets with 'hillary' or 'clinton' mentions except for @hillaryclinton or RT @hillaryclinton

-- @hillaryclinton

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF


-- This script counts tweets with 'hillary' or 'clinton' mentions except for @hillaryclinton or RT @hillaryclinton

-- @hillaryclinton

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
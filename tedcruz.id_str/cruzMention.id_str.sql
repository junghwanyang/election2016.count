insert overwrite local directory 'elex2016/cruz.id_str.mention'
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
        lower(text) rlike '\\b*@tedcruz\\b'
        or
        lower(text) rlike '\\b*@sentedcruz\\b'
    )
    and
    lower(text) rlike '^\(\(?!^.*\\brt\\s*@tedcruz\\b.*$\).\)*$'
    and
    lower(text) rlike '^\(\(?!^.*\\brt\\s*@sentedcruz\\b.*$\).\)*$'
    and
    lower(user.screen_name) not like 'tedcruz'
    and
    lower(user.screen_name) not like 'sentedcruz'    
    and
    (
        retweeted_status.user.screen_name is not NULL
        and
        (
            lower(retweeted_status.user.screen_name) not like 'tedcruz'
            or
            lower(retweeted_status.user.screen_name) not like 'sentedcruz'
        )
    );

-- This script download tweets with '@tedcruz' or '@sentedcruz' except ted cruz's own tweet and retweets of ted cruz's tweet (RT @tedcruz, RT @sentedcruz)

-- @tedcruz
-- @sentedcruz

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF

-- This is a java regex to exclude rt @hillaryclinton ^((?!^.*\brt @hillaryclinton\b.*$).)*$
-- Hive needs \ before () and \
-- So, this is a hive regex to exclude rt @hillaryclinton ^\(\(?!^.*\\brt @hillaryclinton\\b.*$\).\)*$
-- I made it into ^\(\(?!^.*\\brt\\s*@hillaryclinton\\b.*$\).\)*$ by changing space between rt and @ into \\s*
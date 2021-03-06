insert overwrite local directory 'elex2016/trump.id_str.mention'
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
    --lower(text) regexp '\\scruz\\W'
    --and
    lower(text) like '%@realdonaldtrump%'
    and
    lower(text) rlike '^\(\(?!^.*\\brt\\s*@realdonaldtrump\\b.*$\).\)*$'
    and
    lower(user.screen_name) not like '%realdonaldtrump%';

-- This script download tweets with '@realdonaldtrump' except donald trump's own tweet and retweets of donald trump's tweet (RT @realdonaldtrump)

-- @realdonaldtrump

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF

-- This is a java regex to exclude rt @realdonaldtrump ^((?!^.*\brt @realdonaldtrump\b.*$).)*$
-- Hive needs \ before () and \
-- So, this is a hive regex to exclude rt @realdonaldtrump ^\(\(?!^.*\\brt @realdonaldtrump\\b.*$\).\)*$
-- I made it into ^\(\(?!^.*\\brt\\s*@realdonaldtrump\\b.*$\).\)*$ by changing space between rt and @ into \\s
insert overwrite local directory 'keyword.count/trumpMention.count.1'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2015
    and
    month<=3
    and
    --lower(text) regexp '\\scruz\\W'
    --and
    lower(text) like '%@realdonaldtrump%'
    and
    lower(text) rlike '^\(\(?!^.*\\brt\\s*@realdonaldtrump\\b.*$\).\)*$'
    and
    lower(user.screen_name) not like '%realdonaldtrump%'
group by year, month, day;

-- This script counts tweets with '@realdonaldtrump' except donald trump's own tweet and retweets of donald trump's tweet (RT @realdonaldtrump)

-- @realdonaldtrump

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF

-- This is a java regex to exclude rt @realdonaldtrump ^((?!^.*\brt @realdonaldtrump\b.*$).)*$
-- Hive needs \ before () and \
-- So, this is a hive regex to exclude rt @realdonaldtrump ^\(\(?!^.*\\brt @realdonaldtrump\\b.*$\).\)*$
-- I made it into ^\(\(?!^.*\\brt\\s*@realdonaldtrump\\b.*$\).\)*$ by changing space between rt and @ into \\s
insert overwrite local directory 'keyword.count/clintonMention.count.3'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2015
    and
    month>6
    and
    month<=9
    and
    --lower(text) regexp '\\scruz\\W'
    --and
    lower(text) like '%@hillaryclinton%'
    and
    lower(text) rlike '^\(\(?!^.*\\brt\\s*@hillaryclinton\\b.*$\).\)*$'
    and
    lower(user.screen_name) not like '%hillaryclinton%'
group by year, month, day;

-- This script counts tweets with '@hillaryclinton' except hillary clinton's own tweet and retweets of hillary clinton's tweet (RT @hillaryclinton)

-- @hillaryclinton

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF

-- This is a java regex to exclude rt @hillaryclinton ^((?!^.*\brt @hillaryclinton\b.*$).)*$
-- Hive needs \ before () and \
-- So, this is a hive regex to exclude rt @hillaryclinton ^\(\(?!^.*\\brt @hillaryclinton\\b.*$\).\)*$
-- I made it into ^\(\(?!^.*\\brt\\s*@hillaryclinton\\b.*$\).\)*$ by changing space between rt and @ into \\s
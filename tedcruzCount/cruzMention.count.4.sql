insert overwrite local directory 'keyword.count/cruzMention.count.4'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2015
    and
    month>9
    and
    --lower(text) regexp '\\scruz\\W'
    --and
    (
        lower(text) like '%@tedcruz%'
        or
        lower(text) like '%@sentedcruz%'
    )
    and
    lower(text) rlike '^\(\(?!^.*\\brt\\s*@tedcruz\\b.*$\).\)*$'
    and
    lower(text) rlike '^\(\(?!^.*\\brt\\s*@sentedcruz\\b.*$\).\)*$'
    and
    lower(user.screen_name) not like '%tedcruz%'
    and
    lower(user.screen_name) not like '%sentedcruz%'
group by year, month, day;

-- This script counts tweets with '@tedcruz' or '@sentedcruz' except ted cruz's own tweet and retweets of ted cruz's tweet (RT @tedcruz, RT @sentedcruz)

-- @tedcruz
-- @sentedcruz

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF

-- This is a java regex to exclude rt @tedcruz ^((?!^.*\brt @tedcruz\b.*$).)*$
-- Hive needs \ before () and \
-- So, this is a hive regex to exclude rt @tedcruz ^\(\(?!^.*\\brt @tedcruz\\b.*$\).\)*$
-- I made it into ^\(\(?!^.*\\brt\\s*@tedcruz\\b.*$\).\)*$ by changing space between rt and @ into \\s
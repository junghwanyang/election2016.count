insert overwrite local directory 'keyword.count/sandersMention.count.5'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2016
    and
    month<=3
    and
    --lower(text) regexp '\\scruz\\W'
    --and
    (
        lower(text) like '%@berniesanders%'
        or
        lower(text) like '%@sensanders%'
    )
    and
    lower(text) rlike '^\(\(?!^.*\\brt\\s*@berniesanders\\b.*$\).\)*$'
    and
    lower(text) rlike '^\(\(?!^.*\\brt\\s*@sensanders\\b.*$\).\)*$'
    and
    lower(user.screen_name) not like '%berniesanders%'
    and
    lower(user.screen_name) not like '%sensanders%'
group by year, month, day;

-- This script counts tweets with '@berniesanders' or '@sensanders' except bernie sanders's own tweet and retweets of bernie sanders's tweet (RT @berniesanders, RT @sensanders)

-- @berniesanders
-- @sensanders

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF

-- This is a java regex to exclude rt @berniesanders ^((?!^.*\brt @berniesanders\b.*$).)*$
-- Hive needs \ before () and \
-- So, this is a hive regex to exclude rt @berniesanders ^\(\(?!^.*\\brt @berniesanders\\b.*$\).\)*$
-- I made it into ^\(\(?!^.*\\brt\\s*@berniesanders\\b.*$\).\)*$ by changing space between rt and @ into \\s
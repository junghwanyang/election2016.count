insert overwrite local directory 'keyword.count/sandersRT.count.6'
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
    --lower(text) regexp '\\scruz\\W'
    --and
    (
        lower(text) rlike '^.*\\brt\\s*@berniesanders\\b.*$'
        or
        lower(text) rlike '^.*\\brt\\s*@sensanders\\b.*$'
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            lower(retweeted_status.user.screen_name) like '%berniesanders%'
        )
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            lower(retweeted_status.user.screen_name) like '%sensanders%'
        )
    )
group by year, month, day;


-- This script counts retweets of ted cruz's tweet (RT @berniesanders, RT @sensanders)

-- @berniesanders
-- @sensanders

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF

-- This is a java regex to select rt @berniesanders ^.*\brt @berniesanders\b.*$
-- Hive needs \ before () and \
-- So, this is a hive regex to select rt @berniesanders ^.*\\brt @berniesanders\\b.*$
-- I made it into ^\(\(?!^.*\\brt\\s*@berniesanders\\b.*$\).\)*$ by changing space between rt and @ into \\s

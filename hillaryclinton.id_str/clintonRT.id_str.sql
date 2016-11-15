insert overwrite local directory 'keyword.count/trumpRT.id_str'
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
    (
        lower(text) rlike '\\brt\\s*@realdonaldtrump\\b'
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            lower(retweeted_status.user.screen_name) like '%realdonaldtrump%'
        )
    );

-- This script counts retweets of donald trump's tweet (RT @realdonaldtrump)

-- @realdonaldtrump

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
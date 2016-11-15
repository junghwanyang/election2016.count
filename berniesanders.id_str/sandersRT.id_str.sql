insert overwrite local directory 'elex2016/sanders.id_str.RT'
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
        lower(text) rlike '\\brt\\s*@berniesanders\\b'
        or
        lower(text) rlike '\\brt\\s*@sensanders\\b'
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            (
                lower(retweeted_status.user.screen_name) like 'berniesanders'
                or
                lower(retweeted_status.user.screen_name) like 'sensanders'
            )
        )
    );

-- This script counts retweets of bernie sanders's tweet (RT @berniesanders, RT @sensanders)

-- @berniesanders
-- @sensanders

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
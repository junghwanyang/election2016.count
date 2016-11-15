insert overwrite local directory 'elex2016/cruz.id_str.RT'
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
        lower(text) rlike '\\brt\\s*@tedcruz\\b'
        or
        lower(text) rlike '\\brt\\s*@sentedcruz\\b'
        or
        (
            retweeted_status.user.screen_name is not NULL
            and
            (
                lower(retweeted_status.user.screen_name) like 'tedcruz'
                or
                lower(retweeted_status.user.screen_name) like 'sentedcruz'
            )
        )
    );

-- This script counts retweets of ted cruz's tweet (RT @tedcruz, RT @sentedcruz)

-- @tedcruz
-- @sentedcruz

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
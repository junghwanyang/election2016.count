insert overwrite local directory 'elex2016/sanders.id_str.keyword'
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
    lower(text) rlike '\(^|\\s|\\#\)bernie\(\\W|$\)'
    and
    lower(text) rlike '^\(\(?!^.*\\b*@berniesanders\\b.*$\).\)*$'
    and
    lower(text) rlike '^\(\(?!^.*\\b*@sensanders\\b.*$\).\)*$'
    and
    lower(text) rlike '^\(\(?!^.*\\bbernie\\s*mac\\b.*$\).\)*$'
    and
    lower(user.screen_name) not like 'berniesanders'
    and
    lower(user.screen_name) not like 'sensanders'
    and
    (
        retweeted_status.user.screen_name is not NULL
        and
        (
            lower(retweeted_status.user.screen_name) not like 'berniesanders'
            or
            lower(retweeted_status.user.screen_name) not like 'sensanders'
        )
    );


-- This script finds tweets with a keyword 'bernie' except bernie sanders's own tweet and @mentions and retweets of bernie sanders's tweet (RT @berniesanders, RT @sensanders)
-- I didn't use 'sanders' as keyword because it generates lots of noise.
-- I also put a negation filter to exclude 'bernie mac' mentions

-- @berniesanders
-- @sensanders

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
insert overwrite local directory 'elex2016/cruz.id_str.keyword'
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
    lower(text) rlike '\(^|\\s|\\#\)ted\\s*cruz\(\\W|$\)'
    and
    lower(text) rlike '^\(\(?!^.*\\b*@tedcruz\\b.*$\).\)*$'
    and
    lower(text) rlike '^\(\(?!^.*\\b*@sentedcruz\\b.*$\).\)*$'
    and
    lower(user.screen_name) not like 'tedcruz'
    and
    lower(user.screen_name) not like 'sentedcruz'
    and
    (
        retweeted_status.user.screen_name is not NULL
        and
        (
            lower(retweeted_status.user.screen_name) not like 'tedcruz'
            or
            lower(retweeted_status.user.screen_name) not like 'sentedcruz'
        )
    );


-- This script finds tweets with a keyword 'ted cruz' except ted cruz's own tweet and @mentions and retweets of ted cruz's tweet (RT @tedcruz, RT @sentedcruz)
-- I used 'ted cruz' as keyword to reduce noise.
-- Unlike other candidates (trump, clinton, sanders), ted cruz's name is more common, and cruz is a very common word in spanish and portuguese. So I use both first and last name for ted cruz

-- @tedcruz
-- @sentedcruz

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
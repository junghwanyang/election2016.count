insert overwrite local directory 'keyword.count/cruzKeyword.count.2'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2015
    and
    month>2
    and
    month<=4
    and
    lower(text) regexp '\\scruz\\W'
    and
    lower(text) not like '%@tedcruz%'
    and
    lower(text) not like '%@sentedcruz%'
    and
    lower(text) not like '%de cruz%'
    and
    lower(text) not like '%santa cruz%'
    and
    lower(text) not like '%lope cruz%'
    and 
    (
        lower(user.screen_name) <> '%tedcruz%' -- remove own tweets
        or 
        lower(user.screen_name) <> '%sentedcruz%' -- remove own tweets
        or
        lower(retweeted_status.user.screen_name) <> '%tedcruz%'
        or
        lower(retweeted_status.user.screen_name) <> '%sentedcruz%'
    )
    and
    user.lang like 'en'
group by year, month, day;

-- This script counts tweets with 'ted cruz' as keyword except ted cruz's own tweet and retweets of ted cruz's tweet (RT @tedcruz, RT @SenTedCruz)
-- Unlike other candidates' counts, Cruz's case only selects English tweets

-- @tedcruz
-- @SenTedCruz

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
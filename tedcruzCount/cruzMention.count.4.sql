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
    lower(text) not like '%RT @tedcruz%'
    and
    lower(text) not like '%RT @sentedcruz%'
    and
    lower(user.screen_name) not like '%tedcruz%'
    and
    lower(user.screen_name) not like '%sentedcruz'
    and
    (
        (retweeted_status.user.screen_name is not NULL
        and
        lower(retweeted_status.user.screen_name) not like '%tedcruz%'
        )
    or
        (retweeted_status.user.screen_name is not NULL
        and
        lower(retweeted_status.user.screen_name) not like '%sentedcruz%'
        )
    or
        retweeted_status.user.screen_name is NULL
    )
group by year, month, day;

-- This script counts tweets with 'ted cruz' as keyword except ted cruz's own tweet and retweets of ted cruz's tweet (RT @tedcruz, RT @SenTedCruz)
-- Unlike other candidates' counts, Cruz's case only selects English tweets

-- @tedcruz
-- @SenTedCruz

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
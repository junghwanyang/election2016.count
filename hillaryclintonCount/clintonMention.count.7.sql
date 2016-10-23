insert overwrite local directory 'keyword.count/clintonMention.count.7'
row format delimited
fields terminated by '\t'
select year, month, day, count(*)
from gh_rc2
where
    year=2016
    and
    month>6
    and
    month<=9
    and
    --lower(text) regexp '\\scruz\\W'
    --and
    lower(text) like '%@hillaryclinton%'
    and
    lower(text) not like '%RT @hillaryclinton%'
    and
    lower(user.screen_name) not like '%hillaryclinton%'
    and
    (
        (retweeted_status.user.screen_name is not NULL
        and
        lower(retweeted_status.user.screen_name) not like '%hillaryclinton%'
        )
    or
        retweeted_status.user.screen_name is NULL
    )
group by year, month, day;

-- This script counts tweets with '@hillaryclinton' except hillary clinton's own tweet and retweets of hillary clinton's tweet (RT @hillaryclinton)

-- @HillaryClinton

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
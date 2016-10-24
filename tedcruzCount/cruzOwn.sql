insert overwrite local directory 'keyword.count/cruzOwn'
row format delimited
fields terminated by '\t'
select
id_str,
created_at,
user.id_str,
regexp_replace(regexp_replace(user.name, '[ \t\r\n]+', " "), '"', "'"),
regexp_replace(regexp_replace(user.screen_name, '[ \t\r\n]+', " "), '"', "'"),
regexp_replace(regexp_replace(user.description, '[ \t\r\n]+', " "), '"', "'"),
user.followers_count,
user.friends_count,
user.verified,
geo.type,
geo.coordinates,
regexp_replace(regexp_replace(text, '[ \t\r\n]+', " "), '"', "'"),
retweeted_status.id_str,
retweeted_status.created_at,
retweeted_status.user.id_str,
regexp_replace(regexp_replace(retweeted_status.user.name, '[ \t\r\n]+', " "), '"', "'"),
retweeted_status.user.screen_name,
regexp_replace(regexp_replace(retweeted_status.user.description, '[ \t\r\n]+', " "), '"', "'"),
retweeted_status.user.followers_count,
retweeted_status.user.friends_count,
retweeted_status.user.verified,
retweeted_status.geo.type,
retweeted_status.geo.coordinates,
regexp_replace(regexp_replace(retweeted_status.text, '[ \t\r\n]+', " "), '"', "'"),
entities.user_mentions.screen_name
from gh_rc2
where
    (
        year=2015
        or
        (year=2016 and month<=9)
    )
    and
    --lower(text) regexp '\\scruz\\W'
    --and
    (
        lower(user.screen_name) like 'tedcruz'
        or
        lower(user.screen_name) like 'sentedcruz'
        or
        (
            (
                retweeted_status.user.screen_name is not NULL
                and
                lower(retweeted_status.user.screen_name) like 'tedcruz'
            )
            or
            (
                retweeted_status.user.screen_name is not NULL
                and
                lower(retweeted_status.user.screen_name) like 'sentedcruz'
            )
        )
    );

-- This script pulls tweets from '@TedCruz' or '@SenTedCruz' and retweets of Ted Cruz's tweet (RT @TedCruz, RT @SenTedCruz)

-- @TedCruz
-- @SenTedCruz

-- http://www.vogella.com/tutorials/JavaRegularExpressions/article.html
-- http://www.regexplanet.com/advanced/java/index.html
-- http://hadooptutorial.info/hive-functions-examples/#LIKE_RLIKE
-- https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF
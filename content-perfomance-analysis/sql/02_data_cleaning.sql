
-- 1. Data Profiling
select 
	count(*) as total,
	count(*) filter (where topic_id is null) as topic_nulls,
	count(*) filter (where style_id is null) as style_nulls,
	count(*) filter (where hook_id is null) as hook_nulls,
	count(*) filter (where views is null) as views_nulls,
	count(*) filter (where likes is null) as likes_nulls,
	count(*) filter (where saves is null) as saves_null,
	count(*) filter (where interactions is null) as interactions_null,
	count(*) filter (where shares is null) as shares_null
from videos v

select topic_id, count(topic_id) as cnt from videos  group by topic_id

select * from topics

select style_id, count(style_id) as cnt from videos  group by style_id

select * from styles

select hook_id, count(hook_id) as cnt from videos  group by hook_id

select * from hooks 

select audio_source, count(audio_source)as cnt from videos group by audio_source

select text_on_screen, count(text_on_screen) as cnt from videos  group by text_on_screen 

select has_face, count(has_face) as cnt from videos  group by has_face

select voiceover, count(voiceover ) as cnt from videos  group by voiceover 
 

-- 2. Detecting Outliers

select * 
from videos 
where views < 0 
	or likes < 0 
	or duration_sec < 0 
	or interactions < 0 
	or follows < 0  
	or account_reached < 0 
	or average_watch_time_sec  < 0
	or views < 0 
	or shares < 0 
	or saves < 0 
	
select min(v.duration_sec), max(v.duration_sec) from videos v 

select min(v.interactions), max(v.interactions) from videos v 


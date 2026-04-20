-- 1. Data Preparation

create or replace view video_metrics as
select 
	videos.*,
	likes * 100.0/nullif(account_reached,0) as like_rate_reach,
	likes * 100.0/nullif(views,0) as like_rate_view,
	shares *100.0/nullif(account_reached,0) as share_rate_reach,
	shares *100.0/nullif(views,0) as share_rate_view,
	saves *100.0/nullif(account_reached,0) as save_rate_reach,
	saves *100.0/nullif(views,0) as save_rate_view,
	interactions *100.0/nullif(account_reached,0) as engagement_rate_reach,
	interactions *100.0/nullif(views,0) as engagement_rate_view,
	follows *100.0/nullif(account_reached,0) as follow_rate_reach,
	follows *100.0/nullif(views,0) as follow_rate_view,
	average_watch_time_sec*100.0/nullif(duration_sec,0) as completion_rate,
	views *1.0 / nullif(account_reached,0) as rewatch_rate
from videos  

select * from video_metrics

-- 2. Data Analysis

-- Are videos with voiceover, face, text?
select 
	case 
		when voiceover = 0 then 'no voiceover'
		else 'with voiceover'
	end as has_voiceover,
	sum(interactions) *1.0/nullif(sum(views), 0) as engagement_per_view,
	sum(interactions) *1.0/nullif(sum(account_reached), 0) as engagement_per_reach,
	sum(views) *1.0/nullif(sum(account_reached),0) as rewatch_rate_reach,
	sum(shares) *1.0/nullif(sum(account_reached),0) as share_rate_reach,
	sum(saves) *1.0/nullif(sum(account_reached),0) as save_rate_reach,
	avg(views) as avg_views,
	avg(account_reached) as avg_reached,
	count(*) as cnt_videos
from video_metrics
where interactions is not null
group by has_voiceover
order by engagement_per_view desc

select 
	case 
		when has_face = 0 then 'no face'
		else 'with face'
	end as has_face,
	sum(interactions) *1.0/nullif(sum(views), 0) as engagement_per_view,
	sum(interactions) *1.0/nullif(sum(account_reached), 0) as engagement_per_reach,
	sum(views) *1.0/nullif(sum(account_reached),0) as rewatch_rate_reach,
	sum(shares) *1.0/nullif(sum(account_reached),0) as share_rate_reach,
	sum(saves) *1.0/nullif(sum(account_reached),0) as save_rate_reach,
	avg(views) as avg_views,
	avg(account_reached) as avg_reached,
	count(*) as cnt_videos
from video_metrics
where interactions is not null
group by has_face
order by engagement_per_view desc

select 
	case 
		when text_on_screen = 0 then 'no text'
		else 'with text'
	end as has_text,
	sum(interactions) *1.0/nullif(sum(views), 0) as engagement_per_view,
	sum(interactions) *1.0/nullif(sum(account_reached), 0) as engagement_per_reach,
	sum(views) *1.0/nullif(sum(account_reached),0) as rewatch_rate_reach,
	sum(shares) *1.0/nullif(sum(account_reached),0) as share_rate_reach,
	sum(saves) *1.0/nullif(sum(account_reached),0) as save_rate_reach,
	avg(views) as avg_views,
	avg(account_reached) as avg_reached,
	count(*) as cnt_videos
from video_metrics
where interactions is not null
group by has_text
order by engagement_per_view desc



-- How does a hook affect the engagement rate?
select 
	v.hook_id,
	h.hook,
	sum(interactions) *100.0/nullif(sum(views), 0) as engagement_per_view,
	sum(interactions) *100.0/nullif(sum(account_reached), 0) as engagement_per_reach,
	sum(views) *100.0/nullif(sum(account_reached),0) as rewatch_rate_reach,
	sum(shares) *100.0/nullif(sum(account_reached),0) as share_rate_reach,
	sum(saves) *100.0/nullif(sum(account_reached),0) as save_rate_reach,
	avg(views) as avg_views,
	count(*) as cnt_videos
from video_metrics v
join hooks h on v.hook_id = h.hook_id
group by v.hook_id, h.hook 
order by engagement_per_view desc
/*
 * Emotional hooks are the most effective at driving engagement, 
 * generating the highest interaction rates both per view and per reach while maintaining strong audience reach.
 * 
 * Visual hooks are the most effective at driving shares and saves, 
 * indicating strong content appeal.
 * 
 * Curiosity-based hooks generate the highest rewatch rate, 
 * suggesting strong attention capture, but result in significantly lower engagement, 
 * indicating weaker audience interaction.
 */

-- How does a style affect the engagement rate?
select 
	s.style,
	sum(interactions) *100.0/nullif(sum(views), 0) as engagement_per_view,
	sum(interactions) *100.0/nullif(sum(account_reached), 0) as engagement_per_reach,
	sum(views) *100.0/nullif(sum(account_reached),0) as rewatch_rate_reach,
	sum(shares) *100.0/nullif(sum(account_reached),0) as share_rate_reach,
	sum(saves) *100.0/nullif(sum(account_reached),0) as save_rate_reach,
	avg(views) as avg_views,
	count(*) as cnt_videos
from video_metrics v
join styles s on v.style_id = s.style_id 
group by s.style
order by engagement_per_view desc
/*
 * Storytelling content is the most effective at driving engagement, 
 * achieving the highest interaction rates both per view and per reach, while maintaining strong rewatch behavior and stable reach.
 * 
 * Educational content drives strong saves and shares, 
 * indicating high informational value, but reaches a smaller audience and has limited sample size.
 * 
 * Promotional content generates the highest save and share rates, suggesting strong conversion intent, 
 * despite lower reach and average views.
 * 
 * Fun content attracts the largest audience and drives strong rewatch behavior, 
 * but results in lower engagement and minimal user interaction.
 * 
 * Different content styles drive different types of user behavior: storytelling maximizes engagement, 
 * promotional drives conversions (saves and shares), while fun content maximizes reach but lacks depth of interaction.
 */

-- How does a topic affect the engagement rate?
select 
	t.topic,
	sum(interactions) *100.0/nullif(sum(views), 0) as engagement_per_view,
	sum(interactions) *100.0/nullif(sum(account_reached), 0) as engagement_per_reach,
	sum(views) *100.0/nullif(sum(account_reached),0) as rewatch_rate_reach,
	sum(shares) *100.0/nullif(sum(account_reached),0) as share_rate_reach,
	sum(saves) *100.0/nullif(sum(account_reached),0) as save_rate_reach,
	avg(views) as avg_views,
	count(*) as cnt_videos
from video_metrics v
join topics t on t.topic_id = v.topic_id 
group by t.topic 
order by engagement_per_view desc
/*
 * Brand values content is the strongest overall performer, driving the highest engagement, 
 * reach, and rewatch rates, indicating strong audience connection and broad appeal.
 * 
 * Custom content generates solid engagement and rewatch behavior, 
 * suggesting strong audience interest, but reaches a smaller audience.
 * 
 * Product-focused content drives the highest save rates, indicating strong purchase intent and conversion potential.
 * 
 * New drop content shows relatively high rewatch behavior but significantly lower engagement and reach, 
 * suggesting that while it captures attention, it fails to convert it into meaningful interaction.
 * 
 * Content topic strongly influences user behavior: brand values content maximizes both reach and engagement, 
 * while product content drives conversion, and new drop content underperforms despite high attention.
 */


-- Which topics and styles are better performed?
select 
	t.topic,
	s.style,
	h.hook,
	sum(interactions) *1.0/nullif(sum(views), 0) as engagement_per_view,
	sum(interactions) *1.0/nullif(sum(account_reached), 0) as engagement_per_reach,
	sum(views) *1.0/nullif(sum(account_reached),0) as rewatch_rate_reach,
	sum(shares) *1.0/nullif(sum(account_reached),0) as share_rate_reach,
	sum(saves) *1.0/nullif(sum(account_reached),0) as save_rate_reach,
	avg(views) as avg_views,
	avg(account_reached) as avg_reached,
	count(*) as cnt_videos
from video_metrics v
join topics t on t.topic_id = v.topic_id  
join styles s on s.style_id = v.JrtКакойstyle_id 
join hooks h on h.hook_id =v.hook_id
where interactions is not null
group by t.topic, s.style, h.hook_id
order by rewatch_rate_reach   desc

/*
 * Due to the limited dataset size, some segments contain a small number of videos. 
 * Results based on low sample sizes should be interpreted with caution.
 * 
 * Brand Values + Storytelling + Emotional
 * Emotional storytelling content focused on brand values drives the highest engagement and strong saves, 
 * making it the most effective content format overall.
 * 
 * Emotional hooks perform best within storytelling formats.
 * 
 * Visual hooks combined with promotional product content generate the highest shares and saves, 
 * indicating strong distribution and conversion potential.
 * 
 * While emotional + fun content captures attention and drives repeated views, 
 * it does not translate into meaningful engagement, suggesting passive consumption rather than active interaction.
 */


-- Long videos VS Medium VS Short videos
select 
	case
		when duration_sec < 10 then 'short, <10s'
		when duration_sec < 30 then 'medium, <30s'
		else 'long'
	end as duration_group,
	sum(average_watch_time_sec)*1.0/nullif(sum(duration_sec),0) as completion_rate,
	sum(views) *1.0/nullif(sum(account_reached),0) as rewatch_rate_reach,
	sum(interactions) *1.0/nullif(sum(views), 0) as engagement_per_view,
	sum(interactions) *1.0/nullif(sum(account_reached), 0) as engagement_per_reach,
	sum(shares) *1.0/nullif(sum(account_reached),0) as share_rate_reach,
	sum(saves) *1.0/nullif(sum(account_reached),0) as save_rate_reach,
	avg(views) as avg_views,
	avg(account_reached) as avg_reached,
	count(*) as cnt_videos
from video_metrics
where interactions is not null
group by duration_group
/*
 * Short videos achieve the highest completion rates and strong rewatch behavior, 
 * indicating high retention and repeated viewing. However, they generate lower engagement and reach compared to longer formats.
 * 
 * Medium-length videos provide the best balance between reach and engagement, achieving the highest audience reach and share rate.
 * 
 * Long-form videos drive the highest engagement and save rates, indicating deeper audience interest, despite lower completion rates.
 * 
 * While short-form content captures attention efficiently, 
 * long-form videos are more effective at converting attention into meaningful engagement.
 */





create table topics(
topic_id int primary key,
topic text not null,
description text
)

create table styles(
style_id int primary key,
style text not null,
description text
)

create table hooks(
hook_id int primary key,
hook text not null,
description text
)

create table videos(
video_id int  primary key,
link text,
topic_id int,
style_id int,
hook_id int,
text_on_screen int,
has_face int, 
voiceover int,
audio_source text,
duration_sec int,
likes int,
follows int,
views int,
shares int,
saves int,
average_watch_time_sec int,
account_reached int,
interactions int,
foreign key (topic_id) references topics(topic_id),
foreign key (style_id) references styles(style_id),
foreign key (hook_id) references hooks(hook_id)
)

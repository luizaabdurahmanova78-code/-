select * from audio_cards;
select * from audiobooks;
select * from listenings;

select count(distinct ac.user_id) as added_Coraline, count(distinct users_coraline.user_id)as listened_more_than_10
from audio_cards ac
join audiobooks ab on ac.audiobook_uuid=ab.uuid
left join(select l.user_id, l.audiobook_uuid
from listenings l
join audiobooks ab on ab.uuid=l.audiobook_uuid
where ab.title = 'Coraline'
group by l.user_id, ab.duration, l.audiobook_uuid
Having sum(l.position_to - l.position_from)> 0.1*ab.duration)
as users_coraline on users_coraline.user_id = ac.user_id
where ab.title = 'Coraline';

select l.os_name, ab.title, count(distinct l.user_id), sum(l.position_to - l.position_from)/3600 as total_hours
from listenings l
join audiobooks ab on ab.uuid = l.audiobook_uuid
where l.is_test = 0
group by l.os_name, ab.title;

select ab.title, count(distinct l.user_id)
from listenings l
join audiobooks ab on ab.uuid = l.audiobook_uuid
group by ab.title
order by count(distinct l.user_id) desc
limit 1;


select ab.title, count(distinct l.user_id)
from listenings l
join audiobooks ab on ab.uuid = l.audiobook_uuid
where l.position_to = ab.duration
group by ab.title
order by count(distinct l.user_id) desc
limit 1;
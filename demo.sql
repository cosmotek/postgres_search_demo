create or replace function make_search_document(
	title text,
	description text,
	related_people text[],
	related_subjects text[],
	general_tags text[]
) returns tsvector
	as $search_doc$
	declare
		search_doc tsvector;
	begin
		select
			setweight(to_tsvector('english', title), 'A') ||
			setweight(to_tsvector('english', coalesce(description, '')), 'D') ||
			setweight(to_tsvector('simple', array_to_string(related_people, ' ')), 'B') ||
			setweight(to_tsvector('english', array_to_string(related_subjects, ' ')), 'C') ||
			setweight(to_tsvector('simple', array_to_string(general_tags, ' ')), 'D')
		into search_doc;
		return search_doc;
	end;
	$search_doc$ language plpgsql immutable parallel safe;
	

create table video_content (
	title text not null check (CHAR_LENGTH(title) > 0),
	description text check (CHAR_LENGTH(description) > 0),
	related_people text[] not null default '{}',
	related_subjects text[] not null default '{}',
	general_tags text[] not null default '{}',
	
	search_document tsvector generated always as (make_search_document(
		title,
		description,
		related_people,
		related_subjects,
		general_tags
	)) stored
);


alter table netflix_titles add column search_document tsvector generated always as (make_search_document(
	title,
	description,
	"cast",
	listed_in,
	'{}'
	-- array_cat(country, array_cat(director::text[], array_cat("type"::text[], array_cat((release_year::text)::text[], rating::text[]))))
)) stored;

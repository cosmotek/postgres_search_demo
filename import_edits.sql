-- Use these to convert string-formatted list columns in the import data to postgres arrays
alter table netflix_titles alter COLUMN "cast" type text[] using (string_to_array("cast", ','));
alter table netflix_titles alter COLUMN listed_in type text[] using (string_to_array(listed_in, ','));
alter table netflix_titles alter COLUMN country type text[] using (string_to_array(country, ','));


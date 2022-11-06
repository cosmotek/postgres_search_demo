select * from netflix_titles
	where (to_tsquery('english', 'Angry') @@ search_document 
		or plainto_tsquery('simple', 'Angry') @@ search_document 
		or websearch_to_tsquery('simple', 'Angry') @@ search_document) 
	limit 300;

select count(country), lower(country) from address group by country order by count(country) DESC;

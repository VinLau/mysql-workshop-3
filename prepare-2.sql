select count(*) from entry where substring(contentLineOne,3,1)="3" OR substring(contentLineOne,2,1)="3"; --297
select count(*) from entry where (type="home" AND subtype="phone") AND NOT ((LENGTH(SUBSTRING_INDEX(contentLineOne,'5', 1))) > 1); --16 NB: combined a AND and NOT (which is a negate like !)
SELECT count(*) from entry where substring(contentLineOne,1,1)="1" AND subtype="phone"; -- 200

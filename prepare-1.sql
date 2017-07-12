select count(accountID), accountID FROM addressbook group by accountID order by count(accountID) DESC limit 5; -- companies with accountID 14 and 5 both are tied for top accounts
select count(addressbookID), addressbookID FROM entry group by addressbookID order by count(addressbookID) DESC limit 10; -- the addressbookID 37 has the most entries

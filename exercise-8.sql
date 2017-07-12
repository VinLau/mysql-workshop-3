SELECT count(phone.subtype), phone.subtype FROM phone JOIN entry on phone.entryid = entry.id WHERE entry.birthday > "1950-09-31" AND entry.birthday < "1960-11-01" GROUP BY phone.subtype;
/*
+----------------------+----------+
| count(phone.subtype) | subtype  |
+----------------------+----------+
|                  172 | landline |
|                  139 | cellular |
|                  135 | fax      |
+----------------------+----------+
3 rows in set (0.01 sec)
*/

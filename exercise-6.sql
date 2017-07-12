SELECT phone.content FROM phone JOIN entry on phone.entryid = entry.id WHERE entry.firstName = "Charlotte" AND entry.lastName = "Jenkins";
/*
+----------------+
| content        |
+----------------+
| (110) 167-3420 |
| (605) 175-1334 |
+----------------+
2 rows in set (0.04 sec)
*/

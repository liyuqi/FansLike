origin = LOAD 'Final_Project/FD00_Main_Table/M03_Main_Table/main_table' USING PigStorage(',')
	AS(userID:chararray, username:chararray, sex:chararray, postID:chararray, year:int, month:int, day:int, comment:int, like:int, share:int);

group_by_user_date = GROUP origin BY (userID, year, month);

like_count_by_user_date = FOREACH group_by_user_date GENERATE group.userID, group.year, group.month, COUNT(origin); 

order_by_user_date = ORDER like_count_by_user_date BY userID, year, month;

STORE order_by_user_date INTO 'Final_Project/FD02_User_History/user_like_history' USING PigStorage(',');

origin = LOAD 'Final_Project/FD00_Main_Table/M03_Main_Table/main_table' USING PigStorage(',')
	AS(userID:chararray, username:chararray, sex:chararray, postID:chararray, year:int, month:int, day:int, comment:int, like:int, share:int);

group_by_user = GROUP origin BY userID;

user_like_count_0 = FOREACH group_by_user {
	u_name_bag = LIMIT origin.username 1;
	u_sex_bag = LIMIT origin.sex 1;
	GENERATE group AS userID, u_name_bag, u_sex_bag, COUNT(origin) AS like_count;
}

user_like_count = FOREACH user_like_count_0 GENERATE userID, FLATTEN(u_name_bag), FLATTEN(u_sex_bag), like_count;

STORE user_like_count INTO 'Final_Project/FD01_User_Rank/Static/user_like_count' USING PigStorage(',');

--AS(userID:chararray, ,username:chararray, sex:chararray, like_count:int)

main_table = LOAD 'Final_Project/FD00_Main_Table/M03_Main_Table/main_table' USING PigStorage(',')
	AS(userID:chararray, username:chararray, sex:chararray, postID:chararray, year:int, month:int, day:int, comment:int, like:int, share:int);

post_postedIn_0 = LOAD 'Final_Project/Input/table06_posted_In.csv' USING PigStorage(',')
	AS (postID:chararray, pansciID:chararray, title:chararray, postedIn:chararray);

post_postedIn = FILTER post_postedIn_0 
	BY NOT( (postedIn matches '內容分類') OR (postedIn matches '文章類型') OR 
	(postedIn matches '可供合作單位有償轉載') OR (postedIn matches '可供合作單位無償轉載') OR (postedIn matches '專欄'));

user_postedIn_rawdata_0 = JOIN main_table BY postID, post_postedIn BY postID;

user_postedIn_rawdata = FOREACH user_postedIn_rawdata_0 GENERATE userID, postedIn;

group_user_postedIn = GROUP user_postedIn_rawdata BY (userID, postedIn);

count_user_postedIn = FOREACH group_user_postedIn GENERATE group.userID, group.postedIn, COUNT(user_postedIn_rawdata) AS postedIn_like_count;

STORE count_user_postedIn INTO 'Final_Project/FD04_User_Preference/Static/user_postedIn_count' USING PigStorage(',');


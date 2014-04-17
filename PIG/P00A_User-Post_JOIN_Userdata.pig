-- parameter substitution of input files

user_post = LOAD '$input_01' USING PigStorage(',')
	AS (username_1:chararray, postID:chararray);

user_data_0 = LOAD '$input_02' USING PigStorage(',')
	AS (username_2:chararray, userID:chararray, vtype:int, sex:chararray);

user_data_filtered = FILTER user_data_0 BY vtype != 2;

user_data = FOREACH user_data_filtered GENERATE username_2, userID, sex;

join_by_username = JOIN user_post BY username_1, user_data BY username_2;

up_join_userdata = FOREACH join_by_username GENERATE userID, username_1, sex, postID;

STORE up_join_userdata INTO '$output' USING PigStorage(',');

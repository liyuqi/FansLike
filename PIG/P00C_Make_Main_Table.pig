up_join_userdata = LOAD '$input_01' USING PigStorage(',')
	AS (userID:chararray, username:chararray, sex, postID_1);

post_data = LOAD '$input_02' USING PigStorage(',')
	AS (postID_2:chararray, class:chararray, year:int, month:int, day:int, post_time:chararray, comment:int, like:int, share:int);

--post_to_pansci = LOAD '$input_03' USING PigStorage(',')
--	AS (postID_3:chararray, pansciID:chararray);

--postdata_with_pansciID = JOIN post_data BY postID_2, post_to_pansci BY postID_3;

--up_join_postdata = JOIN up_join_userdata BY postID_1, postdata_with_pansciID BY postID_2;

up_join_postdata = JOIN up_join_userdata BY postID_1, post_data BY postID_2;

main_table = FOREACH up_join_postdata GENERATE userID, username, sex, postID_1, year, month, day, comment, like, share;

STORE main_table INTO '$output' USING PigStorage(',');

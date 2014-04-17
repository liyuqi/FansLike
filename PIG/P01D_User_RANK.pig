origin = LOAD 'Final_Project/FD01_User_Rank/Static/user_like_count' USING PigStorage(',')
	AS(userID:chararray, username:chararray, sex:chararray, like_count:int);

user_order = ORDER origin BY like_count DESC;

user_rank = RANK user_order;

rmf Final_Project/FD01_User_Rank/Dynamic/user_rank;

STORE user_rank INTO 'Final_Project/FD01_User_Rank/Dynamic/user_rank' USING PigStorage(',');

--AS(rank:int, userID:chararray, like_count:int)
--hadoop fs -cat Final_Project/FD01_User_Rank/Dynamic/user_rank | head
--hadoop fs -rm -r Final_Project/FD01_User_Rank/Dynamic/user_like_count/

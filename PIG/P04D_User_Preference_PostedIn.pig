register 'myudf.py' using jython as myudf;
origin = LOAD 'Final_Project/FD04_User_Preference/Static/user_postedIn_count' USING PigStorage(',')
	AS(userID:chararray, postedIn:chararray, postedIn_like_count:int);

user_group = GROUP origin BY userID;

result1 = FOREACH user_group {
           postedIn_order = ORDER origin BY postedIn_like_count DESC;
           ranked = myudf.enumerate_bag(postedIn_order);
           GENERATE ranked AS record: {(rank_num:int, uID:chararray, pIN:chararray, pCNT:int)};
        };
-- note we need to this additional line to explode bag.
result2 = FOREACH result1 GENERATE FLATTEN(record);

result3 = FILTER result2 BY rank_num<=10;

other_postin = FILTER result2 BY rank_num>10;

other_group = GROUP other_postin BY uID;

other_count = FOREACH other_group GENERATE 11 AS other_rank_num,group,'other'AS other_label,SUM(other_postin.pCNT) AS post_sum;

--UNION slow!!
postin_top = UNION result3, other_count;

postin_top_order = ORDER postin_top BY $1,$0 ASC;

rmf Final_Project/FD04_User_Preference/Dynamic/user_preference_postedIn;
STORE postin_top_order INTO 'Final_Project/FD04_User_Preference/Dynamic/user_preference_postedIn' USING PigStorage(',');

/* 
DUMP postin_top_order;

real	4m9.594s
user	0m50.355s
sys	0m23.427s


(4,1079981347,other,12)
(1,1079981347,專欄,3)
(2,1079981347,可供合作單位有償轉載,3)
(3,1079981347,人體解析,2)

(2,1130386376,可供合作單位有償轉載,1)
(3,1130386376,人體解析,1)
(1,1130386376,萬物之理,1)

(4,114408138623539,other,47)
(1,114408138623539,可供合作單位有償轉載,12)
(2,114408138623539,自然生態,11)
(3,114408138623539,動物世界,9)



*/
--AS(userID:chararray, postedIn:chararray, postedIn_like_count:int)

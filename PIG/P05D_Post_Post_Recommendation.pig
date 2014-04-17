register 'myudf.py' using jython as myudf;
origin = LOAD 'Final_Project/FD05_PanSci_Post_Post_Recommendation/Static/common_like_weight' USING PigStorage(',')
	AS (pansciID_1:chararray, title_1:chararray, pansciID_2:chararray, title_2:chararray, weight:int);

post_group = GROUP origin BY pansciID_1;

result1 = FOREACH post_group {
           post_order = ORDER origin BY weight DESC;
           ranked = myudf.enumerate_bag(post_order);
           GENERATE ranked AS record: {(rank_num:int, p1:chararray, t1:chararray, p2:chararray, t2:chararray, pw:int)};
        };
-- note we need to this additional line to explode bag.
result2 = FOREACH result1 GENERATE FLATTEN(record);

result3 = FILTER result2 BY rank_num<=10;


rmf Final_Project/FD05_PanSci_Post_Post_Recommendation/Dynamic/pansci_post_recommondation_list;
STORE result3 INTO 'Final_Project/FD05_PanSci_Post_Post_Recommendation/Dynamic/pansci_post_recommondation_list' USING PigStorage(',');

--DUMP post_rank;
--post_filter = FILTER post_group BY $0<$0+6;

--DUMP post_filter;


--post_post_rawdata_filtered = FILTER post_post_rawdata BY (postID_1 != postID_2);

--post_post_pair = GROUP post_post_rawdata_filtered BY (postID_1, postID_2);

--post_post_weight = FOREACH post_post_pair GENERATE group.postID_1, group.postID_2, COUNT(post_post_rawdata_filtered) AS weight;

--rmf Final_Project/FD05_Post_Post_Recommendation/Static_PP_Weight

--STORE post_post_weight INTO 'Final_Project/FD05_Post_Post_Recommendation/Static_PP_Weight' USING PigStorage(',');
-- AS (postID:chararray, Recommend_postID:chararray, weight);

--hadoop fs -cat Final_Project/FD05_Post_Post_Recommendation/Static_PP_Weight/part-* | head
--hadoop fs -cat Final_Project/FD05_Post_Post_Recommendation/Dynamic_PP_Weight/part-* | head

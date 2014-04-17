user_post = LOAD 'Final_Project/FD00_Main_Table/M03_Main_Table/main_table' USING PigStorage(',')
	AS(userID:chararray, username:chararray, sex:chararray, postID_1:chararray, year:int, month:int, day:int, comment:int, like:int, share:int);

post_to_pansci = LOAD 'Final_Project/Input/table05_post_to_pansci.csv' USING PigStorage(',')
	AS(postID_2:chararray, pansciID:chararray, title:chararray);

user_pansci_0 = JOIN user_post BY postID_1, post_to_pansci BY postID_2;

user_pansci = FOREACH user_pansci_0 GENERATE userID AS userID_1, pansciID AS pansciID_1;

pansci_user = FOREACH user_pansci_0 GENERATE pansciID AS pansciID_2, userID AS userID_2;

pansci_pansci_rawdata = JOIN user_pansci BY userID_1, pansci_user BY userID_2;

post_post_rawdata_filtered = FILTER pansci_pansci_rawdata BY (pansciID_1 != pansciID_2);

post_post_pair = GROUP post_post_rawdata_filtered BY (pansciID_1, pansciID_2);

post_post_weight = FOREACH post_post_pair GENERATE group.pansciID_1, group.pansciID_2, COUNT(post_post_rawdata_filtered) AS weight;


--Make the title of pansci article unique
pansci_title_0 = FOREACH post_to_pansci GENERATE pansciID, title;

pansci_title_1 = GROUP pansci_title_0 BY pansciID;

pansci_title_2 = FOREACH pansci_title_1 {
	title_bag = LIMIT pansci_title_0.title 1;
	GENERATE group AS pansciID, title_bag;
}



pansci_title_unique = FOREACH pansci_title_2 GENERATE pansciID, FLATTEN(title_bag) AS title;

post_post_weight_with_title_1 = JOIN pansci_title_unique BY pansciID, post_post_weight BY pansciID_1;

post_post_weight_with_title_1_and_title_2 = JOIN pansci_title_unique BY pansciID, post_post_weight_with_title_1 BY pansciID_2;
 
result = FOREACH post_post_weight_with_title_1_and_title_2 GENERATE pansciID_1, $3 AS title_1, pansciID_2, $1 AS title_2, $6 AS weight;

STORE result INTO 'Final_Project/FD05_PanSci_Post_Post_Recommendation/Static/common_like_weight' USING PigStorage(',');
-- AS (pansciID_1:chararray, title_1:chararray, pansciID_2:chararray, title_2:chararray, weight:int);















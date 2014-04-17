origin = LOAD 'Final_Project/FD00_Main_Table/M03_Main_Table/main_table' USING PigStorage(',')
	AS(userID:chararray, username:chararray, sex:chararray, postID_1:chararray, year:int, month:int, day:int, comment:int, like:int, share:int);

post_to_pansci = LOAD 'Final_Project/Input/table05_post_to_pansci.csv' USING PigStorage(',')
	AS(postID_2:chararray, pansciID:chararray, title:chararray);

origin_with_pansci = JOIN origin BY postID_1, post_to_pansci BY postID_2;

group_by_pansci_and_sex = GROUP origin_with_pansci BY (pansciID, sex);

pansci_like_count_by_sex = FOREACH group_by_pansci_and_sex GENERATE group.pansciID, group.sex, COUNT(origin_with_pansci);

pansci_likeCount_male = FILTER pansci_like_count_by_sex BY sex matches 'male';

pansci_likeCount_female = FILTER pansci_like_count_by_sex BY sex matches 'female';

pansci_likeCount_male_female_0 = JOIN pansci_likeCount_male BY pansciID, pansci_likeCount_female BY pansciID;

post_likeCount_male_female = FOREACH pansci_likeCount_male_female_0 
	GENERATE $0 AS pansciID_1, $1 AS male, $2 AS male_count, $2/(float)($2+$5) AS male_ratio, 
					$4 AS female, $5 AS female_count, $5/(float)($2+$5) AS female_ratio, ($2+$5) AS total_like;

pansci_to_title_unique_0 = GROUP post_to_pansci BY pansciID;

pansci_to_title_unique_1 = FOREACH pansci_to_title_unique_0 {
	title_bag = LIMIT post_to_pansci 1;
	GENERATE group AS pansciID, title_bag;
}

pansci_to_title_unique = FOREACH pansci_to_title_unique_1 GENERATE pansciID, FLATTEN(title_bag.title) AS pansci_title;

result_0 = JOIN post_likeCount_male_female BY pansciID_1, pansci_to_title_unique BY pansciID;

result = FOREACH result_0 GENERATE pansciID, pansci_title, male, male_count, male_ratio, female, female_count, female_ratio, total_like;

STORE result INTO 'Final_Project/FD03_Post_Likecounts_by_Sex/post_likecounts_by_sex' USING PigStorage(',');













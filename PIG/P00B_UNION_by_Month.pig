inputdata_01 = LOAD '$input_01' USING PigStorage(',');

inputdata_02 = LOAD '$input_02' USING PigStorage(',');

outputdata = UNION inputdata_01, inputdata_02;

rmf $output;

STORE outputdata INTO '$output' USING PigStorage(',');

rm $input_01;

mv $output $input_01;

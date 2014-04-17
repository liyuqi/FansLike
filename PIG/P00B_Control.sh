#!/bin/bash
read -p "Enter the starting year: " stryear
read -p "Enter the starting month: " strmonth
read -p "Enter the ending year: " endyear
read -p "Enter the ending month: " endmonth

year=$stryear
month=$strmonth

while [ $year -lt $endyear ]
do
   while [ $month -le 12 ]
   do 
      pig -param input_01=Final_Project/FD00_Main_Table/M02_UNION_UP_Userdata_All_Month/present_data\
      -param input_02=Final_Project/FD00_Main_Table/M01_UP_JOIN_Userdata_by_Month/${year}_${month}\
      -param output=Final_Project/FD00_Main_Table/M02_UNION_UP_Userdata_All_Month/temp\
      ./P00B_UNION_by_Month.pig      

      month=$(($month+1))
   done
   year=$(($year+1))
   month=1
done

while [ $year -eq $endyear ]
do
   while [ $month -le ${endmonth} ]
   do 
      pig -param input_01=Final_Project/FD00_Main_Table/M02_UNION_UP_Userdata_All_Month/present_data\
      -param input_02=Final_Project/FD00_Main_Table/M01_UP_JOIN_Userdata_by_Month/${year}_${month}\
      -param output=Final_Project/FD00_Main_Table/M02_UNION_UP_Userdata_All_Month/temp\
      ./P00B_UNION_by_Month.pig

      month=$(($month+1))
   done
   year=$(($year+1))
   month=1
done


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
      pig -param input_01=Final_Project/Input/table02_uplE/table02_uplE_${year}_${month}.csv\
      -param input_02=Final_Project/Input/table04_uplV/table04_uplV_${year}_${month}.csv\
      -param output=Final_Project/FD00_Main_Table/M01_UP_JOIN_Userdata_by_Month/${year}_${month}\
      ./P00A_User-Post_JOIN_Userdata.pig

      month=$(($month+1))
   done
   year=$(($year+1))
   month=1
done

while [ $year -eq $endyear ]
do
   while [ $month -le ${endmonth} ]
   do 
      pig -param input_01=Final_Project/Input/table02_uplE/table02_uplE_${year}_${month}.csv\
      -param input_02=Final_Project/Input/table04_uplV/table04_uplV_${year}_${month}.csv\
      -param output=Final_Project/FD00_Main_Table/M01_UP_JOIN_Userdata_by_Month/${year}_${month}\
      ./P00A_User-Post_JOIN_Userdata.pig

      month=$(($month+1))
   done
   year=$(($year+1))
   month=1
done


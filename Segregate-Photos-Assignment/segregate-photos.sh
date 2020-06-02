#!/bin/bash

sampledirectory=$(ls ./Photos)
totalcount=$(ls ./Photos | wc -l)
echo "Total photos: $totalcount"
if [ -d ./segregated-photos ]
then
	rm -rf segregated-photos
fi
mkdir ./segregated-photos
cd Photos
cp * ../segregated-photos
cd ..
currcount=0
for entry in $sampledirectory
do
	nameincaps=$(echo ${entry^^})
	if [ $nameincaps != "README.MD" ]
	then
		year=$(echo $entry | cut -d'-' -f 1)
		month=$(echo $entry | cut -d'-' -f 2)
		photoNum=$(echo $entry | cut -d'-' -f 3)
		newname="Photo$photoNum"
		newdirectory=$(echo "$year/$month")
		cd Photos
		mkdir -p ./$year/$month
		mv "$entry" "./$newdirectory/$newname"
		cd ..
	fi
	((currcount=currcount+1))
	((percent=currcount*100/totalcount))
	#echo "$percent complete..."
	echo -en "\r$percent% Complete..."
done
mv segregated-photos photos-copy
mv Photos segregated-photos
mv photos-copy Photos
echo -e "\nPhotos have been segregated"

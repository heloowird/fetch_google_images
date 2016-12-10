#!/bin/sh

base_url="http://www.google.com.hk/searchbyimage?"

function random()
{
	min=$1
	max=$2
	((margin=max-min))
	num=$(date +%s+%N)
	((ret_num=num%margin+min))
	return $ret_num
}

function wget_google_page()
{
	url=$1
	local_dest_file=$2
	for i in `seq 0 2`
	do
		echo $url 1>&2
		wget -Y on -e "http_proxy=[your_proxy]" --user-agent="[your_user_agent]" --tries=3 -O $local_dest_file $url
		if [ $? -eq 0 ]
		then
			break
		fi
	done
}

target_data_dir="./google_image_same_pages"
if [ ! -d $target_data_dir ]
then
	mkdir $target_data_dir
fi

while read line
do
	image_url=`echo "$line" | awk -F'\t' '{print $1}'`
	index=`echo "$line" | awk -F'\t' '{print $2}'`
	
	for i in `seq 0 2`
	do
		start=`echo "$i*10" | bc`
		url="${base_url}start=${start}&image_url=${image_url}"
		local_filename="${target_data_dir}/${index}_${i}.html"
		wget_google_page $url $local_filename
		random "7" "13"
		sleep $?
	done		
done < $1

#!/bin/sh

base_url="http://www.google.com.hk/search?biw=758&bih=643&site=imghp&tbm=isch&sa=1&"

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

target_data_dir="./google_image_search_pages"
if [ ! -d $target_data_dir ]
then
	mkdir $target_data_dir
fi

while read line
do
	query=`echo "$line" | awk -F'\t' '{print $1}'`
	index=`echo "$line" | awk -F'\t' '{print $2}'`
	query=`echo "$query" | awk -F' ' '{a="";for(i=1;i<=NF;i++){if($i != " ")a=a"+"$i;}print substr(a, 2)}'`
	
	url="${base_url}q=${query}&op=${query}"
	local_filename="${target_data_dir}/${index}.html"
	wget_google_page $url $local_filename
	random "7" "13"
	sleep $?
done < $1

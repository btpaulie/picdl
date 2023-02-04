#!/bin/bash

#Download page as HTML
read -p "URL to download from" URL1
wget $URL1 \ -O page.html -O page.html

#Extract URLs, add to text file
grep -E "(https?:)?//[^/\s]+/\S+\.(jpg|png|gif|svg)" page.html -o | 
sed "s/(^https?)?\/\//https\:\/\//g" -r > urls.txt

#Download images by URLs listed in the file
sed -E "s/\/thumb//g; s/\/[0-9]+px-.+\.(jpg|png)$//g" urls.txt |
uniq > urls-new.txt

#Restart the download
wget -i urls-new.txt -P downloads_full_size/

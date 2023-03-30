#!/bin/bash

configFile="./ios/configs/buildConfig.plist"

configHash=`git rev-parse --short HEAD`
currentHash="default"

if [ -f "$configFile" ]; then
    currentHash=$(/usr/libexec/PlistBuddy -c "print :GIT_SHA" $configFile)
fi

echo "$currentHash and $configHash" 

# if [ "$currentHash" == "$configHash" ]; then
#     echo "No Need Check Image"
#     exit 0
# fi

SEARCH_PATH=$PWD

#临时文件存储未排序结果
TEMP="unsorted_image_temp"
rm -rf $TEMP

# 搜索目标文件 （-type f 普通文件 -name '*.gif' 名字后缀为gif的文件 -o 或者 or）
find $SEARCH_PATH -type f -name '*.gif' -o -name '*.jpg' -o -name '*.JPG' -o -name '*.png' -o -name '*.PNG' -o -name '*.jpeg' -o -name '*.JPEG' | while read file;
do

  # 开始处理每一张图片

  # 获取图片size (stat 查看状态 -f 按指定format打印  %后边跟z表示size)
  size=`stat -f %z $file`
  # 把图片大小转换成kb,保留三位小数点
  sizekb=`echo "$size 1024.0" | awk '{printf "%.3f", $1 / $2}'`
  echo $file,$sizekb
  line="<a href=\"$file\">$file</a> ( $sizekb kb ) <br>"

  # 把每张图片信息写进临时文件
  echo $line >> $TEMP

done

# 根据图片大小进行排序 （-t " " 以空格作为分隔符 -n 以数字大小排序 -r 逆序排列 -k 4 以第四栏作为sort_key）
files=`cat $TEMP | sort -t " " -nr -k 4`
# 计算图片数量
count=`echo $(cat $TEMP | wc -l)`
# 计算图片总大小 (awk 命令，以空格分割，第4栏的累计之和)
total_size_kb=`awk -F ' ' '{sum += $4} END {print sum}' $TEMP`

rm -rf $TEMP

# 把结果打印到html文件，方便使用浏览器查看，且可以点击a标签直接查看图片
HTML="sorted_images_list.html"
rm -rf $HTML

# /usr/libexec/PlistBuddy -c "Add :TOTAL_IMAGE_NUM string $count" "$configFile"
# /usr/libexec/PlistBuddy -c "Add :TOTAL_IMAGE_SIZE string $total_size_kb" "$configFile"
#
echo "<html>\n<h1> Sorted images by Zhiyunyu</h1>" >> $HTML
echo "<body>" >> $HTML
echo "<h2>There are $count images (total size: $total_size_kb kb)</h2>" >> $HTML
echo "<pre>\n$files\n</pre>" >> $HTML
echo "</body>\n</html>" >> $HTML
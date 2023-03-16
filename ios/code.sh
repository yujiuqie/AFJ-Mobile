#创建一个集合存放遍历出来的数据
zip_list=()
controller_tar(){
 for file in `ls  指定文件夹的绝对路径`
 do
 #贪婪匹配文件后缀名是否为zip或者gz
    if [ "${file##*.}"x = "zip"x ]||[ "${file##*.}"x = "gz"x ]
    then
    #如果符合条件将文件放入集合中
        zip_list[${#zip_list[*]}]=${file}
    fi
 done
}
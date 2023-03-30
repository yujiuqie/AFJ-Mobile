#!/bin/bash

configFile="./ios/configs/buildConfig.plist"

configHash=`git rev-parse --short HEAD`
currentHash="default"

if [ -f "$configFile" ]; then
    currentHash=$(/usr/libexec/PlistBuddy -c "print :GIT_SHA" $configFile)
fi

echo "$currentHash and $configHash" 

if [ "$currentHash" == "$configHash" ]; then
    echo "No Need Check Code"
    exit 0
fi

rm -rf $configFile

configDate=`date +%Y-%m-%dT%H:%M:%S%z`
echo $configDate
/usr/libexec/PlistBuddy -c "Add :BUILD_TIME string $configDate" "$configFile"

/usr/libexec/PlistBuddy -c "Add :GIT_SHA string $configHash" "$configFile"

my_array=("h" "m" "swift" "c" "java" "mm" "cpp" "js" "py")
totalCodeLine=0
for code in ${my_array[*]}
do
    codeFileNum=`find . -name "*.${code}"|wc -l`
    /usr/libexec/PlistBuddy -c "Add :{$code}_FILE_NUM string $codeFileNum" "$configFile"
    mCodeNum=`find . -name "*.${code}"|xargs cat|wc -l`
    /usr/libexec/PlistBuddy -c "Add :{$code}_CODE_NUM string $mCodeNum" "$configFile"
    totalCodeLine=$[totalCodeLine+$mCodeNum]
done
echo $totalCodeLine
/usr/libexec/PlistBuddy -c "Add :TOTAL_CODE_NUM string $totalCodeLine" "$configFile"

fileNum=`ls -lR|grep "^-"|wc -l`
echo $fileNum
/usr/libexec/PlistBuddy -c "Add :TOTAL_FILE_NUM string $fileNum" "$configFile"

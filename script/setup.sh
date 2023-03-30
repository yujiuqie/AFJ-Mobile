#!/bin/bash

nodeVersion=`node -v`

if [ $nodeVersion != 'v18.15.0' ]; then
	echo "node version Error, should be v18.15.0"
	echo $nodeVersion
	exit 0
fi

rubyVersion=`ruby -v`

if [[ $rubyVersion != "ruby 2.7.6"* ]]; then
	echo "ruby version Error, should be v2.7.6"
	echo $rubyVersion
	exit 0
fi

rootPath=$PWD

rm -rf node_modules

echo "Step 1 : init React Native"

cd ReactNative/RNSample/

rm -rf node_modules
npm install
cp -rf node_modules $rootPath

cd $rootPath

echo "Step 2 : init and setup Flutter"
cd ./Flutter/afjflutter
fvm flutter clean
fvm flutter pub get
fvm flutter build ios --release --no-codesign

cd $rootPath

echo "Step 3 : setup CocoaPods"
cd ./ios/
rm -rf Pods
pod install

echo "Step 4 : clean build"
cd $rootPath
cd ios
xattr -w com.apple.xcode.CreatedByBuildSystem true $PWD/build
xcodebuild clean

echo "Step 5 : open Xcode"

open AFJ-iOS.xcworkspace

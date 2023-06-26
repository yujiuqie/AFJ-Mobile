#!/bin/bash

nodeVersion=`node -v`

if [ $nodeVersion != 'v18.15.0' ]; then
	echo "Node version Error, should be v18.15.0. Please install nvm and run 'nvm alias default 18.15.0' to use the correct version"
	echo $nodeVersion
	exit 0
fi

rubyVersion=`ruby -v`

if [[ $rubyVersion != "ruby 2.7.6"* ]]; then
	echo "Ruby version Error, should be v2.7.6. Please install rvm and run 'rvm use 2.7.6 --default' to use the correct version"
	echo $rubyVersion
	exit 0
fi

rootPath=$PWD

rm -rf node_modules

echo "Step 1 : init React Native"

cd ./ReactNative/RNSample/

rm -rf node_modules
npm install
cp -rf node_modules $rootPath

cd $rootPath

echo "Step 2 : init and setup Flutter"
cd ./Flutter/FlutterUnit
fvm use 3.10.1
fvm flutter channel stable
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
xcodebuild -workspace AFJ-iOS.xcworkspace -scheme AFJ-iOS-Debug -configuration Debug -destination 'platform=iOS Simulator,OS=16.4,name=iPhone 14'

echo "Step 5 : open Xcode"

open AFJ-iOS.xcworkspace

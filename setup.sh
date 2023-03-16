#!/bin/bash

rootPath=$PWD

#TODO::判断工具是否安装，判断版本

echo "Step 1 : init React Native"

cd ReactNative

rm -rf node_modules
yarn install

cd $rootPath

echo "Step 2 : init and setup Flutter"
cd ./Flutter/afjflutter
flutter clean
flutter pub get
flutter build ios --release --no-codesign

cd $rootPath

echo "Step 3 : setup CocoaPods"
cd ./ios/
rm -rf Pods
pod install

echo "Step 4 : setup React Native"
cd $rootPath
cd ReactNative
mkdir ios
cp -r ../ios/AFJ-iOS.xcworkspace ../ReactNative/ios
cp -r ../ios/AFJ-iOS.xcodeproj ../ReactNative/ios
cp -r ../ios/Podfile.lock ../ReactNative/ios
cp -r ../ios/assets ../ReactNative/ios
npm run env -- prod
npm run build
npm run ios-build
rm -r ios

echo "Step 5 : open Xcode"
cd $rootPath
cd ios
# xattr -w com.apple.xcode.CreatedByBuildSystem true $PWD/build
# xcodebuild clean
open AFJ-iOS.xcworkspace

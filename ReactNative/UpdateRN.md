升级目标：
nvm 升级 node 至 18.15.0
rvm 升级 ruby 至 2.7.6
基于 2.7.6 brew 重新安装 cocoapods ： https://www.jianshu.com/p/ec1e1a34d3d1

sudo gem install cocoapods

m1 rvm install 2.7.6 error : cannot load such file -- openssl

检查 openssl 是否正确安装

brew install openssl@1.1

重启终端后执行：
rvm reinstall 2.7.6 --with-openssl-dir=`brew --prefix openssl@1.1`

创建基于最新版本的 RN 多 Demo ： https://www.twle.cn/c/yufei/reactnative/reactnative-basic-createproject.html

执行以下创建命令前需要先确保根目录没有 node_modules
npx react-native init RNSample
npx react-native init RNSample1
npx react-native init RNSample2

react-native bundle --entry-file='index.js' --bundle-output='../../ios/rn-sample-1.jsbundle' --dev=false --platform='ios' --assets-dest '../../ios'

react-native bundle --entry-file='index.js' --bundle-output='../../ios/rn-sample-2.jsbundle' --dev=false --platform='ios' --assets-dest '../../ios'

LBXScan、LBXZBarSDK 中 error.h 文件冲突

不同工程的依赖不同，需要保证相同的依赖使用同一版本

RNSample 中补充新增的依赖

Podfile 中补充新增的 pod

import InteractionManager from 'react-native/Libraries/Interaction/InteractionMixin'
import InteractionManager from 'react-native/Libraries/Interaction/InteractionManager'

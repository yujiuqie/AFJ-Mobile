# 广告封装  AdvertiseCountDown   AdvertiseGradient

### 使用

[AdvertiseGradientNSObject initAdvertise:@[@"https://xxx.xxx.com/static/images/welcome.jpg"]];

[AdvertiseCountDownNSObject initAdvertise:@[@"https://xxx.xxx.com/static/images/welcome.jpg"]];

### 说明

首先说一下整个文件的逻辑。调用的时候我们可以传一个url数组进去，传递进去之后，AdvertiseGradientNSObject文件负责获取广告图片的路径，把获取到的广告图片路径传递到AdvertiseGradientView里面，加载图片的时候是通过路径来获取保存好的图片的。([UIImage imageWithContentsOfFile:filePath]
；)

再说一个AdvertiseGradientNSObject文件的逻辑。
首先把广告url数组传递进来。然后判断本地文件是否获取到对应的图片路径，如果获取到就把图片路径传递到view里面把广告图片显示出来。无论是否获取成功广告图片路径，都会把传递进来的url数组的网络地址加载一次图片，把新的图片替换掉旧的图片。不过他下载图片只会 **
随机** 抽取数组中的一个url去下载。下载完就替换旧的图片。
1.如果广告图需要自己按顺序播放的话是满足不了需求的。
2.BUG.如果url数组的地址里面的图片全部更新了。随机获取一张加载之后进行替换的话，其他图片还是旧的。有可能显示还是旧的

另外说一下：
AdvertiseGradientNSObject的这个封装是广告图片倒计时的效果来的。我还封装了一个AdvertiseCountDownNsObject的广告封装。它的效果是3秒显示图片放大渐变效果的。两个文件的NsObject的原理完全是一样的。只是view的显示效果不一样而已。这两个封装都是传递url进去加载图片的，有些需求是直接传递data图片二进制(
获取string 本地图片名称 比较小)
，因为App启动的时候，3秒显示很快，如果用url网络加载慢的话，界面会一偏空白，所以我觉得应该把URL数组的图片下载下来转换成图片二进制保存到本地。然后按顺序取也可以，随机取也可以。这个等后期更新












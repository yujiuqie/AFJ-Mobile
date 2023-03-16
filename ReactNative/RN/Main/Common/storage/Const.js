import {Dimensions, PixelRatio, Platform} from 'react-native';
import DeviceInfo from 'react-native-device-info';

const {width, height, scale} = Dimensions.get('window');

export const Const = {
    screenWidth: width,//屏幕宽
    screenHeight: height,//屏幕宽
    screenScale: scale,//屏幕分辨率
    onePixel: 1 / PixelRatio.get(),//一个像素尺寸
    isIos: Platform.OS === 'ios',
    isAndroid: Platform.OS === 'android',
    package: DeviceInfo.getBundleId,//包名(后台指定)
};

export const Colors = { //App通用颜色
    black: '#000000',
    white: '#FFFFFF',
    theme: '#FFE102',   //App主题颜色
    yellow: '#F79A17',  //按钮等颜色
    blue: '#007AFF',    //按钮等颜色
    red: '#FF1D1D',
    text: '#000000',    //默认字体颜色
    text_light: '#15161B',
    text_lighter: '#545454',
    text_disable: '#7F7F7F',
    text_hint: '#C8C8C8',
    split_line: '#D0D0D1',//分割线色值
    disable: '#F4F4F5',   //不可用颜色
    page_bg: '#F5F5F5',   //默认页面背景色
    transparent: 'transparent',
};

export const CommonStyles = {
    container: {//默认页面背景样式
        flex: 1,
        backgroundColor: Colors.page_bg,
    },
    topLine: {//底部分割线
        borderTopWidth: Const.onePixel,
        borderTopColor: Colors.split_line,
    },
    bottomLine: {//顶部分割线
        borderBottomWidth: Const.onePixel,
        borderBottomColor: Colors.split_line,
    },
};

export const ImageRes = {
    img_back: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAABNElEQVRoQ+3Z0Q2CQAzGcRjNEXiQeZxHHsoITuE6mEsgMQRpe23T7yI+n/r/US/hpO8af/WN93cXIHuCoRMYhuFegEQ0RUHDAGv8cw0foxAhgF38dvFDEO6AH/FhCFcAEz8R0ei9F9wAGfHlYrgAsuJdAJnxZkB2vAmAEF8NQImvAiDFqwFo8SoAYrwYgBovAiDHswD0+FMAF78sy9v7xkzyefM8P77XHd4LMfGS74la8yKi2ykAOL50/wGgMIGnwE9g+301vYmliIgjonb3sycybhLZCBYg2BMhh3XpJEQAZIQYgIpQARARagAaogqAhKgGoCBMAASEGZCNcAFkItwAWQhXgADh/pTGHXCCcI9n/5WQ3lAdrWv6Id/uPNHmY1bL9DTvDdkDmgDr2gtgvYLW938AbPvOMUnWnD0AAAAASUVORK5CYII=',
    login_logo: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAcIAAAHCCAYAAAB8GMlFAAAAAXNSR0IArs4c6QAAQABJREFUeAHtnQecXFW9x//nzsy29IS0zZbQgwGpgopEQhGkhF5siKIo0vTZUSQggs+niD59FkAQsREpUkVaQJpAMJRQAyS7m03vm2yZct7vzGazbWbunZk7M7f87uczO3dO+Z///3vu3v89554iwoMESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAESIAEykZA67lW2QpjQSRAAmkCihxIgASKJ6D1LtXS0jZNVKJBlG4QwSdl4bceC+lj0h+te78VfmsZiTBLFD6Cvzr9jdP0rwR+dyC0A99bEN17LrIescshu12UwjfOldUuurZFNW5aZ7LyIAESyJ8AHWH+zJgjpAS03j8my1/eRZLJPURr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JyLWGXjYOdsMluhLN/C7SXa83+TBCOBB9Yk8u6Er7ecD0xZyPkYmPAP5WxbLaz/sGyBViBwneWpkxKMoa223dFzVO4LXSS5naQYOPHGWY3CqQjlk+l9bLi27wc437P7X8HDTCi3wcJD6KbrV5w3WiL9IgAS2E8A7hP3xAn0hPhhlprbgEzcv27cnyHCCm6TCgIpzayV2oBnaPV7Gj4YzPQ9P7c0Zkg8KgnxtBsj0BSLfb0xY3+9s34XomU3W0PDewSnq30PD7X7D3h3xLu0ufFbisxg3yz8N33ndTsrw+EIHy4Dj8+A5qHvX1A90W1UtkSGt3f5yTWsL+b42USaONOnB+gDU76f7UxR3hgFUe0OHh6HfWnzMNYaPlbGF2lcS0uQ9WMbkxTX5fuQ1A7c29JajOuzK6isz1zf4fD1XvJO4Qjhk+V/7Uq7/td7BMtY1RifofQE4dJjpQeb/FOe2/2tObGEaEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEshF4P8BSzIj/S41S+QAAAAASUVORK5CYII=',
    mine_setting: 'data:image/png;base64,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',
    mine_focus_shop: 'data:image/png;base64,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',
    right_arrow: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAB90lEQVRoQ+3ZW0oDMRQG4GSWo/ux4y4KXYCuoMlkGSKKiFfEu4hXRHwRUYooRRFRSkFsO5GBUyjiCTRzTkqwfW47/5fzZzqdkSLyl4w8vxgDRj3B/z2BWq020el0EmPMzagm4T2BInyv15sTQiTW2jTLsutRILwAA+EnIfStECLVWl+FRngBqtXqrBBi5lfYuzzPp40xFyERXoAiIIJ4gDqdhUJ4AxyIBiBOQiBKARyIR9gTx9yI0gAH4jnP89QYc8iJIAE4EE2o0z4XggzgQLwKISpa610OBCnAgXgDxDY1ghzgQLxLKStKqS1KBAvAgfi01layLNugQrABHIgW1GmNAsEKcCDagFgpi2AHYAhr7VeSJFNKqeUyiCAAxyS+pZQFYskXEQzgQHShTgs+iKAAR51sMQmt9fywiDFgmBVD/kN0YR8sDvNd/fcGmwASPo5N/Ff4aE6jyMq3i9+Aer2+6lObwc+wVggJ34LOr5cNX3yeDYCE/4Ar0k2K8GwAJHwcl9NI+Dfo/A7VyrOcRpHwL1CbPerwpBVCwjch/AFHeDIAEv4J7g0dcYUnASDh47ixhYRvQG1OOVe+9CZGwt9LKVOl1HmI8N4Vwm6vQ+cvQ4X3BkT/gKOQR/2IqV+RqB/yhey561hsV6OhgGNAqJXGjhP9BH4APm0UQBm6dbsAAAAASUVORK5CYII=',
    search_icon: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAABBNJREFUWAntV01IVFEUnufMJINRkKToRkSwaNE2dxVEiIYLSRctBs0ZUekHW5REPxsXtRAixdFEQd2ESJS4aZWrwqJNi6SFG0El0UBhxpm0mb5P3xneu/Pem59mFoEX7pxz7z3nu98777x7z7hcR+0/i4CWDd+JiYnT0Wi0AT6NmqadhaxAP4G+kUgk1jG3CH2+qqpqoaGhIQY965YRofHx8cpYLPYYG3ZgY2+6XWD3Ezb9paWlr1pbW3+nszeupyU0PDwcgMNLdJ/JUdMiGK+j76CXgWg5pAc92UBs2ePxNAeDwW/JyTSKLaGZmRn31tbWC2x0SzCwwTb0UFFR0dvOzs4vGMdlbWpqqiQSiVyB/Q3MtUAKdhj2/q6urjdi6yTFKcUmFAoNKmSGvF7v00Ag8CvFWJkYGxs7v7+/Pwr/Oi6B+B+Ixu7u7veKacrQkpD+msZ06xgAgwCbTvF2mECEjyHCJNVGM0YX+oWenp4fDm6uInWRCYw55sxBy4UMHZnMeE034T/LMcichAhRd2ophPg1weEggQE2lG1kjJvBP1FSUtIGKVG5PDo62mi0UXUTIZ4zcO6gEeQ2c0Z1yHbs9/vDwHoofvF4/J7oVtJEiIceQivnTCiTBLYCVef0L2xJn7/IB1dtZGwihMlkOPlpi1Ge5Bxx8MBupMVVO0wTIYSW1wFfV4TnjJ1TLvPA/CB+IFUruipNhLBYoRvwXkoeeqpTjuNV8QN2teiqVAnxomTbORT5+0UKJDERIcvzj7uphDZ0CmX5o3KIBBJJTEQobIdvIgQnXpZMvHLeTXZOOc7XiB/wV0RXpYkQmLOeYfPwojxU8/MLEvWC5Ha7P4muShMhLM6LAQB4a+el4V47DqAmHSzs8/k+2wGbCLHSQ5RYXLG18NY+VP/tF5dsLx7wlI4yzdPbDtFESC87+2kMAI0lBG9tO+dM5kdGRs4B675uG8fXNujkZyJEQ5adiNIydQDVbW5ujpAcx9m2ycnJUvjyhOYrc4HMAK6R7044lhvxVe3t7X2E48GXBoKzvLWdQq1uokdmDoTk61pD7tS0t7dHVVvjOCVCXGQNjKfxgwgrPUbqejgc/opNmjl2akxgFHiPcKsvGsjQpXJ3d/euky/XLCMkTiBQD9DX6CyupC2B6DsMFtBXeQJjnYdeDSQ/7SZISWAMXWvoLPqk9aFqfC4DVToSojGe9gwIMI8uqc5pxkzggeLi4id6ZJ4Z7G1JpSUkICj6r0HvRb8Icm6Zt5D8pKdBZtCYwHiwB5hPSypjQrIxiyvWMyBVi8hVQ0JoYcgVnsA89OySPxNSWRMSYrlKlRQe5jbq9iHBs/zKZLEQUk/oPgO2UU8pPwx2hVNJCjl2B9Fh0Sb//wq34RFyISPwF8X7la76IxTCAAAAAElFTkSuQmCC',
};

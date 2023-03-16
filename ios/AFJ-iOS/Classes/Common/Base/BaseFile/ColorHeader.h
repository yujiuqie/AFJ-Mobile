//
//  ColorHeader.h
//  SDBank_iOS
//
//  Created by sdebank on 2021/8/24.
//  Copyright © 2021 Alibaba. All rights reserved.
//

#ifndef ColorHeader_h
#define ColorHeader_h

#define kColor_random [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]//随机色

#define kColor_white [UIColor colorFromHexString_au:@"0xFFFFFF"]
#define kColor_white_a2 [UIColor colorFromHexString_au:@"0xFFFFFF" alpha:0.2]
#define kColor_white_a4 [UIColor colorFromHexString_au:@"0xFFFFFF" alpha:0.4]
#define kColor_white_a6 [UIColor colorFromHexString_au:@"0xFFFFFF" alpha:0.6]
#define kColor_white_a8 [UIColor colorFromHexString_au:@"0xFFFFFF" alpha:0.8]

#define kColor_black [UIColor colorFromHexString_au:@"0x000000"]
#define kColor_black_a2 [UIColor colorFromHexString_au:@"0x000000" alpha:0.2]
#define kColor_black_a4 [UIColor colorFromHexString_au:@"0x000000" alpha:0.4]
#define kColor_black_a5 [UIColor colorFromHexString_au:@"0x000000" alpha:0.5]/**< 黑色透明 蒙层颜色 */
#define kColor_black_a6 [UIColor colorFromHexString_au:@"0x000000" alpha:0.6]
#define kColor_black_a8 [UIColor colorFromHexString_au:@"0x000000" alpha:0.8]

#define kColor_gray_333333 [UIColor colorFromHexString_au:@"#333333"]//333333
#define kColor_gray_666666 [UIColor colorFromHexString_au:@"#666666"]//666666
#define kColor_gray_696969 [UIColor colorFromHexString_au:@"#696969"]//696969
#define kColor_gray_808080 [UIColor colorFromHexString_au:@"#808080"]//808080
#define kColor_gray [UIColor colorFromHexString_au:@"#908D8C"]//908D8C
#define kColor_gray_A9A9A9 [UIColor colorFromHexString_au:@"#A9A9A9"]//A9A9A9
#define kColor_gray_line [UIColor colorFromHexString_au:@"#DBDFE2"]//DBDFE2
#define kColor_gray_EAEAEA [UIColor colorFromHexString_au:@"#EAEAEA"]//EAEAEA
#define kColor_gray_F4F5F7 [UIColor colorFromHexString_au:@"#F4F5F7"]//F4F5F7
#define kColor_gray_F6F6F6 [UIColor colorFromHexString_au:@"#F6F6F6"]//F6F6F6
#define kColor_gray_F9FAFC [UIColor colorFromHexString_au:@"#F9FAFC"]//F9FAFC

#define kColor_800000 [UIColor colorFromHexString_au:@"#800000"]//800000   栗色
#define kColor_8B0000 [UIColor colorFromHexString_au:@"#8B0000"]//8B0000   深红色
#define kColor_A52A2A [UIColor colorFromHexString_au:@"#A52A2A"]//A52A2A   棕色
#define kColor_B22222 [UIColor colorFromHexString_au:@"#B22222"]//B22222   耐火砖
#define kColor_red [UIColor colorFromHexString_au:@"#DE4B4B"] //DE4B4B     红色
#define kColor_CD5C5C [UIColor colorFromHexString_au:@"#CD5C5C"]//CD5C5C   印度红
#define kColor_F08080 [UIColor colorFromHexString_au:@"#F08080"]//F08080   淡珊瑚色
#define kColor_FA8072 [UIColor colorFromHexString_au:@"#FA8072"]//FA8072   鲜肉(鲑鱼)色

#define kColor_FF6347 [UIColor colorFromHexString_au:@"#FF6347"]//FF6347   番茄
#define kColor_FF4500 [UIColor colorFromHexString_au:@"#FF4500"]//FF4500   橙红色 亮红
#define kColor_FF7F50 [UIColor colorFromHexString_au:@"#FF7F50"]//FF7F50   珊瑚
#define kColor_FFA07A [UIColor colorFromHexString_au:@"#FFA07A"]//FFA07A   浅鲜肉(鲑鱼)色
#define kColor_E9967A [UIColor colorFromHexString_au:@"#E9967A"]//E9967A   深鲜肉(鲑鱼)色
#define kColor_FFE4E1 [UIColor colorFromHexString_au:@"#FFE4E1"]//FFE4E1   薄雾玫瑰
#define kColor_FFFAFA [UIColor colorFromHexString_au:@"#FFFAFA"]//FFFAFA   雪

#define kColor_D2691E [UIColor colorFromHexString_au:@"#D2691E"]//D2691E   巧克力
#define kColor_CD853F [UIColor colorFromHexString_au:@"#CD853F"]//CD853F   秘鲁
#define kColor_F4A460 [UIColor colorFromHexString_au:@"#F4A460"]//F4A460   沙棕色
#define kColor_FF8C00 [UIColor colorFromHexString_au:@"#FF8C00"]//FF8C00   深橙色
#define kColor_FFA500 [UIColor colorFromHexString_au:@"#FFA500"]//FFA500   橙色
#define kColor_F5DEB3 [UIColor colorFromHexString_au:@"#F5DEB3"]//F5DEB3   小麦色
#define kColor_FFDEAD [UIColor colorFromHexString_au:@"#FFDEAD"]//FFDEAD   纳瓦霍白
#define kColor_FFDAB9 [UIColor colorFromHexString_au:@"#FFDAB9"]//FFDAB9   桃色
#define kColor_FFE4C4 [UIColor colorFromHexString_au:@"#FFE4C4"]//FFE4C4   (浓汤)乳脂,番茄等
#define kColor_FFEFD5 [UIColor colorFromHexString_au:@"#FFEFD5"]//FFEFD5   番木瓜
#define kColor_FDF5E6 [UIColor colorFromHexString_au:@"#FDF5E6"]//FDF5E6   老饰带
#define kColor_FFF8DC [UIColor colorFromHexString_au:@"#FFF8DC"]//FFF8DC   玉米色

#define kColor_808000 [UIColor colorFromHexString_au:@"#808000"]//808000   橄榄
#define kColor_DAA520 [UIColor colorFromHexString_au:@"#DAA520"]//DAA520   秋麒麟
#define kColor_FFD700 [UIColor colorFromHexString_au:@"#FFD700"]//FFD700   金
#define kColor_FFFF00 [UIColor colorFromHexString_au:@"#FFFF00"]//FFFF00   黄色
#define kColor_BDB76B [UIColor colorFromHexString_au:@"#BDB76B"]//BDB76B   纯黄
#define kColor_F0E68C [UIColor colorFromHexString_au:@"#F0E68C"]//F0E68C   卡其布
#define kColor_EEE8AA [UIColor colorFromHexString_au:@"#EEE8AA"]//EEE8AA   灰秋麒麟
#define kColor_FFFACD [UIColor colorFromHexString_au:@"#FFFACD"]//FFFACD   柠檬薄纱
#define kColor_FAFAD2 [UIColor colorFromHexString_au:@"#FAFAD2"]//FAFAD2   浅秋麒麟黄
#define kColor_F5F5DC [UIColor colorFromHexString_au:@"#F5F5DC"]//F5F5DC   米色(浅褐色)
#define kColor_FFFFE0 [UIColor colorFromHexString_au:@"#FFFFE0"]//FFFFE0   浅黄色
#define kColor_FFFFF0 [UIColor colorFromHexString_au:@"#FFFFF0"]//FFFFF0   象牙

#define kColor_556B2F [UIColor colorFromHexString_au:@"#556B2F"]//556B2F   橄榄土褐色
#define kColor_006400 [UIColor colorFromHexString_au:@"#006400"]//006400   深绿色
#define kColor_008000 [UIColor colorFromHexString_au:@"#008000"]//008000   纯绿
#define kColor_228B22 [UIColor colorFromHexString_au:@"#228B22"]//228B22   森林绿
#define kColor_2E8B57 [UIColor colorFromHexString_au:@"#2E8B57"]//2E8B57   海洋绿
#define kColor_3CB371 [UIColor colorFromHexString_au:@"#3CB371"]//3CB371   春天的绿色
#define kColor_32CD32 [UIColor colorFromHexString_au:@"#32CD32"]//32CD32   酸橙绿
#define kColor_00FF00 [UIColor colorFromHexString_au:@"#00FF00"]//00FF00   酸橙色
#define kColor_7FFF00 [UIColor colorFromHexString_au:@"#7FFF00"]//7FFF00   查特酒绿
#define kColor_7CFC00 [UIColor colorFromHexString_au:@"#7CFC00"]//7CFC00   草坪绿
#define kColor_ADFF2F [UIColor colorFromHexString_au:@"#ADFF2F"]//ADFF2F   绿黄色
#define kColor_00FA9A [UIColor colorFromHexString_au:@"#00FA9A"]//00FA9A   适中的碧绿色
#define kColor_00FF7F [UIColor colorFromHexString_au:@"#00FF7F"]//00FF7F   适中的春天的绿色
#define kColor_7FFFAA [UIColor colorFromHexString_au:@"#7FFFAA"]//7FFFAA   绿玉\碧绿色
#define kColor_90EE90 [UIColor colorFromHexString_au:@"#90EE90"]//90EE90   淡绿色
#define kColor_98FB98 [UIColor colorFromHexString_au:@"#98FB98"]//98FB98   苍白的绿色

#define kColor_2F4F4F [UIColor colorFromHexString_au:@"#2F4F4F"]//2F4F4F   深石板灰
#define kColor_008080 [UIColor colorFromHexString_au:@"#008080"]//008080   水鸭色
#define kColor_008B8B [UIColor colorFromHexString_au:@"#008B8B"]//008B8B   深青色
#define kColor_20B2AA [UIColor colorFromHexString_au:@"#20B2AA"]//20B2AA   浅海洋绿
#define kColor_00CED1 [UIColor colorFromHexString_au:@"#00CED1"]//00CED1   深绿宝石
#define kColor_48D1CC [UIColor colorFromHexString_au:@"#48D1CC"]//48D1CC   适中的绿宝石
#define kColor_40E0D0 [UIColor colorFromHexString_au:@"#40E0D0"]//40E0D0   绿宝石
#define kColor_AFEEEE [UIColor colorFromHexString_au:@"#AFEEEE"]//AFEEEE   苍白的绿宝石
#define kColor_D4F2E7 [UIColor colorFromHexString_au:@"#D4F2E7"]//D4F2E7   水绿色
#define kColor_E1FFFF [UIColor colorFromHexString_au:@"#E1FFFF"]//E1FFFF   淡青色

#define kColor_191970 [UIColor colorFromHexString_au:@"#191970"]//191970   午夜的蓝色
#define kColor_000080 [UIColor colorFromHexString_au:@"#000080"]//000080   海军蓝
#define kColor_00008B [UIColor colorFromHexString_au:@"#00008B"]//00008B   深蓝色
#define kColor_483D8B [UIColor colorFromHexString_au:@"#483D8B"]//483D8B   深岩暗蓝灰色
#define kColor_6A5ACD [UIColor colorFromHexString_au:@"#6A5ACD"]//6A5ACD   板岩暗蓝灰色
#define kColor_7B68EE [UIColor colorFromHexString_au:@"#7B68EE"]//7B68EE   适中的板岩暗蓝灰色
#define kColor_0000CD [UIColor colorFromHexString_au:@"#0000CD"]//0000CD   适中的蓝色
#define kColor_0000FF [UIColor colorFromHexString_au:@"#0000FF"]//0000FF   蓝色
#define kColor_4682B4 [UIColor colorFromHexString_au:@"#4682B4"]//4682B4   钢蓝
#define kColor_1E90FF [UIColor colorFromHexString_au:@"#1E90FF"]//1E90FF   道奇蓝
#define kColor_4169E1 [UIColor colorFromHexString_au:@"#4169E1"]//4169E1   皇家蓝
#define kColor_6495ED [UIColor colorFromHexString_au:@"#6495ED"]//6495ED   矢车菊的蓝色
#define kColor_00BFFF [UIColor colorFromHexString_au:@"#00BFFF"]//00BFFF   深天蓝
#define kColor_87CEFA [UIColor colorFromHexString_au:@"#87CEFA"]//87CEFA   淡蓝色
#define kColor_87CEEB [UIColor colorFromHexString_au:@"#87CEEB"]//87CEEB   天蓝色
#define kColor_5F9EA0 [UIColor colorFromHexString_au:@"#5F9EA0"]//5F9EA0   军校蓝
#define kColor_B0C4DE [UIColor colorFromHexString_au:@"#B0C4DE"]//B0C4DE   淡钢蓝
#define kColor_ADD8E6 [UIColor colorFromHexString_au:@"#ADD8E6"]//ADD8E6   淡蓝
#define kColor_B0E0E6 [UIColor colorFromHexString_au:@"#B0E0E6"]//B0E0E6   火药蓝
#define kColor_F0FFFF [UIColor colorFromHexString_au:@"#F0FFFF"]//F0FFFF   蔚蓝色

#define kColor_4B0082 [UIColor colorFromHexString_au:@"#4B0082"]//4B0082   靛青
#define kColor_8B008B [UIColor colorFromHexString_au:@"#8B008B"]//8B008B   深洋红色
#define kColor_800080 [UIColor colorFromHexString_au:@"#800080"]//800080   紫色
#define kColor_9400D3 [UIColor colorFromHexString_au:@"#9400D3"]//9400D3   深紫罗兰色
#define kColor_8A2BE2 [UIColor colorFromHexString_au:@"#8A2BE2"]//8A2BE2   深紫罗兰的蓝色
#define kColor_9932CC [UIColor colorFromHexString_au:@"#9932CC"]//9932CC   深兰花紫
#define kColor_BA55D3 [UIColor colorFromHexString_au:@"#BA55D3"]//BA55D3   适中的兰花紫
#define kColor_9370DB [UIColor colorFromHexString_au:@"#9370DB"]//9370DB   适中的紫色
#define kColor_FF00FF [UIColor colorFromHexString_au:@"#FF00FF"]//FF00FF   紫红色
#define kColor_DA70D6 [UIColor colorFromHexString_au:@"#DA70D6"]//DA70D6   兰花的紫色
#define kColor_EE82EE [UIColor colorFromHexString_au:@"#EE82EE"]//EE82EE   紫罗兰
#define kColor_DDA0DD [UIColor colorFromHexString_au:@"#DDA0DD"]//DDA0DD   李子
#define kColor_D8BFD8 [UIColor colorFromHexString_au:@"#D8BFD8"]//D8BFD8   蓟
#define kColor_DC143C [UIColor colorFromHexString_au:@"#DC143C"]//DC143C   猩红
#define kColor_C71585 [UIColor colorFromHexString_au:@"#C71585"]//C71585   适中的紫罗兰红色
#define kColor_FF1493 [UIColor colorFromHexString_au:@"#FF1493"]//FF1493   深粉色
#define kColor_DB7093 [UIColor colorFromHexString_au:@"#DB7093"]//DB7093   苍白的紫罗兰红色
#define kColor_FF69B4 [UIColor colorFromHexString_au:@"#FF69B4"]//FF69B4   热情的粉红
#define kColor_FFB6C1 [UIColor colorFromHexString_au:@"#FFB6C1"]//FFB6C1   浅粉红
#define kColor_FFC0CB [UIColor colorFromHexString_au:@"#FFC0CB"]//FFC0CB   粉红
#define kColor_FFF0F5 [UIColor colorFromHexString_au:@"#FFF0F5"]//FFF0F5   脸红的淡紫色

#define kColor_shadown_DCF2FC [UIColor colorFromHexString_au:@"0xDCF2FC"]//0xDCF2FC  阴影

#endif /* ColorHeader_h */

//
//  DDMViewController.h
//  dropDownMenu
//
//  Created by wujin on 2016/10/23.
//  Copyright © 2016年 Individual Developer. All rights reserved.
//

/**
 *  系统相关
 */
#pragma mark - System
// 当前系统版本是否iOS7或更新
#define IOS_7_LATER                 [[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0

/**
 *  尺寸相关
 */
#pragma mark - Size
// 屏幕尺寸
#define SCREEN_SIZE                 [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
// 各种Bar高度
#define STATUS_BAR_HEIGHT           ((IOS_7_LATER)?20:0)
#define NAV_BAR_HEIGHT              ((IOS_7_LATER)?44+20:44)
#define TAB_BAR_HEIGHT              self.tabBarController.tabBar.height
// 单像素分割线
#define SINGLE_LINE_WIDTH           ([UIScreen mainScreen].scale > 0.0 ? 1.0 / [UIScreen mainScreen].scale : 1.0)
#define SINGLE_LINE_ADJUST_OFFSET   ([UIScreen mainScreen].scale > 0.0 ? 1.0 / [UIScreen mainScreen].scale / 2 : 1.0)

// 颜色设置
#define UIColorFromRGB(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGB_alpha(rgbValue,alpha)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(alpha)]
#define UIColorWithR_G_B(r,g,b)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#define UIColorFromR_G_B_A(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//UI统一性
#define BtnColor FontGreenColor//操作按钮颜色
#define AppLineColor SeparatorLineColor//app分割线条颜色
#define AppLabelTextColor DarkGrayColor//标题栏颜色

// 文字色值
#define DarkGrayColor           UIColorFromRGB(0x333333) // 深灰色色值
#define MiddleGrayColor         UIColorFromRGB(0x666666) // 中灰色色值
#define LightGrayColor1         UIColorFromRGB(0x999999) // 浅灰色色值1
#define LightGrayColor2         UIColorFromRGB(0xaaaaaa) // 浅灰色色值2
#define LightGrayColor3         UIColorFromRGB(0xd8d8d8) // 浅灰色色值3
#define LightGrayColor4         UIColorFromRGB(0xf2f2f2) // 浅灰色色值4

#define NavBarTitleColor        UIColorFromRGB(0x333333) // 标题栏色值
#define BackgroundGrayColor     UIColorFromRGB(0xe5e5e5) // 背景浅灰色色值
#define BackgroundWhiteColor    UIColorFromRGB(0xffffff) // 背景白色色值
#define FontGreenColor          UIColorFromRGB(0x00c855) // 文字绿色色值
#define SeparatorLineColor      UIColorFromRGB(0xe4e4e4) // 分割线色值

// 间距
#define VerticalMargin          10 // 垂直间距
#define HorizontalMargin        10 // 水平间距

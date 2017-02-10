//
//  MyDefine.h
//  PullDownDemo
//
//  Created by liujing on 16/9/20.
//  Copyright © 2016年 liujing. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//重定义NSLog

//定义其他
//pickView 完成按钮frame
#define BtnFrame CGRectMake(MainScreenSize.width-90,_pickview.frame.origin.y-40, 80, 40)

#define Notification_DetailCommentCount @"Notification_DetailCommentCount"
#define Notification_NoticeUpdate @"Notification_NoticeUpdate"
#define Notification_TabClick @"Notification_TabClick"

//得到屏幕尺寸
#define MainScreenSize [UIScreen mainScreen].bounds.size

//定义系统版本
#define SysVersion [[[UIDevice currentDevice] systemVersion] doubleValue]

//自定义TabBar的高度
#define TabBarHeight 49

//自定义NavBar的高度
#define NavBarHeight 64
#define KNotificationClearConversationMessage @"KNotificationClearConversationMessage"

//gao
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//kuan
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//gao1
#define HeightScreen [UIScreen mainScreen].bounds.size.height

//kuan1
#define WidthScreen [UIScreen mainScreen].bounds.size.width

//4
#define DEVICE_IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height < 568)


//颜色取值

#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]

#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]









//
//  UtilsMacro.h
//  JKPro
//
//  Created by Rubyuer on 2018/10/17.
//  Copyright © 2018年 Rubyuer. All rights reserved.
//

/**
 *  本类放一些基本方法
 */
#ifndef UtilsMacro_h
#define UtilsMacro_h

//#ifdef DEBUG
//# define DLog(fmt, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//# define DLog(...);
//#endif

#ifdef DEBUG
#define DLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String]);
#else
#define DLog( s, ... )
#endif

//获取当前版本号
#define BUNDLE_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//获取当前版本的biuld
#define BIULD_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

#define ShareAppDelegate  ([UIApplication sharedApplication].delegate)

// 弱引用self
#define WS(weakSelf)  __weak __typeof(&*self) weakSelf = self;
/// iPhoneX底部宏
#define isIPhoneXBottomHeight        (ScreenHeight >= 812.0 ? 34.0 : 0.0)
///是否是iPhone X
#define isIPhoneX                   (ScreenHeight == 812.0 ? YES : NO)
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define NavigationHeight (ScreenHeight >= 812.0 ? 88.0 : 64.0)


#define WIDTH_SCALE(width)  (width/375.0*ScreenWidth)


#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#define MAINCOLOR RGBA(51, 51, 51, 1)


#define UUID ([UIDevice currentDevice].identifierForVendor.UUIDString)

#define IMAGE_NAME(x) [UIImage imageNamed:x]
#define NSStringFormatter(x) [NSString stringWithFormat:@"%@",x]
#define URL(url) [NSURL URLWithString:url]

#define PING_FANG(x)    [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#define PING_FANG_BOLD(x)   [UIFont fontWithName:@"PingFangSC-Semibold" size:x]

// 懒加载的图片
#define ImageDefault    [UIImage qmui_imageWithColor:RGBA(248, 248, 248, 1)]

#define   IS_LOGIN      [[NSUserDefaults standardUserDefaults] boolForKey:UD_IS_LOGIN]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]



#endif /* UtilsMacro_h */

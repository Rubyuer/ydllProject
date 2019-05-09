//
//  TabBarControllerConfig.m
//  JKPro
//
//  Created by Ruby on 2018/10/23.
//  Copyright © 2018年 Rubyuer. All rights reserved.
//

#import "TabBarControllerConfig.h"
#import "BaseNavigationViewController.h"

#import "IndexViewController.h"
#import "OrderViewController.h"
#import "MineViewController.h"


static CGFloat const CYLTabBarControllerHeight = 40.f;

@interface TabBarControllerConfig ()<UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation TabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetMake(0, -3);//UIOffsetMake(0, MAXFLOAT);
        
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                             imageInsets:imageInsets
                                                                                 titlePositionAdjustment:titlePositionAdjustment];
        
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    
    IndexViewController *index_vc = [[IndexViewController alloc] init];
    BaseNavigationViewController *index_nvc = [[BaseNavigationViewController alloc] initWithRootViewController:index_vc];
    
    OrderViewController *order_vc = [[OrderViewController alloc] init];
    BaseNavigationViewController *order_nvc = [[BaseNavigationViewController alloc] initWithRootViewController:order_vc];
   
    MineViewController *mine_vc = [[MineViewController alloc] init];
    BaseNavigationViewController *mine_nvc = [[BaseNavigationViewController alloc] initWithRootViewController:mine_vc];

    NSArray *viewControllers = @[index_nvc, order_nvc, mine_nvc];
    
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *index_vc  = @{CYLTabBarItemTitle : @"首页", CYLTabBarItemImage : @"tab_bar_home", CYLTabBarItemSelectedImage : @"tab_bar_home_select"};
    NSDictionary *order_vc  = @{CYLTabBarItemTitle : @"订单", CYLTabBarItemImage : @"tab_bar_order", CYLTabBarItemSelectedImage : @"tab_bar_order_select"};
    NSDictionary *mine_vc = @{CYLTabBarItemTitle : @"我的", CYLTabBarItemImage : @"tab_bar_mine", CYLTabBarItemSelectedImage : @"tab_bar_mine_select"};
//
    return @[index_vc, order_vc, mine_vc];
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = RGBA(153, 153, 153, 1);
    normalAttrs[NSFontAttributeName] = PING_FANG(10.0f);
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = RGBA(51, 51, 51, 1);
    selectedAttrs[NSFontAttributeName] = PING_FANG(10.0f);
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor yellowColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

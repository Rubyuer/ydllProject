//
//  AppDelegate.m
//  SYObject
//
//  Created by Jejms on 2019/5/6.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate>
{
    NSInteger _currentTabBar;
}
@end

@implementation AppDelegate

+ (AppDelegate *)sharedPorfiles {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTintColor:RGBA(102, 102, 102, 1)];
    
    [self setupIQKeyboardManager];
    
    TabBarControllerConfig *tabConfig = [[TabBarControllerConfig alloc] init];
    self.tabBarController = tabConfig.tabBarController;
    self.tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.tabBarController.selectedIndex = 0;
    self.tabBarController.delegate = self;
    self.window.rootViewController = nil;
    self.window.rootViewController = self.tabBarController;
    
    WS(weakSelf);
    [[CoreDataManager sharedInstance] deleteAllDataSuccess:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf addData];
        });
    } fail:^(NSError *aa) {
        
    }];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)enterMainViewController {
    if (IS_LOGIN) {
        TabBarControllerConfig *tabConfig = [[TabBarControllerConfig alloc] init];
        self.tabBarController = tabConfig.tabBarController;
        self.tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.tabBarController.selectedIndex = 0;
        self.tabBarController.delegate = self;
        self.window.rootViewController = nil;
        self.window.rootViewController = self.tabBarController;
    }else {
        [self loginViewController];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSLog(@"jian_a====%ld",tabBarController.selectedIndex);
    _currentTabBar = tabBarController.selectedIndex;
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    NSLog(@"jian_b====%ld",tabBarController.selectedIndex);
    if (tabBarController.selectedIndex == 0) {
        return;
    }
    if (!IS_LOGIN) {
        tabBarController.selectedIndex = _currentTabBar;
//        [self loginViewController];
        LoginViewController *logiNvc = [[LoginViewController alloc] init];
        logiNvc.type = 1;
        BaseNavigationViewController *loginNvc = [[BaseNavigationViewController alloc] initWithRootViewController:logiNvc];
        [[self currentViewController] presentViewController:loginNvc animated:YES completion:nil];
    }
}

/**
 * 启动键盘管理器
 */
- (void)setupIQKeyboardManager {
    IQKeyboardManager *mananer = [IQKeyboardManager sharedManager];
    mananer.enable = YES;
    mananer.shouldResignOnTouchOutside = YES;
    mananer.enableAutoToolbar = NO;
    [mananer resignFirstResponder];
}

- (void)loginViewController {
    LoginViewController *logiNvc = [[LoginViewController alloc] init];
    BaseNavigationViewController *loginNvc = [[BaseNavigationViewController alloc] initWithRootViewController:logiNvc];
    self.window.rootViewController = nil;
    self.window.rootViewController = loginNvc;
}


- (void)addData {

    
    
    GoodModel *model = [[GoodModel alloc] init];
    model.idd = 1;
    model.bigIcon = @"aa_三文鱼寿司_big";
    model.date = @"";
    model.icon = @"aa_三文鱼寿司";
    model.title = @"三文鱼寿司";
    
    model.number = 1;
    model.percent = 80;
    model.sale = 12;
    model.type = 1;
    model.price = 71;
    model.isCollect = NO;
    
    model.commDate = @"2019-03-25 12:24:11";
    model.commIcon = @"sy_comment_1";
    model.commName = @"太阳";
    model.commTitle = @"三文鱼寿司真的很好吃哦,推荐~";
    
    [[CoreDataManager sharedInstance] insertNewModel:model success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    GoodModel *aaa = [[GoodModel alloc] init];
    aaa.idd = 2;
    aaa.bigIcon = @"sy_detail_1";
    aaa.date = @"";
    aaa.icon = @"home_two";
    aaa.title = @"鳗鱼寿司";
    
    aaa.number = 1;
    aaa.percent = 60;
    aaa.sale = 8;
    aaa.type = 1;
    aaa.price = 80;
    aaa.isCollect = NO;
    
    aaa.commDate = @"2019-04-20 14:25:01";
    aaa.commIcon = @"sy_comment_2";
    aaa.commName = @"水惜";
    aaa.commTitle = @"味道挺不错的";
    
    [[CoreDataManager sharedInstance] insertNewModel:aaa success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    GoodModel *bbb = [[GoodModel alloc] init];
    bbb.idd = 3;
    bbb.bigIcon = @"sy_detail_2";
    bbb.date = @"";
    bbb.icon = @"home_three";
    bbb.title = @"海虾卷";
    
    bbb.number = 1;
    bbb.percent = 90;
    bbb.sale = 21;
    bbb.type = 1;
    bbb.price = 78;
    bbb.isCollect = NO;
    
    bbb.commDate = @"2019-02-10 18:20:21";
    bbb.commIcon = @"";
    bbb.commName = @"黎明";
    bbb.commTitle = @"很好吃哦~~";
    
    [[CoreDataManager sharedInstance] insertNewModel:bbb success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    GoodModel *ccc = [[GoodModel alloc] init];
    ccc.idd = 4;
    ccc.bigIcon = @"aa_军舰寿司_big";
    ccc.date = @"";
    ccc.icon = @"aa_军舰寿司";
    ccc.title = @"军舰寿司";
    
    ccc.number = 1;
    ccc.percent = 80;
    ccc.sale = 5;
    ccc.type = 1;
    ccc.price = 138;
    ccc.isCollect = NO;
    
    ccc.commDate = @"2019-05-02 19:32:11";
    ccc.commIcon = @"";
    ccc.commName = @"130****9811";
    ccc.commTitle = @"很赞";
    [[CoreDataManager sharedInstance] insertNewModel:ccc success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    
    GoodModel *ddd = [[GoodModel alloc] init];
    ddd.idd = 5;
    ddd.bigIcon = @"sy_detail_4";
    ddd.date = @"";
    ddd.icon = @"cishen_1";
    ddd.title = @"三文鱼";
    
    ddd.number = 1;
    ddd.percent = 60;
    ddd.sale = 24;
    ddd.type = 2;
    ddd.price = 108;
    ddd.isCollect = NO;

    ddd.commDate = @"2019-05-07 12:32:11";
    ddd.commIcon = @"sy_comment_5";
    ddd.commName = @"187****2028";
    ddd.commTitle = @"这是条测试数据";
    
    [[CoreDataManager sharedInstance] insertNewModel:ddd success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    GoodModel *eee = [[GoodModel alloc] init];
    eee.idd = 6;
    eee.bigIcon = @"sy_detail_5";
    eee.date = @"";
    eee.icon = @"cishen_2";
    eee.title = @"金枪鱼";
    
    eee.number = 1;
    eee.percent = 80;
    eee.sale = 43;
    eee.type = 2;
    eee.price = 90;
    eee.isCollect = NO;
    
    [[CoreDataManager sharedInstance] insertNewModel:eee success:^{
        
    } fail:^(NSError *error) {
        
    }];
 
    
    GoodModel *fff = [[GoodModel alloc] init];
    fff.idd = 7;
    fff.bigIcon = @"sy_detail_6";
    fff.date = @"";
    fff.icon = @"home_five";
    fff.title = @"鰤鱼";
    
    fff.number = 1;
    fff.percent = 70;
    fff.sale = 27;
    fff.type = 2;
    fff.price = 68;
    fff.isCollect = NO;
    
    fff.commDate = @"2019-04-07 18:02:41";
    fff.commIcon = @"";
    fff.commName = @"燕";
    fff.commTitle = @"个人觉得挺不错的,第一次吃";
    [[CoreDataManager sharedInstance] insertNewModel:fff success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    GoodModel *ggg = [[GoodModel alloc] init];
    ggg.idd = 8;
    ggg.bigIcon = @"sy_detail_7";
    ggg.date = @"";
    ggg.icon = @"home_six";
    ggg.title = @"鲱鱼";
    
    ggg.number = 1;
    ggg.percent = 60;
    ggg.sale = 56;
    ggg.type = 2;
    ggg.price = 118;
    ggg.isCollect = NO;
    
    ggg.commDate = @"2019-03-21 15:09:42";
    ggg.commIcon = @"sy_comment_8";
    ggg.commName = @"139****7251";
    ggg.commTitle = @"还好吧";
    
    [[CoreDataManager sharedInstance] insertNewModel:ggg success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    // 拉面
    GoodModel *aaaa = [[GoodModel alloc] init];
    aaaa.idd = 9;
    aaaa.bigIcon = @"aa_酱油拉面_big";
    aaaa.date = @"";
    aaaa.icon = @"aa_酱油拉面";
    aaaa.title = @"酱油拉面";
    
    aaaa.number = 1;
    aaaa.percent = 70;
    aaaa.sale = 11;
    aaaa.type = 3;
    aaaa.price = 28;
    aaaa.isCollect = NO;
    
    aaaa.commDate = @"2019-05-01 13:41:20";
    aaaa.commIcon = @"";
    aaaa.commName = @"138****2615";
    aaaa.commTitle = @"面够劲道,好吃.";
    [[CoreDataManager sharedInstance] insertNewModel:aaaa success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    GoodModel *bbbb = [[GoodModel alloc] init];
    bbbb.idd = 10;
    bbbb.bigIcon = @"aa_清汤拉面_big";
    bbbb.date = @"";
    bbbb.icon = @"aa_清汤拉面";
    bbbb.title = @"清汤拉面";
    
    bbbb.number = 1;
    bbbb.percent = 60;
    bbbb.sale = 32;
    bbbb.type = 3;
    bbbb.price = 26;
    bbbb.isCollect = NO;
    bbbb.commDate = @"2019-04-22 17:12:36";
    bbbb.commIcon = @"sy_comment_10";
    bbbb.commName = @"187****1123";
    bbbb.commTitle = @"汤很鲜,好喝";
    [[CoreDataManager sharedInstance] insertNewModel:bbbb success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    GoodModel *cccc = [[GoodModel alloc] init];
    cccc.idd = 11;
    cccc.bigIcon = @"sy_detail_10";
    cccc.date = @"";
    cccc.icon = @"lamian_3";
    cccc.title = @"大酱拉面";
    
    cccc.number = 1;
    cccc.percent = 60;
    cccc.sale = 7;
    cccc.type = 3;
    cccc.price = 28;
    cccc.isCollect = NO;
    
    
    [[CoreDataManager sharedInstance] insertNewModel:cccc success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    GoodModel *dddd = [[GoodModel alloc] init];
    dddd.idd = 12;
    dddd.bigIcon = @"sy_detail_11";
    dddd.date = @"";
    dddd.icon = @"limian_4";
    dddd.title = @"豚骨拉面";
    
    dddd.number = 1;
    dddd.percent = 80;
    dddd.sale = 2;
    dddd.type = 3;
    dddd.price = 32;
    dddd.isCollect = NO;
    dddd.commDate = @"2019-04-12 17:28:04";
    dddd.commIcon = @"";
    dddd.commName = @"咯咯";
    dddd.commTitle = @"不错的";
    [[CoreDataManager sharedInstance] insertNewModel:dddd success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    // 清酒
    GoodModel *aaaaa = [[GoodModel alloc] init];
    aaaaa.idd = 13;
    aaaaa.bigIcon = @"sy_detail_12";
    aaaaa.date = @"";
    aaaaa.icon = @"qingjiu_1";
    aaaaa.title = @"纯米吟酿";
    
    aaaaa.number = 1;
    aaaaa.percent = 80;
    aaaaa.sale = 6;
    aaaaa.type = 4;
    aaaaa.price = 68;
    aaaaa.isCollect = NO;
    aaaaa.commDate = @"2019-03-18 12:02:20";
    aaaaa.commIcon = @"";
    aaaaa.commName = @"130****3621";
    aaaaa.commTitle = @"醇香,强烈推荐购买.";
    [[CoreDataManager sharedInstance] insertNewModel:aaaaa success:^{
        
    } fail:^(NSError *error) {
        
    }];
    
    GoodModel *bbbbb = [[GoodModel alloc] init];
    bbbbb.idd = 14;
    bbbbb.bigIcon = @"sy_detail_13";
    bbbbb.date = @"";
    bbbbb.icon = @"qingjiu_2";
    bbbbb.title = @"二割三分纯米";
    
    bbbbb.number = 1;
    bbbbb.percent = 60;
    bbbbb.sale = 13;
    bbbbb.type = 4;
    bbbbb.price = 88;
    bbbbb.isCollect = NO;
    
    [[CoreDataManager sharedInstance] insertNewModel:bbbbb success:^{
        
    } fail:^(NSError *error) {
        
    }];
}
- (UIViewController *)currentViewController {
    UIWindow *keyWindow = [AppDelegate sharedPorfiles].window;
    // modal展现方式的底层视图不同
    // 取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstView = [keyWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];
    UIViewController *vc = [self viewController:secondView];
    
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            return [nav.viewControllers lastObject];
        } else {
            return tab.selectedViewController;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.viewControllers lastObject];
    } else {
        return vc;
    }
    return nil;
}
- (UIViewController *)viewController:(UIView *)view {
    
    id nextResponder = [view nextResponder];
    while (nextResponder != nil) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)nextResponder;
            return vc;
        }
        nextResponder = [nextResponder nextResponder];
    }
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

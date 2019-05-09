//
//  AppDelegate.h
//  SYObject
//
//  Created by Jejms on 2019/5/6.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CYLTabBarController *tabBarController;

+ (AppDelegate *)sharedPorfiles;

- (void)enterMainViewController;

- (void)loginViewController;


- (UIViewController *)currentViewController;

@end


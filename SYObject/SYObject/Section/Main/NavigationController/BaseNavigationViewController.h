//
//  BaseNavigationViewController.h
//  JKPro
//
//  Created by Ruby on 2018/10/23.
//  Copyright © 2018年 Rubyuer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "KLBaseNavAnimation.h"


NS_ASSUME_NONNULL_BEGIN

@interface BaseNavigationViewController : UINavigationController

@property (nonatomic, strong) Reachability *readchability;

@property (nonatomic,strong) NSArray *hideNetworkBarControllerArray; //此数组内的控制器（名）不会显示无网络提示框

@property (nonatomic,strong) NSArray *hideNetworkBarControllerArrayFull; //这个是最终的读取数组
- (void)pushViewController:(UIViewController *)viewController withImageView:(UIImageView*)imageView desRect:(CGRect)desRect delegate:(id <KLNavAnimationDelegate>) delegate;


@end

NS_ASSUME_NONNULL_END

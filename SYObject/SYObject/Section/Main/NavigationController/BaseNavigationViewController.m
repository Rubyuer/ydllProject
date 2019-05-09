//
//  BaseNavigationViewController.m
//  JKPro
//
//  Created by Ruby on 2018/10/23.
//  Copyright © 2018年 Rubyuer. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "ToolNetWorkView.h"
#import "CoreStatus.h"
#import "IQKeyboardManager.h"

@interface BaseNavigationViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, assign) CGRect origionRect;
@property (nonatomic, assign) CGRect desRect;
@property (nonatomic, assign) BOOL isPush;
@property (nonatomic, weak) id  animationDelegate;

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //监听网络状态
    [self beginReachabilityNoti];
    [self netWorkStatusChange];
    
}

// 警告 - ⚠️    使用wr_setStatusBarStyle 这个方法不能实现
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    self.isPush = NO;
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    UIViewController *vc = [super popViewControllerAnimated:animated];
    
    //再次检查当前控制器是否需要显示网络状态提示视图
    [self netWorkStatusChange];
    
    if (self.viewControllers.count) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return vc;
}

- (void)pushViewController:(UIViewController *)viewController withImageView:(nonnull UIImageView *)imageView desRect:(CGRect)desRect delegate:(nonnull id<KLNavAnimationDelegate>)delegate {
    self.delegate = self;
    self.imageView = imageView;
    self.origionRect = [imageView convertRect:imageView.frame toView:self.view];
    self.desRect = desRect;
    self.isPush = YES;
    self.animationDelegate = delegate;
    [super pushViewController:viewController animated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    KLBaseNavAnimation* animation = [[KLBaseNavAnimation alloc] init];
    
    animation.imageView = self.imageView;
    
    animation.origionRect = self.origionRect;
    
    animation.desRect = self.desRect;
    
    animation.isPush = self.isPush;
    
    animation.delegate = self.animationDelegate;
    
    if (!self.isPush && self.delegate) {
        self.delegate = nil;
    }
    return animation;
}


#pragma mark  监听网络状态
- (void)beginReachabilityNoti {
    
    Reachability *readchability = [Reachability reachabilityForInternetConnection];
    
    //记录
    self.readchability=readchability;
    
    //开始通知
    [readchability startNotifier];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStatusChange) name:kReachabilityChangedNotification object:readchability];
}

/** 网络状态变更 */
- (void)netWorkStatusChange {
    
    if ([self needHideNetWorkBarWithVC:self.topViewController]) {
        //这里dismiss的原因在于可能由其他页面pop回来的时候，如果直接return会导致bar显示出来。
        [self dismissNetWorkBar];
        return;
    }
    
    if ([CoreStatus isNetworkEnable]){
        [self dismissNetWorkBar];
    }else{
        [self showNetWorkBar];
    }
}
#pragma mark  显示网络状态提示条
- (void)showNetWorkBar {
    
    CGFloat y = self.navigationBar.frame.size.height + 20.0f;
    
    [ToolNetWorkView showNetWordNotiInViewController:self y:y];
}

#pragma mark  隐藏网络状态提示条
- (void)dismissNetWorkBar {
    
    [ToolNetWorkView dismissNetWordNotiInViewController:self];
}

- (BOOL)needHideNetWorkBarWithVC:(UIViewController *)vc {
    NSString *vcStr = NSStringFromClass(vc.class);
    BOOL res = [self.hideNetworkBarControllerArrayFull containsObject:vcStr];
    return res;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ - dealloc",NSStringFromClass(self.class));
}
@end

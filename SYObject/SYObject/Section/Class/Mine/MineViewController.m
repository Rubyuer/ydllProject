//
//  MineViewController.m
//  SYObject
//
//  Created by Jejms on 2019/5/6.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "MineViewController.h"

#import "AboutViewController.h"
#import "SettingViewController.h"
#import "CouponViewController.h"
#import "InfoViewController.h"
#import "CollectViewController.h"

@interface MineViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated {
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:UD_ICON];
    if (imageData) {
        _iconView.image = [UIImage imageWithData:imageData];
    }
    if (IS_LOGIN) {
        NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:UD_PHONE];
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:UD_NAME];
        
        [_loginButton setTitle:(name.length ? name : phone) forState:UIControlStateNormal];
    }else {
        [_loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ViewRadius(_iconView, _iconView.frame.size.height/2.0f);
    [_iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(data)]];
    
}

- (void)data {
    InfoViewController *vc = [[InfoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
// 立即登录
- (IBAction)login:(id)sender {
    if (IS_LOGIN) {
        return;
    }
    [[AppDelegate sharedPorfiles] loginViewController];
}


- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) { // 购物车
        CouponViewController *vc = [[CouponViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1) { // 卡券
        CouponViewController *vc = [[CouponViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 2) { // 收藏
        CollectViewController *vc = [[CollectViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 3) { // 关于
        AboutViewController *vc = [[AboutViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 4) { // 设置
        SettingViewController *vc = [[SettingViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end

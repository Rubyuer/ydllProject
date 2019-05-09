//
//  SettingViewController.m
//  SYObject
//
//  Created by Rubyuer on 2019/5/6.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@property (weak, nonatomic) IBOutlet UIButton *exitButton;



@end

@implementation SettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
 
    ViewRadius(_exitButton, 4.0f);
}

- (IBAction)Switch:(UISwitch *)sender {
    if (sender.tag == 0) {
        
    }
    if (sender.tag == 1) {
        
    }
}

- (IBAction)exit:(UIButton *)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录么？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    WS(weakSelf);
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:UD_IS_LOGIN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
//            [[AppDelegate sharedPorfiles] loginViewController];
            weakSelf.tabBarController.selectedIndex = 0;
        });
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end

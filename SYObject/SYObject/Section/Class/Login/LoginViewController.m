//
//  LoginViewController.m
//  SYObject
//
//  Created by Jejms on 2019/5/6.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "LoginViewController.h"


#import "ForgetPswViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UIView *pswView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *dismissButton;


@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    if (_type == 1) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PING_FANG(15);
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 50, 32);
        [button addTarget:self action:@selector(dismissssss:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
}
- (void)dismissssss:(UIBarButtonItem *)item {
    [[[AppDelegate sharedPorfiles] currentViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI {
    ViewBorderRadius(_bgView, 4, 1.0f, RGBA(202, 202, 202, 0.5));
    ViewBorderRadius(_userView, 4, 1.0f, RGBA(202, 202, 202, 0.5));
    ViewBorderRadius(_pswView, 4, 1.0f, RGBA(202, 202, 202, 0.5));
    
    ViewRadius(_loginButton, 4);
    
    _userTF.delegate = self;
    _pswTF.delegate = self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger strLength = textField.text.length - range.length + string.length;
    if (_pswTF == textField) {
        return (strLength <= 20);
    }
    if (_userTF == textField) {
        return (strLength <= 11);
    }
    
    return YES;
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) { // 忘记密码
        ForgetPswViewController *vc = [[ForgetPswViewController alloc] init];
        vc.type = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 1) { // 注册
        ForgetPswViewController *vc = [[ForgetPswViewController alloc] init];
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 2) { // 登录
        [self.view endEditing:YES];
        if (![_userTF.text isPhoneNumber]) {
            [MBProgressHUD showErrorNo:@"手机号码有误" toView:ShareAppDelegate.window];
            return ;
        }
        if (_pswTF.text.length < 6) {
            [MBProgressHUD showErrorNo:@"请输入6位及以上密码" toView:ShareAppDelegate.window];
            return ;
        }
        if ([CoreStatus isNetworkEnable]) {
            WS(weakSelf);
            [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (![weakSelf.userTF.text isEqualToString:USER_NAME]) {
                    [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
                    [MBProgressHUD showErrorNo:@"账号或密码错误" toView:ShareAppDelegate.window];
                    return;
                }
                if (![weakSelf.pswTF.text isEqualToString:USER_PSW]) {
                    [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
                    [MBProgressHUD showErrorNo:@"账号或密码错误" toView:ShareAppDelegate.window];
                    return;
                }
                
                [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
                
                [MBProgressHUD showSuccess:@"登录成功" toView:ShareAppDelegate.window];
                
                [[NSUserDefaults standardUserDefaults] setObject:weakSelf.userTF.text forKey:UD_PHONE];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:UD_IS_LOGIN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                if (weakSelf.type == 1) {
                    [weakSelf dismissssss:nil];
                }else {
                    [[AppDelegate sharedPorfiles] enterMainViewController];
                }
            });
        }else{
            [MBProgressHUD showErrorNo:@"无网络" toView:ShareAppDelegate.window];
        }
    }
}

- (void)dealloc {
    NSLog(@"%@ - dealloc",NSStringFromClass(self.class));
}

@end

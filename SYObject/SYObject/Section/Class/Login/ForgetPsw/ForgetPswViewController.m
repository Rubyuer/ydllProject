//
//  ForgetPswViewController.m
//  SYObject
//
//  Created by Jejms on 2019/5/6.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "ForgetPswViewController.h"

@interface ForgetPswViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *pswView;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;


@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;


@end

@implementation ForgetPswViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _type == 0 ? @"忘记密码" : @"注册";
    
    [self initUI];
    
    
}

//  0 忘记密码       1 设置密码
- (IBAction)action:(UIButton *)sender {
    if (![_phoneTF.text isPhoneNumber]) {
        [MBProgressHUD showErrorNo:@"手机号码有误" toView:ShareAppDelegate.window];
        return ;
    }
    if (sender.tag == 0) { // 发送验证码
        if ([CoreStatus isNetworkEnable]) {
            [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
            WS(weakSelf);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
                
                [MBProgressHUD showSuccess:@"发送成功" toView:ShareAppDelegate.window];
                
                [weakSelf handleTimer:weakSelf.codeButton];
            });
        }else {
            [MBProgressHUD showErrorNo:@"无网络" toView:ShareAppDelegate.window];
        }
    }
    if (sender.tag == 1) { // 完成
        if (_codeTF.text.length < 6) {
            [MBProgressHUD showErrorNo:@"请输入6位验证码" toView:ShareAppDelegate.window];
            return ;
        }
        if (_pswTF.text.length < 6) {
            [MBProgressHUD showErrorNo:@"请输入6位及以上密码" toView:ShareAppDelegate.window];
            return ;
        }
        
        if ([CoreStatus isNetworkEnable]) {
            [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
            WS(weakSelf);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
                
                [MBProgressHUD showSuccess:@"操作成功" toView:ShareAppDelegate.window];
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            });
        }else {
            [MBProgressHUD showErrorNo:@"无网络" toView:ShareAppDelegate.window];
        }
    }
}


- (void)initUI {
    
    ViewBorderRadius(_phoneView, 4, 1, RGBA(229, 229, 229, 1));
    ViewBorderRadius(_codeView, 4, 1, RGBA(229, 229, 229, 1));
    ViewBorderRadius(_pswView, 4, 1, RGBA(229, 229, 229, 1));

    ViewRadius(_codeButton, 4);
    ViewRadius(_finishButton, 4);
    
    _phoneTF.delegate = self;
    _codeTF.delegate = self;
    _pswTF.delegate = self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger strLength = textField.text.length - range.length + string.length;
    if (_pswTF == textField) {
        return (strLength <= 20);
    }
    if (_phoneTF == textField) {
        return (strLength <= 11);
    }
    if (_codeTF == textField) {
        return (strLength <= 6);
    }
    return YES;
}

@end

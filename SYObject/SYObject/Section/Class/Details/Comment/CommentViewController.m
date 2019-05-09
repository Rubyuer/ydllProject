//
//  CommentViewController.m
//  SYObject
//
//  Created by Rubyuer on 2019/5/7.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()<QMUITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UIView *starView;

@property (weak, nonatomic) IBOutlet QMUITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评价";
    
    [self initUI];
    
    ViewRadius(_commitButton, 6.0f);
    
    _imgView.image = IMAGE_NAME(_model.icon);
    ViewRadius(_imgView, 6.0f);
}


- (IBAction)commit:(UIButton *)sender {
    if (_textView.text.length == 0) {
        [MBProgressHUD showErrorNo:@"请输入文字" toView:ShareAppDelegate.window];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showSuccess:@"操作成功" toView:ShareAppDelegate.window];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    });
}

- (IBAction)star:(UIButton *)sender {
    for (UIView *view in _starView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (button.tag <= sender.tag) {
                [button setImage:IMAGE_NAME(@"order_comment_red") forState:UIControlStateNormal];
            }else {
                [button setImage:IMAGE_NAME(@"order_comment_gral") forState:UIControlStateNormal];
            }
        }
    }
//    星星颗数： sender.tag%10+1
}


- (void)initUI {
    _textView.delegate = self;
    _textView.placeholder = @"分享您的心得...";
    _textView.placeholderColor = RGBA(204, 204, 204, 1);
    ViewRadius(_textView, 6.0f);
    
    
    
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 120) {
        _textView.text = [_textView.text substringToIndex:120];
        
        [MBProgressHUD showErrorNo:@"限制120字以内" toView:ShareAppDelegate.window];
    }else {
        
    }
}

@end

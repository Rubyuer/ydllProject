//
//  SYBaseViewController.m
//  SYObject
//
//  Created by Jejms on 2019/5/6.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "SYBaseViewController.h"

@interface SYBaseViewController ()

@end

@implementation SYBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 *  验证码倒计时
 */
- (void)handleTimer:(UIButton*)sender {
    __block int timeout = 120; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"重新获取" forState:UIControlStateNormal];
                [sender setTitleColor:RGBA(255, 6, 6, 1) forState:UIControlStateNormal];
                sender.backgroundColor = [UIColor clearColor];
                sender.userInteractionEnabled = YES;
            });
        }else {
            //            int minutes = timeout / 60;
            int seconds = timeout % 121;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                sender.backgroundColor = MAINCOLOR;
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
}


@end

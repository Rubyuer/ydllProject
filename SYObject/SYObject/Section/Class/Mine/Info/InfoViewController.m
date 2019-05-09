//
//  InfoViewController.m
//  SYObject
//
//  Created by Rubyuer on 2019/5/6.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import "InfoViewController.h"

#import "InputPopView.h"


@interface InfoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) UIImagePickerController *picker;

@end

@implementation InfoViewController
- (UIImagePickerController *)picker {
    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.delegate = self;
//        _picker.allowsEditing = YES;
    }
    return _picker;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //    获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.iconView.image = image;
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:UD_ICON];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    
    //    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //    返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:UD_ICON];
    if (imageData) {
        _iconView.image = [UIImage imageWithData:imageData];
    }
    ViewRadius(_iconView, _iconView.frame.size.height/2.0f);
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:UD_NAME];
    NSString *birthday = [[NSUserDefaults standardUserDefaults] objectForKey:UD_BIRTHDAY];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:UD_PHONE];
    _nameLabel.text = name.length ? name : @"";;
    _birthLabel.text = birthday.length ? birthday : @"";
    _phoneLabel.text = phone.length ? phone : @"";
}


- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) { // 头像
        [self presentViewController:self.picker animated:YES completion:nil];
    }
    if (sender.tag == 1) { // 昵称
        InputPopView *iView = [[InputPopView alloc] initWithType:0];
        WS(weakSelf);
        [iView setGetInputDataBlock:^(NSString * _Nonnull msg) {
            weakSelf.nameLabel.text = msg;
            [[NSUserDefaults standardUserDefaults] setObject:msg forKey:UD_NAME];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        [iView show];
    }
    if (sender.tag == 2) { // 生日
        UIDatePicker *picker = [[UIDatePicker alloc] init];
        picker.frame = CGRectMake(-20, 40, ScreenWidth, 200);
        picker.datePickerMode = UIDatePickerModeDate;
        picker.maximumDate = [NSDate date];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        WS(weakSelf);
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (picker.date == nil) {
                return ;
            }
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd";
            weakSelf.birthLabel.text = [formatter stringFromDate:picker.date];
            [[NSUserDefaults standardUserDefaults] setObject:weakSelf.birthLabel.text forKey:UD_BIRTHDAY];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        [alertController.view addSubview:picker];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    if (sender.tag == 3) { // 电话
//        InputPopView *iView = [[InputPopView alloc] initWithType:1];
//        WS(weakSelf);
//        [iView setGetInputDataBlock:^(NSString * _Nonnull msg) {
//            weakSelf.phoneLabel.text = msg;
//            [[NSUserDefaults standardUserDefaults] setObject:msg forKey:UD_PHONE];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }];
//        [iView show];
    }
}

- (void)dealloc {
    NSLog(@"%@ - dealloc",NSStringFromClass(self.class));
}


@end

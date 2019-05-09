//
//  CouponViewController.m
//  SYObject
//
//  Created by Rubyuer on 2019/5/6.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import "CouponViewController.h"

@interface CouponViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _type == 0 ? @"我的卡券" : @"我的购物车";
    
    if (_type == 0) { //
        self.navigationItem.title = @"我的卡券";
        
        _iconView.image = IMAGE_NAME(@"mine_coupon_null");
        _titleLabel.text = @"暂时还没有优惠券哦～";
    }else if (_type == 1) { //
        self.navigationItem.title = @"我的购物车";
        
        _iconView.image = IMAGE_NAME(@"mine_shop_null");
        _titleLabel.text = @"购物车还空着呢，赶快去添加吧～";
    }
}


@end

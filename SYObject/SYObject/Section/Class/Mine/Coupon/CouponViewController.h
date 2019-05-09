//
//  CouponViewController.h
//  SYObject
//
//  Created by Rubyuer on 2019/5/6.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import "SYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponViewController : SYBaseViewController

// 0 我的卡券    1 我的购物车   ---   空状态
@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END

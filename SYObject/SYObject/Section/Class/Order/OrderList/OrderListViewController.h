//
//  OrderListViewController.h
//  SYObject
//
//  Created by Rubyuer on 2019/5/6.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import "SYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListViewController : SYBaseViewController

@property (nonatomic, strong) GoodModel *model;

@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END

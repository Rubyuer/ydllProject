//
//  GoodModel.h
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodModel : NSManagedObject

@property (nonatomic, assign) NSInteger idd;

@property (nonatomic, copy) NSString *bigIcon;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger percent;
@property (nonatomic, assign) NSInteger sale;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) BOOL isCollect;

 // 0  普通商品   1 已生成订单  2 订单已完成
@property (nonatomic, assign) NSInteger orderType;

@property (nonatomic, copy) NSString *commTitle;
@property (nonatomic, copy) NSString *commIcon;
@property (nonatomic, copy) NSString *commName;
@property (nonatomic, copy) NSString *commDate;


@end

NS_ASSUME_NONNULL_END

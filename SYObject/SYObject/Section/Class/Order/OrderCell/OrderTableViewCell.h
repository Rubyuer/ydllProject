//
//  OrderTableViewCell.h
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) GoodModel *model;

@end

NS_ASSUME_NONNULL_END

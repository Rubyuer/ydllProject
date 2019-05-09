//
//  CollectTableViewCell.h
//  SYObject
//
//  Created by Rubyuer on 2019/5/6.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

NS_ASSUME_NONNULL_END

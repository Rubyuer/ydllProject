//
//  ISubCollectionViewCell.h
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ISubCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIView *starView;

@property (nonatomic, strong) GoodModel *model;

@end

NS_ASSUME_NONNULL_END

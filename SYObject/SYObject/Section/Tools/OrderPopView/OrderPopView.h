//
//  OrderPopView.h
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderCommitBlock)(void);


@interface OrderPopView : UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabek;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UIButton *commitButton;

- (void)show;

@property (nonatomic, strong) GoodModel *model;

@property (nonatomic, copy) OrderCommitBlock orderCommitBlock;

@end

NS_ASSUME_NONNULL_END

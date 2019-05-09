//
//  OrderTableViewCell.m
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

//@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *imgVIew;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *numLabel;
//@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void)setModel:(GoodModel *)model {
    _model = model;
    
    if (_model.orderType == 1) {
        _statusLabel.text = @"查看订单";
    }
    if (_model.orderType == 2) {
        _statusLabel.text = @"已完成";
    }
    _imgVIew.image = IMAGE_NAME(_model.icon);
    _titleLabel.text = _model.title;
    _numLabel.text = [NSString stringWithFormat:@"x%ld",_model.number];
    _priceLabel.text = [NSString stringWithFormat:@"¥%ld",model.price];
    
}

@end

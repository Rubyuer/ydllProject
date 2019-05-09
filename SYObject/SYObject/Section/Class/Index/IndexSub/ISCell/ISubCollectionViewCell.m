//
//  ISubCollectionViewCell.m
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "ISubCollectionViewCell.h"

@implementation ISubCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(GoodModel *)model {
    _model = model;
    
    _iconView.image = IMAGE_NAME(_model.icon);
    _titleLabel.text = _model.title;
    _priceLabel.text = [NSString stringWithFormat:@"¥%ld",_model.price];
    
    for (UIView *view in _starView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imgView = (UIImageView *)view;
            if (_model.percent >= 60 && _model.percent < 70) {
                if (imgView.tag < 3) {
                    imgView.image = IMAGE_NAME(@"star_full");
                }else {
                    imgView.image = IMAGE_NAME(@"star_null");
                }
            }else if (_model.percent >= 70 && _model.percent < 80) {
                if (imgView.tag < 3) {
                    imgView.image = IMAGE_NAME(@"star_full");
                }else if (imgView.tag == 3) {
                    imgView.image = IMAGE_NAME(@"star_half");
                }else {
                    imgView.image = IMAGE_NAME(@"star_null");
                }
            }else if (_model.percent >= 80 && _model.percent < 90) {
                if (imgView.tag < 4) {
                    imgView.image = IMAGE_NAME(@"star_full");
                }else {
                    imgView.image = IMAGE_NAME(@"star_null");
                }
            }else if (_model.percent >= 90 && _model.percent < 100) {
                if (imgView.tag < 4) {
                    imgView.image = IMAGE_NAME(@"star_full");
                }else if (imgView.tag == 4) {
                    imgView.image = IMAGE_NAME(@"star_half");
                }else {
                    imgView.image = IMAGE_NAME(@"star_null");
                }
            }else if (_model.percent >= 100) {
                imgView.image = IMAGE_NAME(@"star_full");
            }
        }
    }
    
}

@end

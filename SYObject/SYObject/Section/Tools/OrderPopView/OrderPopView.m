//
//  OrderPopView.m
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "OrderPopView.h"

@implementation OrderPopView

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"OrderPopView" owner:self options:nil] lastObject];
        self.frame = ShareAppDelegate.window.frame;
        
        ViewRadius(_bgView, 6);
        ViewRadius(_commitButton, 6);
        
        CGRect rFrame = _bgView.frame;
        rFrame.size.height = 350;
        rFrame.origin.y = ScreenHeight;
        _bgView.frame = rFrame;
    }
    return self;
}

- (void)setModel:(GoodModel *)model {
    _model = model;
    
    _imgView.image = IMAGE_NAME(_model.icon);
    _titleLabel.text = _model.title;
    _priceLabek.text = [NSString stringWithFormat:@"¥%ld",_model.price];
}

- (void)show {
    [ShareAppDelegate.window addSubview:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.35f animations:^{
        CGRect rFrame = weakSelf.bgView.frame;
        rFrame.origin.y = ScreenHeight - 350 - isIPhoneXBottomHeight;
        weakSelf.bgView.frame = rFrame;
    }];
}
- (IBAction)dismiss:(UIButton *)sender {
    WS(weakSelf);
    [UIView animateWithDuration:0.35f animations:^{
        CGRect rFrame = weakSelf.bgView.frame;
        rFrame.origin.y = ScreenHeight;
        weakSelf.bgView.frame = rFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)action:(UIButton *)sender {
    NSInteger number = [_numLabel.text integerValue];
    if (sender.tag == 0 || sender.tag == 1) {
        if (sender.tag == 0) { // -
            if (number > 1) {
                _numLabel.text = [NSString stringWithFormat:@"%ld",number - 1];
            }
            return;
        }
        // +
        _numLabel.text = [NSString stringWithFormat:@"%ld",number + 1];
    }
    
    if (sender.tag == 2) { //  确认
        _model.number = number;
        if (self.orderCommitBlock) {
            self.orderCommitBlock();
        }
        [self dismiss:nil];
    }
    
}


@end

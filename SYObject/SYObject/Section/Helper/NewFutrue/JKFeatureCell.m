//
//  KLNewFeatureCell.m
//  JKStore
//
//  Created by Kuroba.Lei on 2018/6/12.
//  Copyright © 2018年 K.Lei. All rights reserved.
//

#import "JKFeatureCell.h"

@interface JKFeatureCell ()

/* button */
@property (strong , nonatomic)UIButton *hideButton;

@end

@implementation JKFeatureCell

#pragma mark - super
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _nfImageView = [[UIImageView alloc] init];
        [self insertSubview:_nfImageView atIndex:1];
        
        [self insertSubview:self.jumpButton atIndex:0];
    }return self;
}

#pragma mark - LazyLaod
- (UIButton *)hideButton {
    if (!_hideButton) {
        _hideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _hideButton.adjustsImageWhenHighlighted = false;
        _hideButton.hidden = YES;
        [_hideButton addTarget:self action:@selector(hideButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_hideButton];
    }return _hideButton;
}
- (UIButton *)jumpButton {
    if (!_jumpButton) {
        _jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jumpButton setImage:IMAGE_NAME(@"jk_pro_welcome_III_button") forState:UIControlStateNormal];
//        _jumpButton.frame = CGRectMake(0, 0.95*ScreenHeight - WIDTH_SCALE(20.0f)-ScreenWidth/3.0f*36.0/125.0f, ScreenWidth/3.0f, ScreenWidth/3.0f*36.0/125.0f);
//        _jumpButton.center = CGPointMake(self.center.x, _jumpButton.center.y);
        _jumpButton.frame = CGRectMake(0, 0, ScreenWidth/3.0f, ScreenWidth/3.0f*36.0/125.0f);
        _jumpButton.center = self.center;
        _jumpButton.adjustsImageWhenHighlighted = false;
        _jumpButton.hidden = YES;
        _jumpButton.userInteractionEnabled = NO;
        [self addSubview:_jumpButton];
    }return _jumpButton;
}


#pragma mark - super
- (void)layoutSubviews {
    [super layoutSubviews];
    self.nfImageView.frame = self.bounds;
}

- (void)setHideBtnImg:(NSString *)hideBtnImg {
    _hideBtnImg = hideBtnImg;
    if (hideBtnImg.length != 0) {
        [self.hideButton sizeToFit]; //自适应
        
        [self.hideButton setImage:[UIImage imageNamed:hideBtnImg] forState:UIControlStateNormal];
        self.hideButton.center = CGPointMake(ScreenWidth * 0.5, ScreenHeight * 0.9);
    }
}

#pragma mark - 获取页码index
- (void)kl_GetCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex {
    _hideButton.hidden = (currentIndex == lastIndex) ?  NO : YES; //只有当前index和最后index相等时隐藏按钮才显示
}

#pragma mark - 隐藏点击
- (void)hideButtonClick {
    !_hideButtonClickBlock ? : _hideButtonClickBlock(); //block回调
}

@end

//
//  InputPopView.m
//  SYObject
//
//  Created by Rubyuer on 2019/5/6.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import "InputPopView.h"

@interface InputPopView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;

@property (nonatomic, assign) NSInteger type;

@end


@implementation InputPopView

- (instancetype)initWithType:(NSInteger)type {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"InputPopView" owner:self options:nil] lastObject];
        self.frame = ShareAppDelegate.window.frame;
     
        ViewRadius(_bgView, 6.0f);
        
        _type = type;
        if (type == 0) { // 昵称
            _inputTF.keyboardType = UIKeyboardTypeDefault;
        }
        if (type == 1) { // 电话
            _inputTF.keyboardType = UIKeyboardTypePhonePad;
        }
        _inputTF.delegate = self;
    }
    return self;
}

- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 1) { // 确定
        if (self.getInputDataBlock && _inputTF.text.length) {
            self.getInputDataBlock(_inputTF.text);
        }
    }
    
    [self removeFromSuperview];
}

- (void)show {
    [self exChangeOutDur:0.35f view:_bgView];
    [ShareAppDelegate.window addSubview:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger strLength = textField.text.length - range.length + string.length;
    if (_type == 0) {
        return (strLength <= 20);
    }
    if (_type == 1) {
        return (strLength <= 11);
    }
    
    return YES;
}

- (void)exChangeOutDur:(CFTimeInterval)dur view:(UIView *)view {
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [view.layer addAnimation:animation forKey:nil];
}

@end

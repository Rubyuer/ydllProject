//
//  KLBaseNavAnimation.m
//  JKStore
//
//  Created by Kuroba.Lei on 2018/4/17.
//  Copyright © 2018年 K.Lei. All rights reserved.
//

#import "KLBaseNavAnimation.h"

@interface KLBaseNavAnimation ()
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@end
@implementation KLBaseNavAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView* contentView = [transitionContext containerView];
    contentView.backgroundColor = [UIColor whiteColor];
    
    
    UIViewController* toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    __block UIImageView* imageView = [[UIImageView alloc] initWithImage:self.imageView.image];
    imageView.frame = self.isPush ? self.origionRect : self.desRect;
    imageView.backgroundColor = self.imageView.backgroundColor;
    [contentView addSubview:toVc.view];
    toVc.view.alpha = 0;
    
    [contentView addSubview:imageView];
    [UIView animateWithDuration:0.2 animations:^{
        toVc.view.alpha = 1.0f;
    }];
    
    UIImage* image = nil;
    if (!self.isPush) {
        image = [self.imageView.image copy];
        self.imageView.image = nil;
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = self.isPush ? self.desRect : self.origionRect;
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(didFinishTransition)] && self.isPush) {
            [self.delegate didFinishTransition];
        }
        
        [transitionContext completeTransition:YES];
        
        [imageView removeFromSuperview];
        if (!self.isPush) {
            self.imageView.image = image;
        }
        imageView = nil;
    }];
    
    
    
}
@end

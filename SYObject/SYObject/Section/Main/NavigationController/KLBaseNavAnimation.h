//
//  KLBaseNavAnimation.h
//  JKStore
//
//  Created by Kuroba.Lei on 2018/4/17.
//  Copyright © 2018年 K.Lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KLNavAnimationDelegate <NSObject>
-(void)didFinishTransition;
@end

@interface KLBaseNavAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, assign) CGRect origionRect;
@property (nonatomic, assign) CGRect desRect;
@property (nonatomic, assign) BOOL isPush;
@property (nonatomic, weak) id <KLNavAnimationDelegate> delegate;

@end

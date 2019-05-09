//
//  KLNewFeatureCell.h
//  JKStore
//
//  Created by Kuroba.Lei on 2018/6/12.
//  Copyright © 2018年 K.Lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKFeatureCell : UICollectionViewCell
/* imageView */
@property (strong , nonatomic)UIImageView *nfImageView;

/** 隐藏新特性按钮点击回调 */
@property (nonatomic, copy) dispatch_block_t hideButtonClickBlock;

/* 跳过图片素材 */
@property (strong , nonatomic)NSString *hideBtnImg;

// 最后一张底端的立即体验按钮
@property (nonatomic, strong) UIButton *jumpButton;

/**
 用来获取页码
 
 @param currentIndex 当前index
 @param lastIndex 最后index
 */
- (void)kl_GetCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex;

@end

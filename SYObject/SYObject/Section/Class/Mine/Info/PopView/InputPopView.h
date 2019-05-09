//
//  InputPopView.h
//  SYObject
//
//  Created by Rubyuer on 2019/5/6.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GetInputDataBlock)(NSString *msg);

@interface InputPopView : UIView

- (instancetype)initWithType:(NSInteger)type;

- (void)show;

@property (nonatomic, copy) GetInputDataBlock getInputDataBlock;

@end

NS_ASSUME_NONNULL_END

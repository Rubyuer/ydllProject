//
//  DetailHeadView.m
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "DetailHeadView.h"

@implementation DetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeadView" owner:self options:nil] lastObject];
        self.frame = frame;
    }
    return self;
}

@end

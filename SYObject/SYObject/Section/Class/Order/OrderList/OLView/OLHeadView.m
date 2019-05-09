//
//  OLHeadView.m
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "OLHeadView.h"

@implementation OLHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"OLHeadView" owner:self options:nil] lastObject];
        self.frame = frame;
    }
    return self;
}

@end

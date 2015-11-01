//
//  SGTextLabelView.m
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGTextLabel.h"

@implementation SGTextLabel

- (instancetype)init {
    if (self = [super init]) {
    self.textColor = [UIColor blackColor];
    self.numberOfLines = 0;
    self.font = [UIFont systemFontOfSize:16];
        [self sizeToFit];
    }
    return self;
}

@end

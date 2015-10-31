//
//  SGHomeBtn.m
//  SGWeiBo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGHomeBtn.h"

@implementation SGHomeBtn



- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect labelFrame = self.titleLabel.frame;
    CGRect imageFrame = self.imageView.frame;
    
    imageFrame.origin.x = 0;
    labelFrame.origin.x = imageFrame.size.width + 3;
    
    self.imageView.frame = imageFrame;
    self.titleLabel.frame = labelFrame;
}

@end

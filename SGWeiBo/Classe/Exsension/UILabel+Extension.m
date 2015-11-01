//
//  UILabel+Extension.m
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UILabel+Extension.h"
#import <UIKit/UIKit.h>
@implementation UILabel (Extension)

+ (instancetype)labelWithFontSize: (CGFloat)fontSize textColor:(UIColor *)color {
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    return label;
}
@end

//
//  UIButton+Extension.m
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (instancetype)initWithTitle:(NSString *)title bgColor:(UIColor *)color imageName:(NSString *)imageName {
    if (self = [super init]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}


+ (instancetype)buttonWIthBgNorImage:(NSString *)norimageName WithHeilight:(NSString *)heiLightImageName WithFram:(CGRect)rect {
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    [button setBackgroundImage:[UIImage imageNamed:norimageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:heiLightImageName] forState:UIControlStateHighlighted];
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title norImage:(NSString *)norImage heilightImage:(NSString *)heilightImage {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:heilightImage] forState:UIControlStateHighlighted];
    return button;
}
@end

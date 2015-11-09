//
//  UIButton+Extension.h
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

- (instancetype)initWithTitle:(NSString *)title bgColor:(UIColor *)color imageName:(NSString *)imageName;

+ (instancetype)buttonWIthBgNorImage:(NSString *)norimageName WithHeilight:(NSString *)heiLightImageName WithFram:(CGRect)rect;

+ (instancetype)buttonWithTitle:(NSString *)title norImage:(NSString *)norImage heilightImage:(NSString *)heilightImage;
@end

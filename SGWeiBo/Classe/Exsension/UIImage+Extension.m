//
//  UIImage+Extension.m
//  PictureSelectView
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)scaleImage:(UIImage *)image {
    CGFloat width = 300;
    if (image.size.width <= 300) {
        return image;
    }
    // 获得高度的比例值的高度
    CGFloat height = image.size.height / image.size.width * width;
    //
    UIImage *newImage = [[UIImage alloc] init];
    // 开启newImage的图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    // 将图片绘制上去
    [image drawInRect:CGRectMake(0, 0, width, height)];
    // 从上下文中获取图片
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 记得关闭图形上下而
    UIGraphicsEndImageContext();
    return newImage;
}





@end

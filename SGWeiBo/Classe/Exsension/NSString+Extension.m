//
//  NSString+Extension.m
//  SGWeiBo
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


+ (CGSize)stringWithTitle:(NSString *)title WithSize:(CGSize)size WithAttribute:(NSDictionary *)dic {
    return [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}
@end

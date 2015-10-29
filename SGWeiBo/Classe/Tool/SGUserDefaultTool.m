//
//  SGUserDefault.m
//  SGWeiBo
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGUserDefaultTool.h"

@implementation SGUserDefaultTool

+ (void)saveDouble:(CGFloat)value forKey:(NSString *)key {
    NSUserDefaults *useDefault = [NSUserDefaults standardUserDefaults];
    [useDefault setDouble:value forKey:key];
}

+ (CGFloat)doubleForKey:(NSString *)key {
    NSUserDefaults *useDefault = [NSUserDefaults standardUserDefaults];
    CGFloat value = [useDefault doubleForKey:key];
    return value;
}


@end

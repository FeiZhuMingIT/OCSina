//
//  SGUserDefault.h
//  SGWeiBo
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SGUserDefaultTool : NSObject

+ (void)saveDouble:(CGFloat)value forKey:(NSString *)key;
+ (CGFloat)doubleForKey:(NSString *)key;

@end

//
//  SGaCordingTool.h
//  SGWeiBo
//
//  Created by wzz on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGaCordingTool : NSObject

// 将一个对象归档
+ (void)acoderWithobject:(id)object WithfielName:(NSString *)fileName;

+ (instancetype)unarchiverWithfileName:(NSString *)fileName;
@end

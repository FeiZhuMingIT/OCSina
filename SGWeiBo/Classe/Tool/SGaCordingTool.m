//
//  SGaCordingTool.m
//  SGWeiBo
//
//  Created by wzz on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGaCordingTool.h"

@implementation SGaCordingTool

+ (void)acoderWithobject:(id)object WithfielName:(NSString *)fileName {
    NSString *home = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *aCodringPath = [home stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver",fileName]];
    [NSKeyedArchiver archiveRootObject:object toFile:aCodringPath];
}


@end

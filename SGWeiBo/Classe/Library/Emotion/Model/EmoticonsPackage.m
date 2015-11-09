//
//  EmoticonsPlist.m
//  SGEmotion
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EmoticonsPackage.h"

@implementation EmoticonsPackage

- (instancetype)initWithDiction:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
        // 将NSArr装换成attachment
    }
    return self;
}
+ (instancetype)packageWithDiction:(NSDictionary *)dic
{
    return [[self alloc] initWithDiction:dic];
}
+ (instancetype)package
{
    NSString *pathFile = [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle/emoticons.plist" ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:pathFile];
    EmoticonsPackage *packges = [EmoticonsPackage packageWithDiction:dic];

    return packges;
}

@end

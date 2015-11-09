//
//  EmoticonsPlist.h
//  SGEmotion
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmoticonsPackage : NSObject
@property (nonatomic,assign)NSInteger version;
// 组
@property (nonatomic,strong)NSArray *packages;

-(instancetype)initWithDiction:(NSDictionary *)dic;
+(instancetype)packageWithDiction:(NSDictionary *)dic;
+(instancetype)package;
@end

//
//  Emotion.h
//  SGEmotion
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emotion : NSObject
@property (nonatomic,copy)NSString * id;
// emoji表情
@property (nonatomic,copy)NSString *code;
// 默认表情
@property (nonatomic,copy)NSString *chs;
@property (nonatomic,copy)NSString *cht;
@property (nonatomic,copy)NSString *png;

// 删除按钮
@property (nonatomic,strong)NSString *removeEmoji;
// 点击的次数
@property(nonatomic,assign) NSInteger degreeTimes;
// 浪小花
-(instancetype)initWithDiction:(NSDictionary *)dic;
+(instancetype)emotionWithDiction:(NSDictionary *)dic;

@end

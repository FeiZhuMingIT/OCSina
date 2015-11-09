//
//  EmotionAttachment.h
//  SGEmotion
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Emotion;
@interface EmotionAttachment : NSObject

@property (nonatomic,strong)NSString *id;
@property (nonatomic,assign)NSInteger  version;
@property (nonatomic,assign)NSInteger  display_only;
// 组名
@property (nonatomic,strong)NSString *group_name_cn;
//
@property (nonatomic,strong)NSString *group_name_tw;
// 拼音名字
@property (nonatomic,strong)NSString *group_name_en;
// 该组的所有表情
@property (nonatomic,strong)NSMutableArray *emoticons;
- (void)appendEmotion:(Emotion *)emtion;
-(instancetype)initWithDiction:(NSDictionary *)dic;
+(instancetype)emotionAttachmentWithDiction:(NSDictionary *)dic;
+(NSArray *)emotionAttachments;
@end

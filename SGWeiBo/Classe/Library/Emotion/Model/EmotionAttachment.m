//
//  EmotionAttachment.m
//  SGEmotion
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EmotionAttachment.h"
#import "EmoticonsPackage.h"
#import "Emotion.h"
@implementation EmotionAttachment

static NSInteger number = 0;
// NSInteger number = 0;
- (instancetype)initWithDiction:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)emotionAttachmentWithDiction:(NSDictionary *)dic
{
    return [[self alloc] initWithDiction:dic];
}


+ (instancetype)EmojinAttachmentWithString:(NSString *)id {
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Emoticons.bundle/%@/info.plist",id] ofType:nil];
    // 添加一个 标记，在后面加一个删除按钮
    // 这样就拿到了每个文件夹对应的路径
    // 再读取文件转换成类
    // 读取plista文件
//    self.emotions = [NSMutableArray array];
    NSDictionary *emtionDic = [NSDictionary dictionaryWithContentsOfFile:path];
    // 创建Emion
    EmotionAttachment *attachment = [EmotionAttachment emotionAttachmentWithDiction:emtionDic];
    
    // 最后再让emtion字典转模型
    [attachment setupEmojin];
    // 判断一下如果mtbArr 不是21的倍数，那么给它加够21
    [attachment setPull];
    return attachment;
}
#pragma mark - 最后再让emtion字典转模型
- (void) setupEmojin {
    NSMutableArray *mtbArr = [self.emoticons copy];
    self.emoticons = [NSMutableArray array];
    for (NSDictionary *dic in mtbArr) {
        if (number == 20) {
            [self setRemoveEmojin];
        }
        Emotion *emtion = [Emotion emotionWithDiction:dic];
        emtion.id =self.id;
        [self.emoticons addObject:emtion];
        ++number;
        
    }
}
#pragma mark - 添加到21的倍数个
// 判断一下如果mtbArr 不是21的倍数，那么给它加够21个
- (void) setPull {
    while (self.emoticons.count % 21 != 0 || self.emoticons.count == 0) {
        if (number == 20 ) {
            [self setRemoveEmojin];
            number = 0;
            return ;
        } else {
            Emotion *emtion = [[Emotion alloc] init];
            [self.emoticons addObject:emtion];
        }
        number++;
    }
}


#pragma mark - 添加一个元素
- (void)appendEmotion:(Emotion *)emtion {
   
    // 根据时间排序
    emtion.degreeTimes++;
    
    if ([self.emoticons containsObject:emtion]) {
        self.emoticons =  [NSMutableArray arrayWithArray:[self.emoticons sortedArrayUsingComparator:^NSComparisonResult(Emotion *  _Nonnull obj1, Emotion *  _Nonnull obj2) {
            return obj1.degreeTimes < obj2.degreeTimes;
        }]];
        return;
    } else {
        [self.emoticons addObject:emtion];
    }
    // 排序
    self.emoticons =  [NSMutableArray arrayWithArray:[self.emoticons sortedArrayUsingComparator:^NSComparisonResult(Emotion *  _Nonnull obj1, Emotion *  _Nonnull obj2) {
        return obj1.degreeTimes < obj2.degreeTimes;
    }]];
    // 长度应该是20
    NSRange rang = NSMakeRange(0, 20);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:rang];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self.emoticons objectsAtIndexes:indexSet]];
    self.emoticons = arr;
    

    // 添加一个删除按钮在最后面
    [self setRemoveEmojin];
}

#pragma mark - 如果是第21个添加删除按钮
- (void)setRemoveEmojin {
    Emotion *emtion1 = [[Emotion alloc] init];
    emtion1.removeEmoji = @"compose_emotion_delete";
    [ self.emoticons addObject:emtion1];
    number = 0;
}


+(NSArray *)emotionAttachments
{
    // 只加载一次
    NSMutableArray *mtbArr = [NSMutableArray array];
    // 暂时手动添加一个最近
    EmotionAttachment *EplemtAttachment = [[EmotionAttachment alloc] init];
#warning 因为是数组所以要给它创建一个数据
    EplemtAttachment.emoticons = [NSMutableArray array];
    [EplemtAttachment setPull];
    [mtbArr addObject:EplemtAttachment];
    EmoticonsPackage *emotionPackage = [EmoticonsPackage package];
    for (NSDictionary *dic in emotionPackage.packages) {
        EmotionAttachment *attachment = [EmotionAttachment EmojinAttachmentWithString:dic[@"id"]];
        [mtbArr addObject:attachment];
    }
    return mtbArr;
}

#pragma mark - 没有对应key的时候调用
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};



@end

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
#import "SGEmotionAttachment.h"
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

#pragma mark - 将一个文本转换成字符串
+ (NSAttributedString *)emotionStringToEmtionString:(NSString *)textString font:(UIFont *)font {
    // 拿到文本字符串配置正则表达式
    NSString *pattern = @"\\[.*?\\]";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    
    // 查找字符串的表情字符
    NSArray *results = [expression matchesInString:textString options:NSMatchingReportProgress range:NSMakeRange(0, textString.length)];
    
    
    // 将传进来的字符串设置为属性文本
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textString];
    NSInteger count = results.count;
    // 修改属性文本
    while (count > 0) {
        // 从后面获取
        NSTextCheckingResult *result = results[--count];
        NSRange range = [result rangeAtIndex:0];
        NSAttributedString *rangString = [attributedString attributedSubstringFromRange:range];
        Emotion *emtion = [EmotionAttachment emotionWithString:rangString.string] ;
        if ( emtion.png != nil) {
            SGEmotionAttachment *attachment = [[SGEmotionAttachment alloc] init];
            attachment.emotion = emtion;
            //设置图片大小 和字体高度
            CGFloat imageW = font.lineHeight + 2;
            CGFloat imageH = imageW;
            // 普通图片位置不好看
            attachment.bounds = CGRectMake(0, -3, imageW, imageH);
            // 将附件转换成属性文本
            NSAttributedString *imageAttribute = [NSAttributedString attributedStringWithAttachment:attachment];
            //
            [attributedString replaceCharactersInRange:range withAttributedString:imageAttribute];
            
        }
        
        //  遍历所有emjin表情
        NSLog(@"%@",rangString);
    }
    return [[NSAttributedString alloc] initWithAttributedString:attributedString];
}


/*
 - (void)appendEmotion:(Emotion *)emotion {
 if (emotion.code) {
 // 通过insert方法来添加表情，会发送 文字内容改变的通知和调用代理
 [self insertText:emotion.code];
 } else {
 NSMutableAttributedString *attStrM = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
 SGEmotionAttachment *attach = [[SGEmotionAttachment alloc] init];
 attach.emotion = emotion;
 // 设置图片大小 = 字体的高度
 CGFloat imgW = self.font.lineHeight + 2;
 CGFloat imgH = imgW;
 // 普通图片位置不好看，往下移动，负数即可
 attach.bounds = CGRectMake(0, -3, imgW, imgH);
 NSAttributedString *imgAttStr = [NSAttributedString attributedStringWithAttachment:attach];
 // 插入的时候，要获取插入的位置
 NSInteger insertIndex = self.selectedRange.location;
 [attStrM insertAttributedString:imgAttStr atIndex:insertIndex];
 // 每次重新设置文本字体大小
 [attStrM addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attStrM.length)];
 self.attributedText = attStrM;
 // 光标回到插入后的位置
 self.selectedRange = NSMakeRange(insertIndex + 1, 0);
 if ([self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
 [self.delegate textViewDidChange:self];
 }
 }
 }
 */

+ (Emotion *)emotionWithString:(NSString *)string {
   NSArray *emtionAttchmengs = [EmotionAttachment emotionAttachments];
    for(EmotionAttachment *emotionAttachment in emtionAttchmengs) {
        for (Emotion *emtion in emotionAttachment.emoticons) {
            NSLog(@"%s",__func__);
            if ([emtion.chs isEqualToString:string]) {
                return emtion;
            }
        }
    }
    return nil;
}





















@end

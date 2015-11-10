//
//  Emotion.m
//  SGEmotion
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "Emotion.h"
#import "EmotionAttachment.h"
#define kEmotionBundlePath [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle" ofType:nil]
#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)
@implementation Emotion

-(instancetype)initWithDiction:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(instancetype)emotionWithDiction:(NSDictionary *)dic
{
    return [[self alloc] initWithDiction:dic];
}
// 实现这个方法 什么都不用写，如果没有匹配到也不会奔溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}





// 拼接路径
- (NSString *)png {
    // 这里如果不返回为nil也会被拦截
    if (_png == nil) {
        return nil;
    }
    return [NSString stringWithFormat:@"%@/%@/%@",kEmotionBundlePath,_id,_png];
}

// 拼接code
- (NSString *)code {
    if (_code == nil) {
        return nil;
    }
    return [self emojiWithStringCode:_code];
}

#pragma mark - 将emjion表情翻译
- (NSString *)emojiWithStringCode:(NSString *)stringCode {
    char *charCode = (char *)stringCode.UTF8String;
    long int intCode = strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:(int)intCode];
}

- (NSString *)emojiWithIntCode:(int)intCode {
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"png:%@  code:%@, removeEmoji:%@ time:%ld",self.png,self.code,self.removeEmoji,self.degreeTimes];
}

@end

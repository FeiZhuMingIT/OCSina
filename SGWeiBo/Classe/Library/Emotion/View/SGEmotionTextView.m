//
//  SGEmotionTextView.m
//  SGEmotion
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGEmotionTextView.h"
#import "Emotion.h"
#import "EmotionAttachment.h"
#import "SGEmotionAttachment.h"
@implementation SGEmotionTextView

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
// 真实的字符串
- (NSString *)realText {
    NSMutableString *strM = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        //        CZLog(@"%@",attrs);
        SGEmotionAttachment *textAtt = attrs[@"NSAttachment"];
        //有附件，获取表情chs
        if(textAtt){
            [strM appendString:textAtt.emotion.chs];
        }else{//文字
            NSAttributedString *attStr =[self.attributedText attributedSubstringFromRange:range];
            [strM appendString:attStr.string];
        }
    }];

    return [strM copy];
}

@end

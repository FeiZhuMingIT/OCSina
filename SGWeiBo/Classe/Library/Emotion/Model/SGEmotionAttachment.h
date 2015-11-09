//
//  SGEmotionAttachment.h
//  SGEmotion
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Emotion;
@interface SGEmotionAttachment : NSTextAttachment
/**
 *  附件里存个表情模型属性
 */
@property(nonatomic,strong)Emotion *emotion;
@end

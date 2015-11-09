//
//  SGEmotionTextView.h
//  SGEmotion
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Emotion;
@interface SGEmotionTextView : UITextView

//添加表情
-(void)appendEmotion:(Emotion *)emotion;
/**
 *  真实的字符串
 *
 */
-(NSString *)realText;

@end

//
//  SGEmotionKeyBoard.h
//  SGEmotion
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UITextView;
@interface SGEmotionKeyBoard : UIView

@property (nonatomic,weak)UITextView *textView;


- (NSString *)realText;
@end

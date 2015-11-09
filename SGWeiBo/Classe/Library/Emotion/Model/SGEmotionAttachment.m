//
//  SGEmotionAttachment.m
//  SGEmotion
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGEmotionAttachment.h"
#import "Emotion.h"
@implementation SGEmotionAttachment

- (void)setEmotion:(Emotion *)emotion {
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}

@end

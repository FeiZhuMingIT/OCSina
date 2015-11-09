//
//  EmtionTool.h
//  SGEmotion
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//、

// 深沉次开发来说，应该是把表情放到一个plist表中，如果下载了表情，那么表情里面的plist会多一个元素，那个元素当plist表遍历的时候就会去加载那个文件的路径下的plist文件，获取到新增文件图片的路径，最后一个根据plist文件中的路径来增添表情
#import <Foundation/Foundation.h>
#import "Emotion.h"
@interface EmtionTool : NSObject
/**
 *  默认表情
 */
+ (NSArray *)defaultsEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions;
/*
 所有表情
 */
+ (NSArray *)allEmotions;
/**
 *  添加最近表情
 *
 */
+ (void)addRecentEmotion:(Emotion *)emotion;

@end

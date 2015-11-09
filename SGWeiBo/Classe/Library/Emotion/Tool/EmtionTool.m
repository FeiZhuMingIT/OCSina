//
//  EmtionTool.m
//  SGEmotion
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EmtionTool.h"
#import "Emotion.h"
#define kEmotionBundlePath [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle" ofType:nil]
@implementation EmtionTool

//+ (NSArray *)allEmotions {
//    NSMutableArray *mtbArr = [NSMutableArray array];
//    NSArray *emotions = [Emotion emotions];
//   
////    for (Emotion *emotion in emotions) {
////        // 得到每一张图片的路径
////        
////        NSString *pathemotion = [NSString stringWithFormat:@"%@/%@/%@",kEmotionBundlePath,emotion.id,emotion.png];
//////        NSLog(@"%@",pathemotion);
////        [mtbArr addObject:pathemotion];
////    }
//    // 这里其实把emotion传出去就是全部的了
//    return emotions;
//}




@end

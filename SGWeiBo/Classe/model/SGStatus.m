//
//  SGStatus.m
//  SGWeiBo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGStatus.h"
#import "SGUser.h"
#import "NSDate+Exsention.h"
#import "EmotionAttachment.h"
@implementation SGStatus


#pragma mark - set & get
- (void)setPic_urls:(NSArray *)pic_urls {
    NSMutableArray *mtb = [NSMutableArray array];
    for (NSDictionary *dic in pic_urls) {
        [mtb addObject:dic[@"thumbnail_pic"]];
    }
    self.picUrls = [mtb copy];
}

- (void)setText:(NSString *)text {
    _text = text;
    _attributedString = [EmotionAttachment emotionStringToEmtionString:text font:[UIFont systemFontOfSize:14]];
}


- (void)setPicUrls:(NSArray *)picUrls {
    _picUrls = picUrls;
    NSMutableArray *lagerArr = [NSMutableArray array];
    NSMutableArray *bmiddleArr = [NSMutableArray array];
    for (int index = 0; index < picUrls.count; index ++) {
        NSString *pathFile = self.picUrls[index];
      NSString *lagerString = [pathFile stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
        NSString *bmiddleString = [pathFile stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        [lagerArr addObject:lagerString];
        [bmiddleArr addObject:bmiddleString];
    }
    _largeStrings = [lagerArr copy];
    _bmiddleStrings = [bmiddleArr copy];
}


+ (NSString *)getLargeURlWithpicUrl:(NSString *)picUrl {
   return  [picUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
}

- (void)setCreated_at:(NSString *)created_at {
    _created_at = created_at;
    self.creadtedDate = [NSDate sinaDateDescrition:created_at];
}

@end

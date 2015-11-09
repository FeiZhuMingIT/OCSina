//
//  SGStatus.m
//  SGWeiBo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGStatus.h"
#import "SGUser.h"


@implementation SGStatus



- (void)setPic_urls:(NSArray *)pic_urls {
    NSMutableArray *mtb = [NSMutableArray array];
    for (NSDictionary *dic in pic_urls) {
        [mtb addObject:dic[@"thumbnail_pic"]];
    }
    self.picUrls = [mtb copy];
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
@end

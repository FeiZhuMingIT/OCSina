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
@end

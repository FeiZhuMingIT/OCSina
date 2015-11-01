//
//  SGStatus.h
//  SGWeiBo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SGUser;
@interface SGStatus : NSObject
@property (nonatomic,strong)NSString * created_at;
@property (nonatomic,strong)NSString * idstr;
@property (nonatomic,strong)NSString * text;
@property (nonatomic,strong)NSString * source;
@property (nonatomic,strong)NSArray * pic_urls;
// 图片数据字典
@property (nonatomic,strong)NSArray * picUrls;
@property (nonatomic,strong)SGUser * user;

// 先模拟数据
+ (NSArray *)loadStatusData;
@end

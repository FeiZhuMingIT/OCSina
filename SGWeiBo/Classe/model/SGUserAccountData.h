//
//  SGUserAccountData.h
//  SGWeiBo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGUserAccountData : NSObject
/**
 * 微博数据，里面存储CZStatus模型
 */
@property(nonatomic,strong)NSArray *statuses;

/**
 * 近期微博总数
 */
@property (nonatomic, assign) int total_number;

//
+ (instancetype)shareUserAccount;
@end

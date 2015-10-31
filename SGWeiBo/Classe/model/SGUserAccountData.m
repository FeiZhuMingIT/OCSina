//
//  SGUserAccountData.m
//  SGWeiBo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGUserAccountData.h"

@implementation SGUserAccountData

+ (instancetype)shareUserAccount {
    static SGUserAccountData * userAccount;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userAccount = [[self alloc] init];
    });
    return userAccount;
}

@end

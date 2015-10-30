//
//  SGaAuth.m
//  SGWeiBo
//
//  Created by wzz on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGUserAccount.h"

@implementation SGUserAccount

+ (instancetype)shareUserAccount {
    static SGUserAccount *userAccount;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userAccount = [[self alloc] init];
    });
    return userAccount;
}
@end

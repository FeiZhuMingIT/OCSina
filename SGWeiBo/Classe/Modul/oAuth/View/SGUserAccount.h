//
//  SGaAuth.h
//  SGWeiBo
//
//  Created by wzz on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
// 归档要记得添加
@interface SGUserAccount : NSObject <NSCoding>
// uid
@property(nonatomic,strong)NSString *uid;
// expires_in
@property(nonatomic,assign)NSTimeInterval expires_in;
// access_token
@property(nonatomic,strong)NSString *access_token;
// names
@property(nonatomic,strong)NSString *name;
// profile_image_url
@property(nonatomic,strong)NSString *profile_image_url;
// icon
+ (instancetype)shareUserAccount;

// saveAccount
- (void)saveAccount;
+ (instancetype)loadAccount;
@end

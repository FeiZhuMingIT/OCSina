//
//  SGaAuth.m
//  SGWeiBo
//
//  Created by wzz on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGUserAccount.h"
#define kAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]  stringByAppendingPathComponent:@"userAccont.archiver"]
@interface SGUserAccount()
@property(nonatomic,strong)NSString *accountPath;
@end
@implementation SGUserAccount

+ (instancetype)shareUserAccount {
    static SGUserAccount *userAccount;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userAccount = [[self alloc] init];
    });
    return userAccount;
}


#pragma mark - 归档 解档 保存和解档数据
// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.profile_image_url forKey:@"profile_image_url"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeDouble:self.expires_in forKey:@"expires_in"];
}

// 解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.profile_image_url = [aDecoder decodeObjectForKey:@"profile_image_url"];
    self.uid = [aDecoder decodeObjectForKey:@"uid"];
    self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
    self.expires_in = [aDecoder decodeDoubleForKey:@"expires_in"];
    return self;
}

- (void)saveAccount {
    [NSKeyedArchiver archiveRootObject:self toFile:kAccountPath];
}
+ (instancetype)loadAccount {
   SGUserAccount *userAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    return userAccount;
}

#pragma mark - set & get

-(NSString *)accountPath {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]  stringByAppendingPathComponent:@"userAccont.archiver"];
}


@end

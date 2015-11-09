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
    //  解档是一个消耗性能的操作，如果系统缓存中有了就不需要再解档了
    static SGUserAccount *userAccount;
    if (userAccount == nil) { // 如果它是nil就解档，如果不是就不需要解档 直接用就好了
        userAccount = (SGUserAccount *)[NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    }
//    sharAccount = 
    return userAccount;
}

#pragma mark - set & get

-(NSString *)accountPath {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]  stringByAppendingPathComponent:@"userAccont.archiver"];
}


@end

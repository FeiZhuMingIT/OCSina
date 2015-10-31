//
//  SGAFNTool.m
//  SGWeiBo
//
//  Created by wzz on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGAFNTool.h"
#import "SGUserAccount.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "SGWelcomeVc.h"
@interface SGAFNTool()
@property(nonatomic,strong)SGUserAccount *userAccount;
@end
@implementation SGAFNTool

+ (instancetype)shareAFNTool {
    static SGAFNTool *aFNTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
aFNTool = [[self alloc] init];
    });
    return aFNTool;
}



- (AFHTTPSessionManager *)afnHttpManager {
    AFHTTPSessionManager *afnHttpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.weibo.com/"]];
    afnHttpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",nil];
    return afnHttpManager;

    
}
#pragma mark - 申请access_token
// 这里要把加载的结果传出去
- (void)access_tokenWithCode:(NSString *)code {

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //
    parameters[@"client_id"] = self.client_id;
    parameters[@"client_secret"] = self.client_secret;
    parameters[@"grant_type"] = self.grant_type;
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = self.redirect_uri;

    [self.afnHttpManager POST:@"oauth2/access_token" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.userAccount.access_token = responseObject[@"access_token"];
        self.userAccount.uid = responseObject[@"uid"];
        self.userAccount.expires_in = [responseObject[@"expires_in"] doubleValue];
        // 归档
        [self.userAccount saveAccount];
        // 归档完之后要跳刀下一个界面
       [UIApplication sharedApplication].keyWindow.rootViewController = [[SGWelcomeVc alloc] init];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力" maskType:SVProgressHUDMaskTypeBlack];
    }];
}
#pragma mark - set&get
// 请求网址
- (NSString *)authorize {
    return [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code",self.client_id,self.redirect_uri];
}
// appScret
- (NSString *)client_id {
    return @"2283739048";
}
// redirect_uri
- (NSString *)redirect_uri {
    return @"http://baidu.com/";
}

-(NSString *)client_secret {
    return @"c456852b3458051f87c1baae734e0dc5";
}
- (NSString *)grant_type {
    return @"authorization_code";
}
- (SGUserAccount *)userAccount {
    if (!_userAccount) {
        _userAccount = [SGUserAccount loadAccount];
    }
    return _userAccount;
}

#pragma mark - ERROR
- (NSError *)errorWithNetworkErrorType:(SGNetworkErrorType)networkErrorType {
    
    NSString *useInfo;
    switch (networkErrorType) {
        case -1:
            useInfo = @"accecc token 为空";
            break;
        case -2:
            useInfo = @"uid 为空";
        default:
            return nil;
    }
    return [[NSError  alloc] initWithDomain:@"cn.itcast.error.network" code:networkErrorType userInfo:@{@"errorDescription":useInfo}];
}
@end

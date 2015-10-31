//
//  SGAFNTool.h
//  SGWeiBo
//
//  Created by wzz on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//
/**
    client_id:  2283739048
    App Secret：c456852b3458051f87c1baae734e0dc5
    redirect_uri：http://baidu.com/
 */
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
// 全局 一般这种写法用于通知
//extern NSString * const kAuthorize;

@interface SGAFNTool : NSObject
@property(nonatomic,strong)AFHTTPSessionManager *afnHttpManager;
// 请求网址
@property(nonatomic,strong,readonly)NSString *authorize;
// appScret
@property(nonatomic,strong,readonly)NSString *client_id;
// redirect_uri
@property(nonatomic,strong,readonly)NSString *redirect_uri;
// client_secret 加载时候 分配的 App Secret
@property(nonatomic,strong,readonly)NSString *client_secret;
// authorization_code
@property(nonatomic,strong)NSString *grant_type;

//单例对象
+ (instancetype)shareAFNTool;


// 加载 access_token
- (void)access_tokenWithCode:(NSString *)code;


@end
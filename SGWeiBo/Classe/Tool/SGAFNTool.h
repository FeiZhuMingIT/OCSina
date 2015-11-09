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
typedef void(^Success)(id data);
typedef void(^Falure)(NSError *error);
// 网络错误枚举
typedef NS_ENUM(NSInteger, SGNetworkErrorType) {
    SGNetworkErrorTypeEmptyToken = -1,
    SGNetworkErrorTypeEmptyUid = -2
};

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


// 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
@property (nonatomic,assign)NSInteger  since_id;
// 网络请求
@property (nonatomic,assign)NSInteger  max_id;

//单例对象
+ (instancetype)shareAFNTool;


// 加载 access_token
- (void)access_tokenWithCode:(NSString *)code;


// 网络错误枚举方法
- (NSError *)error;


- (NSDictionary *)loadData;

// 发送微博 只能发送一张
- (void)sendStatusWithImage:(UIImage *)image statues:(NSString *)statues success:(Success)success falure:(Falure)falure;

//
#pragma mark - 网络加载数据2
- (void)loadNewStatusWithSince_id:(NSInteger)since_id WithMax_id:(NSInteger)max_id Success:(Success)success andFalure:(Falure)falure;
@end

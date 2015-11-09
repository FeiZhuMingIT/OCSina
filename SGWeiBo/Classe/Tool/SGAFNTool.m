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
#import "SGStatus.h"
#import "MJExtension.h"

typedef void(^Success)(id data);
typedef void(^Falure)(NSError *error);
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
        if(_userAccount == nil) {
            _userAccount  = [[SGUserAccount alloc] init];
        }
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

#pragma mark - 加载网络数据
// 现在加载本地数据以后换成加载网络数据
- (NSDictionary *)loadData {
    NSString *dataFlie = [[NSBundle mainBundle] pathForResource:@"statuses" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:dataFlie];
    // 解析文件 ,有可能解析失败 用try -case // 临时用不管它
//    NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
}



#pragma mark - 网络加载数据2
- (void)loadNewStatusWithSince_id:(NSInteger)since_id WithMax_id:(NSInteger)max_id Success:(Success)success andFalure:(Falure)falure  {
    self.userAccount = [SGUserAccount loadAccount];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    

    parameters[@"access_token"] = self.userAccount.access_token;
    // 默认为0
    parameters[@"since_id"] = @(since_id);
    // 默认为0
    parameters[@"max_id"] = @(max_id);
    [self.afnHttpManager GET:@"2/statuses/home_timeline.json" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"%@",task);
        self.userAccount = [SGUserAccount loadAccount];
        NSArray *dicArr = responseObject[@"statuses"];
        success(dicArr);
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载错误" maskType:3];
        falure(error);
    }];
}

#pragma mark 发送微博
- (void)sendStatusWithImage:(UIImage *)image statues:(NSString *)statues success:(Success)success falure:(Falure)falure {
    SGUserAccount *userAccount = [SGUserAccount loadAccount];
    // token有值, 拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = userAccount.access_token;
    parameters[@"status"] = statues;
    if (image == nil) { // 发送没有图片的微博
        NSString *strUrl = @"2/statuses/update.json";
        [self.afnHttpManager POST:strUrl parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            falure(error);
        }];
    } else { // 当图片不是nil
        NSString *sendImageStatuesUrl = @"https://upload.api.weibo.com/2/statuses/upload.json";
        [self.afnHttpManager POST:sendImageStatuesUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            // 添加图片的二进制
            NSData *imageData = UIImagePNGRepresentation(image);
            // data: 上传图片的2进制
            // name: api 上面写的传递参数名称 "pic"
            // fileName: 上传到服务器后,保存的名称,没有指定可以随便写
            // mimeType: 资源类型:
            // image/png
            // image/jpeg
            // image/gif
            [formData appendPartWithFileData:imageData name:@"pic" fileName:@"SB" mimeType:@"image/png"];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            falure(error);
        }];
    }
}

@end

//
//  SGoAuthVc.m
//  SGWeiBo
//
//  Created by wzz on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGoAuthVc.h"
#import "SGAFNTool.h"
#import "SVProgressHUD.h"
@interface SGoAuthVc ()<UIWebViewDelegate>
@property(nonatomic,weak)UIWebView *webView;
@property(nonatomic,strong)SGAFNTool *afnTool;
@end

@implementation SGoAuthVc

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubView];

    [self setRequest];

    
}


- (void)setupSubView {
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;

}

- (void)setRequest {
    NSURL *url = [NSURL URLWithString:self.afnTool.authorize];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 跳到之前的登陆界面
- (void)close {
    [SVProgressHUD dismiss];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{

    }];
}

#pragma mark - webViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // http://baidu.com/?code=b3c4eec9898895c452fd95c5149e96f9
//    NSLog(@"%@",request.URL);
    //如果他们的路径不包含回调地址，那么说明是申请的地址，让它们加载
    //绝对路径
    if (![request.URL.absoluteString hasPrefix:self.afnTool.redirect_uri]) {
        return YES;
    }
    // query 查询， 就是看问好后面的网址
    NSString *query = request.URL.query;
    NSLog(@"%@",query);
    //拿到用于调用access_token，接口获取授权后的access token。
    if ([query hasPrefix:@"code="]) {
        NSString * code = [query substringFromIndex:@"=code".length];
        NSLog(@"%@",code);
        [self.afnTool access_tokenWithCode:code];
    }
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeBlack];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self close];
}


#pragma mark - set&get

- (SGAFNTool *)afnTool {
    if (!_afnTool) {
        _afnTool = [SGAFNTool shareAFNTool];
    }
    return _afnTool;
}


@end

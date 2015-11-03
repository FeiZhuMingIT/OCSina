//
//  SGBaseTableViewVc.m
//  SGWeiBo
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGBaseTableViewVc.h"
#import "SGLoginView.h"
#import "SGHomeTableViewVc.h"
#import "SGDiscoverTableViewVc.h"
#import "SGMessageTableViewVc.h"
#import "SGProfileTableViewVc.h"
#import "SGoAuthVc.h"
#import "SGUserAccount.h"
#import "SGSendController.h"
@interface SGBaseTableViewVc() <SGLoginViewDelegate>

@end
@implementation SGBaseTableViewVc

- (void)loadView {
   
    
    SGUserAccount *userAccount = [SGUserAccount loadAccount];
    if (userAccount.access_token) {
        [super loadView];
    } else {
        [self setUpView];
        [self setupButton];
    }
    
}


- (void)setUpView {
    SGLoginView *loginView = [[SGLoginView alloc] init];
    if ([self isKindOfClass: [SGHomeTableViewVc class]]) {
        [loginView setSubViewWithMasterImage:@"visitordiscover_feed_image_house" loopImage:@"visitordiscover_feed_image_smallicon" title:@"主页"];
    } else if ([self isKindOfClass: [SGDiscoverTableViewVc class]]) {
        [loginView setSubViewWithMasterImage:@"visitordiscover_image_message" loopImage:nil title:@"发现"];
    } else if ([self isKindOfClass: [SGMessageTableViewVc class]]) {
        [loginView setSubViewWithMasterImage:@"visitordiscover_image_message" loopImage:nil title:@"信息"];
    } else if ([self isKindOfClass: [SGProfileTableViewVc class]]) {
        [loginView setSubViewWithMasterImage:@"visitordiscover_image_profile" loopImage:nil title:@"我"];
    }
    loginView.backgroundColor = [UIColor colorWithWhite:237.0/255.0f alpha:1];
    loginView.delegate = self;
    self.view = loginView;
    
}

- (void)setupButton {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(loginBtnDidClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerBtnDidClick)];
}

- (void)loginBtnDidClick {
    
    // 加载
    SGoAuthVc *vc = [[SGoAuthVc alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backController)];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)backController {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)registerBtnDidClick {
    
}

#pragma mark - loginView代理方法
- (void)loginView:(SGLoginView *)loginView loginBtn:(UIButton *)loginBtn {
    [self loginBtnDidClick];
}

- (void)loginView:(SGLoginView *)loginView registerBtn:(UIButton *)loginBtn {
    [self registerBtnDidClick];
}
@end

//
//  SGWelcomeVc.m
//  SGWeiBo
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

// 2/statuses/home_timeline.json

#import "SGWelcomeVc.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "SGUserAccount.h"
#import "SGAFNTool.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "SGaCordingTool.h"
#import "SGTabBarVC.h"
#import "SGStatus.h"
#import "SGUser.h"
#import "SGUserAccountData.h"
#define kTextLabel @"欢迎回来"
@interface SGWelcomeVc ()
// 网络加载工具
@property(nonatomic,strong)SGAFNTool *afnTool;
// 用户类
@property(nonatomic,strong)SGUserAccount *userAccount;
@property (nonatomic,weak)UILabel * textLable;
@property (nonatomic,weak)UIImageView * iconView;
@property (nonatomic,weak)NSLayoutConstraint * iconViewTopCons;
@property (nonatomic,weak)UIImageView * bgImageView;
@end

@implementation SGWelcomeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取用户数据
    [self loginUserData];
    
    [self setupSubView];
    
    [self setupSubViewFrame];
}

- (void)setupSubView {
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"ad_background"];
    [self.view addSubview:bgImageView];
    self.bgImageView = bgImageView;
    
    UILabel *textLable = [[UILabel alloc] init];
    textLable.text = kTextLabel;
    textLable.alpha = 0;
    self.textLable = textLable;
    [self.textLable sizeToFit];
    [self.view addSubview:textLable];

    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.layer.cornerRadius = 42.5;
    //先给一张默认的图片先
//    iconView.backgroundColor = [UIColor orangeColor];
    iconView.image = [UIImage imageNamed:@"avatar_default_big"];
//     [self.iconView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
    iconView.layer.masksToBounds = YES;
    [self.view addSubview:iconView];
    self.iconView = iconView;
//    [self setupIconViewImage];

  
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.iconViewTopCons.constant = -([UIScreen mainScreen].bounds.size.height - 60);
    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:0 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.textLable.alpha = 1;
        } completion:^(BOOL finished) {
            //跳转控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = [[SGTabBarVC alloc] init];
        }];
    }];
}

- (void)setupSubViewFrame {
    
    self.bgImageView.frame = [UIScreen mainScreen].bounds;
    
    //
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *iconViewCentenX = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *iconViewTop = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-160];
    self.iconViewTopCons = iconViewTop;
    NSLayoutConstraint *iconViewWidth = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:85];
    NSLayoutConstraint *iconViewHeight = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:85];

    [self.view addConstraints:@[iconViewCentenX,iconViewHeight,iconViewTop,iconViewWidth]];
    
    [self.textLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).with.offset(16);
        make.centerX.equalTo(self.iconView.mas_centerX);
    }];
    
}

#pragma mark - 获取用户数据
- (void)loginUserData {
    //    2.00xetysCmq1YUC8e30c0d792Uyru6C 模拟让access_token直接取 实际上是从远程拿或者解档
    // 解档数据 这段代码需要增加很多判断，比如如果没有数据那么 access_token 就应该从另外一个地方加载进来
    // 不过第一次加载数据的时候会保存数据 所以应该加载一下缓存看缓存有没有，没有再解档，再判断
//    self.userAccount = [SGUserAccount shareUserAccount];
    self.userAccount = [SGUserAccount loadAccount];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    parameters[@"access_token"] = self.userAccount.access_token;
    [self.afnTool.afnHttpManager GET:@"2/statuses/home_timeline.json" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.userAccount = [SGUserAccount loadAccount];
        NSArray *statuses = responseObject[@"statuses"];
        SGUserAccountData *userAccountData = [SGUserAccountData shareUserAccount];
        userAccountData.statuses= [SGStatus objectArrayWithKeyValuesArray:statuses];
        NSLog(@"%@",userAccountData.statuses);
        NSDictionary *statuses0 = statuses[0];
        NSDictionary *user = statuses0[@"user"];
        self.userAccount.profile_image_url = user[@"avatar_large"];
        self.userAccount.name = user[@"name"];
        // 归档
        [self.userAccount saveAccount];
        
        // 这个加载完成才能setuoIconViewImage // 除非是解档出来的
        NSLog(@"%@",self.userAccount.profile_image_url);
        if (self.userAccount.profile_image_url) {
            [self setupIconViewImage];
        }


    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载错误" maskType:3];
    }];
    

}

#pragma mark -  加载iconViewimage
- (void)setupIconViewImage {
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.userAccount.profile_image_url]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - set&get
- (SGUserAccount *)userAccount {
    if (!_userAccount) {
        _userAccount = [SGUserAccount loadAccount];
    }
    return _userAccount;
}
- (SGAFNTool *)afnTool {
    if (!_afnTool) {
        _afnTool = [SGAFNTool shareAFNTool];
    }
    return _afnTool;
}


@end

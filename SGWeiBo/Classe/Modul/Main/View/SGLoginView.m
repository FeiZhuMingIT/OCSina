//
//  SGLoginView.m
//  SGWeiBo
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGLoginView.h"
#import "Masonry.h"
@interface SGLoginView()
@property (nonatomic,weak)UIImageView * masterView;
@property (nonatomic,weak)UIImageView * loopView;
@property (nonatomic,weak)UILabel * titleLabel;
@property (nonatomic,weak)UIButton * loginBtn;
@property (nonatomic,weak)UIButton * registerBtn;
@property (nonatomic,weak)UIImageView * coverView;
@end
@implementation SGLoginView

+ (instancetype)loginViewWithMasterImage: (NSString *)masterImage loopImage:(NSString *)loopImage title: (NSString *)title  {
    SGLoginView *loginView = [[SGLoginView alloc] init];
    // 添加子控件
    [loginView setSubViewWithMasterImage:masterImage loopImage:loopImage title:title];
    return loginView;
}



// 添加子控件
- (void)setSubViewWithMasterImage: (NSString *)masterImage loopImage:(NSString *)loopImage title: (NSString *)title {
    
    UIImageView *loopView = [[UIImageView alloc] init];
    loopView.image = [UIImage imageNamed:loopImage];
    [loopView sizeToFit];
    [self addSubview:loopView];
    self.loopView = loopView;
    
    UIImageView *coverView = [[UIImageView alloc] init];
    coverView.image = [UIImage imageNamed:@"visitordiscover_feed_mask_smallicon"];
    [self addSubview:coverView];
    self.coverView = coverView;
    
    UIImageView *masterView = [[UIImageView alloc] init];
    masterView.image = [UIImage imageNamed:masterImage];
    [self addSubview:masterView];
    [masterView sizeToFit];
    self.masterView = masterView;
    
   
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.numberOfLines = 0;
    [titleLabel sizeToFit];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateNormal];
    //单击事件
    [loginBtn addTarget:self action:@selector(loginBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn sizeToFit];
    [self addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
    UIButton *registerBtn = [[UIButton alloc] init];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"common_button_white_disable"] forState:UIControlStateNormal];
    //单击事件
    [registerBtn addTarget:self action:@selector(registerBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerBtn sizeToFit];
    [self addSubview:registerBtn];
    self.registerBtn = registerBtn;
}

- (void)loginBtnDidClick {
    if ([self.delegate respondsToSelector:@selector(loginView:loginBtn:)]) {
        [self.delegate loginView:self loginBtn:self.loginBtn];
    }
}

- (void)registerBtnDidClick {
    if ([self.delegate respondsToSelector:@selector(loginView:registerBtn:)]) {
        [self.delegate loginView:self loginBtn:self.registerBtn];
    }
}


// 自动布局 添加约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // loopView
    [self.loopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).with.offset(-40);
    }];
  
    // masterView
    [self.masterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).with.offset(-40);
    }];
    // titleLabel
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.masterView.mas_bottom).with.offset(50);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(240);
    }];
    // loginBtn
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(16);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    // registerBtn
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel.mas_right);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(16);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    //约束蒙版
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.bottom.equalTo(self.loginBtn.mas_top).with.offset(50);
    }];
}

- (void)addBaseAnimation {
    
}

@end

//
//  SGHomeTableViewVc.m
//  SGWeiBo
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGHomeTableViewVc.h"
#import "Masonry.h"
#import "SGUserAccount.h"
@interface SGHomeTableViewVc()
@property (nonatomic,weak)UIButton * leftBtn;
@property (nonatomic,weak)UIButton * rightBtn;
@property (nonatomic,weak)UIButton * titleBtn;



@end

@implementation SGHomeTableViewVc

- (void)viewDidLoad {
    [super viewDidLoad];
    if([SGUserAccount loadAccount].access_token)
    [self setUpNavigationItem];
    [self setUpNavigationItemFrame];
    // setup
}

- (void)setUpNavigationItem {
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn sizeToFit];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendsearch"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = leftBtn;
    
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn sizeToFit];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = rightBtn;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *titleBtn = [[UIButton alloc] init];
    self.navigationItem.titleView = titleBtn;
    [titleBtn sizeToFit];
    
}

- (void)setUpNavigationItemFrame {
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.navigationItem);
        make.left.mas_equalTo(0);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.navigationItem);
        make.right.mas_equalTo(0);
    }];
    
}


#pragma mark -  建立set & get
- (void)leftBtnClick {
    
}

- (void)rightBtnClick {
    
}



@end

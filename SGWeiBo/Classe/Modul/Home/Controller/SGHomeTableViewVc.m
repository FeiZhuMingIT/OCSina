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
#import "SGHomeBtn.h"
@interface SGHomeTableViewVc()
@property (nonatomic,weak)UIButton * leftBtn;
@property (nonatomic,weak)UIButton * rightBtn;
@property (nonatomic,weak)UIButton * titleBtn;

@property (nonatomic,strong)SGUserAccount * userAccount;

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
    
    SGHomeBtn *titleBtn = [[SGHomeBtn alloc] init];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn sizeToFit];
    [titleBtn setTitle:self.userAccount.name forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [titleBtn addTarget:self action:@selector(titleBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.titleBtn = titleBtn;
    self.navigationItem.titleView = titleBtn;
    
    
}

- (void)setUpNavigationItemFrame {

    
}

- (void)titleBtnDidClick {
    // 发生旋转
    self.titleBtn.selected = !self.titleBtn.selected;
    if (self.titleBtn.selected) {
        // 就近原则
        [UIView animateWithDuration:0.25 animations:^{
        self.titleBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI - 0.01);
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
           self.titleBtn.imageView.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark -  建立set & get
- (void)leftBtnClick {
    
}

- (void)rightBtnClick {
    
}
- (SGUserAccount *)userAccount {
    if (_userAccount == nil) {
        _userAccount = [SGUserAccount loadAccount];
    }
    return _userAccount;
}


@end

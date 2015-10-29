//
//  SGWelcomeVc.m
//  SGWeiBo
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGWelcomeVc.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#define kTextLabel @"欢迎回来"
@interface SGWelcomeVc ()
@property (nonatomic,weak)UILabel * textLable;
@property (nonatomic,weak)UIImageView * iconView;
@property (nonatomic,weak)NSLayoutConstraint * iconViewTopCons;
@property (nonatomic,weak)UIImageView * bgImageView;
@end

@implementation SGWelcomeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
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
    [iconView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
    iconView.layer.cornerRadius = 42.5;
    iconView.layer.masksToBounds = YES;
    [self.view addSubview:iconView];
    self.iconView = iconView;
    
    //// usingSpringWithDamping: 值越小弹簧效果越明显 0 - 1
    // initialSpringVelocity: 初速度
  
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.iconViewTopCons.constant = -([UIScreen mainScreen].bounds.size.height - 60);
    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:0 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.textLable.alpha = 1;
        } completion:^(BOOL finished) {
            //跳转控制器
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

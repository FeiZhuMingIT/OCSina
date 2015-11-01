//
//  SGTopView.m
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGTopView.h"
#import "SGStatus.h"
#import "SGUser.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UILabel+Extension.h"
#define kMargin 8
@interface SGTopView ()
// 用户头像
@property (nonatomic,weak)UIImageView * iconView;
// 用户名称
@property (nonatomic,weak)UILabel * nameLabel;
// 时间label
@property (nonatomic,weak)UILabel * timeLabel;
// 来源
@property (nonatomic,weak)UILabel * sourceLabel;
// 认证图标
@property (nonatomic,weak)UIImageView * verifiedView;
// 会员等级
@property (nonatomic,weak)UIImageView * memberView;
// 间隔view
@property (nonatomic,weak)UIView * marginView;
@end
@implementation SGTopView


- (instancetype)init {
    if (self = [super init]) {
        [self setupSubView];
    }
    return self;
}

// 添加子控件
- (void)setupSubView {
    
    UIView *marginView = [[UIView alloc] init];
    self.marginView = marginView;
    marginView.backgroundColor =[UIColor colorWithWhite:0.9 alpha:0.9];
    [self addSubview:marginView];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *nameLabel = [UILabel labelWithFontSize:14 textColor:[UIColor darkGrayColor]];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [UILabel labelWithFontSize:9 textColor:[UIColor orangeColor]];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [UILabel labelWithFontSize:9 textColor:[UIColor lightGrayColor]];
    [self addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UIImageView *verifiedView = [[UIImageView alloc] init];
    [self addSubview:verifiedView];
    self.verifiedView = verifiedView;
    
    UIImageView *memberView = [[UIImageView alloc] init];
    [self addSubview:memberView];
    self.memberView = memberView;

}


// 为子控件赋值
- (void)setStatus:(SGStatus *)status {
    _status = status;
    
    // 头像图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.status.user.profile_image_url]];
    // 名字
    self.nameLabel.text = status.user.name;
    
    [self.nameLabel sizeToFit];
    // 创建时间
    self.timeLabel.text = status.created_at;
    [self.timeLabel sizeToFit];
    // 来源
    self.sourceLabel.text = status.source;
   [self.sourceLabel sizeToFit];
    // 认证
    self.verifiedView.image = self.status.user.verified_image;
    
    // VIP
    self.memberView.image = self.status.user.mbrankImage;
}





// 自动布局
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.marginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(8);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(kMargin);
        make.top.equalTo(self.marginView.mas_bottom).with.offset(kMargin);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [self.verifiedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconView.mas_right);
        make.centerY.equalTo(self.iconView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).with.offset(kMargin);
        make.top.equalTo(self.iconView);
    }];
    [self.memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.left.equalTo(self.nameLabel.mas_right).with.offset(16);
        make.top.equalTo(self.marginView).with.offset(kMargin);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).with.offset(kMargin);
        make.bottom.equalTo(self.iconView.mas_bottom);
    }];
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).with.offset(16);
        make.bottom.equalTo(self.iconView.mas_bottom);
    }];
    
}
@end

//
//  SGBottomView.m
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGBottomView.h"
#import "UIButton+Extension.h"
#import "Masonry.h"
@interface SGBottomView()
@property (nonatomic,weak)UIButton * forwordBtn;
@property (nonatomic,weak)UIButton * commentButton;
@property (nonatomic,weak)UIButton * lickButton;

@property (nonatomic,weak)UIView * separatorViewOne;
@property (nonatomic,weak)UIView * separatorViewTwo;
@end

@implementation SGBottomView


- (instancetype)init {
    if (self = [super init]) {
        // 设置背景颜色
        self.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        [self setupSubView];
        [self setupSubViewFrame];
    }
    return self;
}


- (void)setupSubView {
    UIButton *forwordBtn = [[UIButton alloc] initWithTitle:@"转发" bgColor:[UIColor lightGrayColor] imageName:@"timeline_icon_retweet"];
    
    [self addSubview:forwordBtn];
     self.forwordBtn = forwordBtn;


    UIButton *commentButton = [[UIButton alloc] initWithTitle:@"评论" bgColor:[UIColor lightGrayColor] imageName:@"timeline_icon_comment"];
    [self addSubview:commentButton];
    self.commentButton = commentButton;
    
    
    UIButton *lickButton = [[UIButton alloc] initWithTitle:@"赞" bgColor:[UIColor lightGrayColor] imageName:@"timeline_icon_unlike"];
    [self addSubview:lickButton];
    self.lickButton = lickButton;
    
//     水平分割线
    UIView * separatorViewOne = [[UIView alloc] init];
    separatorViewOne.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    [self addSubview:separatorViewOne];
       self.separatorViewOne = separatorViewOne;
    
    UIView *separatorViewTwo = [[UIView alloc] init];
     separatorViewTwo.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    self.separatorViewTwo = separatorViewTwo;
    [self addSubview:separatorViewTwo];
}

- (void)setupSubViewFrame {
    
    CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width / 3;
    [self.forwordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.width.mas_equalTo(btnWidth);
    }];
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.left.equalTo(self.forwordBtn.mas_right);
        make.width.mas_equalTo(btnWidth);
    }];
    
    [self.lickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.left.equalTo(self.commentButton.mas_right);
        make.width.mas_equalTo(btnWidth);
    }];

    // 两条分割线
    [self.separatorViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.mas_equalTo(btnWidth * 3);
        make.height.mas_equalTo(1);
    }];
    
    [self.separatorViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.width.mas_equalTo(btnWidth * 3);
        make.height.mas_equalTo(1);
    }];
}



@end

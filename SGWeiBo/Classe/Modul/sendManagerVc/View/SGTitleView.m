//
//  SGTitleView.m
//  SGWeiBo
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGTitleView.h"
#import "NSString+Extension.h"
@interface SGTitleView()

@property (nonatomic,weak)UILabel * label1;

@property (nonatomic,weak)UILabel * nameLabel;

@end

@implementation SGTitleView

- (instancetype)init {
    if (self = [super init]) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"发微博";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    // 算出它的size的高度
    self.label1 = label;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 给一个最大宽度 不让它换行
    CGSize size = CGSizeMake(100, 60);
    CGFloat height = [NSString stringWithTitle:self.label1.text WithSize:size WithAttribute:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].height;
    NSLog(@"%f",height);
    self.label1.frame = CGRectMake(0, 0, 100, height);
}


- (void)setName:(NSString *)name {
    CGSize size = CGSizeMake(100, 60);
    CGFloat height = [NSString stringWithTitle:name WithSize:size WithAttribute:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].height;
    NSLog(@"%f",height);
    self.nameLabel.frame = CGRectMake(0, self.label1.frame.size.height, 100, height);
}
@end

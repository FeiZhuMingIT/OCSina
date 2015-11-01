//
//  SGHomeCell.m
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGHomeCell.h"
#import "SGTopView.h"
#import "SGBottomView.h"
#import "SGPictureView.h"
#import "SGTextLabel.h"
#import "SGTopView.h"
#import "Masonry.h"
#import "SGBottomView.h"
#import "SGStatus.h"
#import "SGPictureView.h"
@interface SGHomeCell()

@property (nonatomic,weak)SGTopView * topView;
@property (nonatomic,weak)SGBottomView * bottomView;
@property (nonatomic,weak)SGTextLabel * desteilLabel;
@property (nonatomic,weak)SGPictureView * pictureView;

@end

@implementation SGHomeCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

+ (instancetype)homeCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"homeCell";
    SGHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID] ;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubView];
        [self setupSubViewFrame];
    }
    return self;
}


#pragma mark - 添加子控件
- (void)setupSubView {
    
    SGTopView *topView = [[SGTopView alloc] init];
    self.topView = topView;
    [self addSubview:topView];
    
    SGBottomView *bottomView = [[SGBottomView alloc] init];
    self.bottomView = bottomView;
    [self addSubview:bottomView];
    
    SGTextLabel *desteilLabel = [[SGTextLabel alloc] init];
    self.desteilLabel = desteilLabel;
    [self addSubview:desteilLabel];
    
    SGPictureView *pictureView = [[SGPictureView alloc] init];
    self.pictureView = pictureView;

    [self addSubview:pictureView];
}

- (void)setupSubViewFrame {
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(53);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(44);
        make.left.equalTo(self);
    }];
    
    [self.desteilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).with.offset(8);
        make.left.equalTo(self).with.offset(8);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width -2 *8);
    }];
    
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desteilLabel.mas_bottom).with.offset(8);
        make.left.equalTo(self.mas_left).with.offset(8);
//        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
}

#pragma mark - set && get
- (void)setStatus:(SGStatus *)status {
    _status = status;
    self.topView.status = status;
    self.desteilLabel.text = status.text;
    self.pictureView.picUrls = status.picUrls;
    CGSize size = [self.pictureView pictureViewImageCount];
//    CGSize size = self.pictureView.frame.size;
    NSLog(@"width: %f, height: %f", size.width, size.height);
//    CGSize size [self.pictureView pictureViewImageCount];
    [self.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
}
@end

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
#import "SGPhotoView.h"
@interface SGHomeCell()

@property (nonatomic,weak)SGTopView * topView;
@property (nonatomic,weak)SGBottomView * bottomView;
@property (nonatomic,weak)SGTextLabel * desteilLabel;
@property (nonatomic,weak)SGPictureView * pictureView;
@property (nonatomic,weak)SGPhotoView * photoView;


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
#warning 这不让用户选中cell 以后替换
    // 不让用户选中cell
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    SGPhotoView *photo = [[SGPhotoView alloc] init];
    self.photoView = photo;
    [self addSubview:photo];
}

- (void)setupSubViewFrame {
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(53);
    }];
    

    
    [self.desteilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).with.offset(8);
        make.left.equalTo(self).with.offset(8);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width -2 *8);
    }];
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desteilLabel.mas_bottom).with.offset(8);
        make.left.equalTo(self.mas_left).with.offset(8);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoView.mas_bottom).with.offset(8);
        make.width.equalTo(self);
        make.height.mas_equalTo(44);
        make.left.equalTo(self);
    }];
}

#pragma mark - set && get
- (void)setStatus:(SGStatus *)status {
    
    _status = status;
    self.topView.status = status;
    self.desteilLabel.attributedText = status.attributedString;
    self.photoView.picUrls = status.picUrls;
    CGSize size = [self.photoView  countSize];
    self.cellHeightx = size.height;
    [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desteilLabel.mas_bottom).with.offset(8);
        make.left.equalTo(self.mas_left).with.offset(8);
        make.size.mas_equalTo(size);
    }];
    
}

# pragma 计算cell的高度
- (CGFloat)cellHeight {
    return CGRectGetMaxY(self.bottomView.frame);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubViewFrame];
}

@end

//
//  SGNewfutureCell.m
//  SGWeiBo
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGNewfutureCell.h"
#import "Masonry.h"
@interface  SGNewfutureCell()
@property (nonatomic,weak)UIImageView * imageView;
@property (nonatomic,weak)UIButton * btn;
@end

@implementation SGNewfutureCell



+ (instancetype)newfutureCellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath {
    SGNewfutureCell *newfutureCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    [newfutureCell setupSubView];
    newfutureCell.index = indexPath.row;
    return newfutureCell;
}

- (void)setupSubView {
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.frame = [UIScreen mainScreen].bounds;
    [self addSubview:imageView];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
     [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    self.btn = btn;
    [self.btn setTitle:@"开始体验" forState:UIControlStateNormal];
    self.btn.titleLabel.textColor = [UIColor whiteColor];
    self.btn.hidden = YES;
    [imageView addSubview:btn];
}


-(void)showBtnAnimation {
    self.btn.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.8 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.btn.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([UIScreen mainScreen].bounds.size);
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView);
        make.top.equalTo(self.imageView.mas_bottom).with.offset(-160);
    }];

}


- (void)setIndex:(NSInteger)index {
    _index = index;
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%ld",index+ 1]];
    
}


-(void) setShowBtn:(BOOL)showBtn {
    _showBtn = showBtn;
    self.btn.hidden = !showBtn;
}
@end

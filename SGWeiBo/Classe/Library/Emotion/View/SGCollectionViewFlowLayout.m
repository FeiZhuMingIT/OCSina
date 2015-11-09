//
//  SGCollectionViewFlowLayout.m
//  SGEmotion
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGCollectionViewFlowLayout.h"

@implementation SGCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        [self prepareLayout];
    }
    return self;
}

// 准备布局
- (void)prepareLayout {
    [super prepareLayout];
    // 宽度
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 7.0;
    CGFloat height = self.collectionView.frame.size.height / 3.0;
    // 设置layoutSize
    self.itemSize = CGSizeMake(width, height);
    // 滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    // 取消弹簧效果
    self.collectionView.bounces = false;
    self.collectionView.alwaysBounceHorizontal = false;
    self.collectionView.showsHorizontalScrollIndicator = false;
    //分页
    self.collectionView.pagingEnabled = YES;
}

@end

//
//  SGPictureView.m
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGPictureView.h"
#import "SGCollectionViewCell.h"

#define kItemWidth 90
#define kMargin 10
#define kCollectionViewCell @"collectionViewCell"

@interface SGPictureView() <UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionViewFlowLayout * layout;
@end

@implementation SGPictureView

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:self.layout]) {
        [self registerClass:[SGCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
        self.dataSource = self;
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}


- (void)setupSubview {


}


#pragma mark - UICollectionViewDatasoure 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return  self.picUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SGCollectionViewCell *cell = [SGCollectionViewCell cellWithCollectionView:collectionView withIndexPath:indexPath];
    cell.imageUrl = self.picUrls[indexPath.row];
    return cell;
}

#pragma mark - 根据pic_urls的个数判断
- (CGSize)pictureViewImageCount {
    NSInteger count = self.picUrls.count;
    CGSize itemSize = CGSizeMake(kItemWidth, kItemWidth);
    self.layout.itemSize = itemSize;
    if (count == 0) {
        return CGSizeZero;
    } else if (count == 1) {
        self.layout.itemSize = CGSizeMake(150, 120);
        return CGSizeMake(150, 120);
    } else if (count == 4) {
        self.layout.itemSize = itemSize;
        return CGSizeMake(2 * kItemWidth + kMargin, 2 * kItemWidth + kMargin);
    } else {
        // 计算行数
        NSInteger row = (count - 1) / 3 +1;
        // 计算高度
        CGFloat height = row * kItemWidth + (row -1) * kMargin;
        // 计算宽度
        CGFloat width = count == 2?kMargin + 2 * kItemWidth : kItemWidth * 3 + 2 *kMargin;
        self.layout.itemSize = itemSize;
        return CGSizeMake(width, height);
    }
}



#pragma mark - 设置layoutItem和cell的size
//- (CGSize)sizeThatFits:(CGSize)size {
//    return [self pictureViewImageCount];
//}
#pragma mark - set && get
- (void)setPicUrls:(NSArray *)picUrls {
    _picUrls = picUrls;
//    [self sizeToFit];

}


- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumLineSpacing = 10;
        _layout.minimumInteritemSpacing = 10;
    }
    return _layout;
}
@end

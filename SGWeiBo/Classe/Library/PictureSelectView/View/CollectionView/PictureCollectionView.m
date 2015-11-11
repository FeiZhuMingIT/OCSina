//
//  PictureCollectionView.m
//  PictureSelectView
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "PictureCollectionView.h"
#import "PictureCollectionViewCell.h"
#define kPictureCollectionCellMax 3
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256/255.0f) green:arc4random_uniform(256/255.0f) blue:arc4random_uniform(256/255.0f) alpha:1]
#define kPictureCollectionViewCellIdentifier @"pictureCollectionViewCellIdentifier"
#define kMargin 10
@interface PictureCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,PictureCollectionViewCellDelegate>



@property(nonatomic,assign) NSInteger index;

@property(nonatomic,strong) UICollectionViewFlowLayout *flowLayout;


@end

@implementation PictureCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        
        self.dataSource = self;
    }
    return self;
}

+ (instancetype)pictureViewWithIndex:(NSInteger)index WithImageArr:(NSMutableArray *)imageArr {
    // 根据url个数绘制cell的个数
    PictureCollectionView *collectionView = [[PictureCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[PictureCollectionView setupLayout]];
    
    [collectionView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:kPictureCollectionViewCellIdentifier];
    
    collectionView.imageArr = imageArr;
    
    collectionView.index = index;
    
    return collectionView;
}

+ (UICollectionViewFlowLayout *)setupLayout {
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(90, 90);
    
    layout.sectionInset = UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
    
    return layout;
}

// 如果count小于最大count数，在后面自动加一个添加按钮，如果等于最大数，那么按钮消失
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 判断是否最大数量是的话就不需要 + 默认按钮了
    return self.imageArr.count == kPictureCollectionCellMax? kPictureCollectionCellMax : self.imageArr.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PictureCollectionViewCell *cell = [PictureCollectionViewCell cellWithCollectionView:collectionView WithIndexPath:indexPath];

    cell.delegate = self;
    // 如果是最后一个元素
    if (self.imageArr.count != kPictureCollectionCellMax) {
        // 判断是不是最后一个row如果不是就
        if (indexPath.row == self.imageArr.count) { // 不用减一因为上面已经默认加一了
            // 防止复用
            cell.image = nil;

            return cell;
        }
    }
    cell.tag = indexPath.row;
    cell.image = self.imageArr[indexPath.row];
    return cell;
}

#pragma mark - PictureCollectionViewCell代理方法
- (void)pictureCollectionViewCell:(PictureCollectionViewCell *)pictureCell DeleteBtnClick:(UIButton *)deletaBtn {
    // 拿到当前cell的image数据在数组中删除
    UIImage *deleteImage = pictureCell.image;
    NSLog(@"%@",self.imageArr);
    [self.imageArr removeObject:deleteImage];
    NSLog(@"%@",self.imageArr);
    [self reloadData];
}


#pragma mark - set & get


@end

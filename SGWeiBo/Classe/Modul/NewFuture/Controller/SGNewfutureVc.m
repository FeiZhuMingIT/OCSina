//
//  SGNewfutureVc.m
//  SGWeiBo
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGNewfutureVc.h"
#import "SGNewfutureCell.h"
#import "Masonry.h"
@interface SGNewfutureVc ()
@property (nonatomic,strong) SGNewfutureCell * lastCell;
@end

@implementation SGNewfutureVc




- (instancetype) init {
    if (self = [super init]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        return [super initWithCollectionViewLayout:layout];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[SGNewfutureCell class] forCellWithReuseIdentifier:@"cell"];
//    self.collectionView registerClass:[SGNewfutureCell class] forCellWithReuseIdentifier:<#(nonnull NSString *)#>
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SGNewfutureCell *cell = [SGNewfutureCell newfutureCellWithCollectionView:collectionView withIndexPath:indexPath];
    
    //拿到最后一个cell
    if (indexPath.row == 3)
    {
        self.lastCell  = cell;
    }
    // 因为会不断的调用cell 方法，所以加载button的时候就会自动给它再次赋值为nil
    return cell;
}

// 当collectionView 显示完毕的时候调用
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SGNewfutureCell *showCell = (SGNewfutureCell *)cell;
    if (showCell.index == 3)
    {
        [showCell showBtnAnimation];
    }
}



@end

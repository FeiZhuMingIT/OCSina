//
//  PictureBrowerCollectionVC.h
//  PictureBrowser
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureBrowerCell;
//  继承转场动画的代理
@interface PictureBrowerCollectionVC : UIViewController <UIViewControllerTransitioningDelegate>


@property(nonatomic,strong) NSArray *imageModels;
// 图片浏览
@property(nonatomic,weak) UICollectionView *collectionView;

// 保存所有图片
@property(nonatomic,strong) UIImageView *tempView;
- (UIImageView *)currentShowView;
// 获得正在显示的视图
- (NSInteger)currentRow;

- (instancetype)initWithImageModel:(NSArray *)imageModel imageView:(UIImageView *)tempView;

@end

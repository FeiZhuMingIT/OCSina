//
//  PictureBrowerCollectionVC.h
//  PictureBrowser
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import <UIKit/UIKit.h>
//  继承转场动画的代理
@interface PictureBrowerCollectionVC : UIViewController <UIViewControllerTransitioningDelegate>


// 图片浏览
@property(nonatomic,weak) UICollectionView *collectionView;

// 保存所有图片
@property(nonatomic,strong) UIImageView *tempView;


- (instancetype)initWithImageUrls:(NSArray *)imageUrls imageView:(UIImageView *)tempView;

@end

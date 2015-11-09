//
//  PictureBrowerCell.h
//  PictureBrowser
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureBrowerCell : UICollectionViewCell

// 需要一张图片url
@property(nonatomic,copy) NSString *largeString;

@property(nonatomic,weak) UIImageView *imageView;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath;

@end

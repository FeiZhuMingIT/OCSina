//
//  PictureBrowerCell.h
//  PictureBrowser
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGImageModel.h"
@class PictureBrowerCell;
@protocol PictureBrowerCellDelegate <NSObject>

- (void)pictureBrowerCellClose:(PictureBrowerCell *)cell;

// 传出alha值
- (void)pictureBrowerCell:(PictureBrowerCell *)cell WithAlpha:(CGFloat) alpha;
@end

@interface PictureBrowerCell : UICollectionViewCell


// 改成传imageModel
@property(nonatomic,strong) SGImageModel *imageModel;
// 需要一张图片url
@property(nonatomic,copy) NSString *largeString;

@property(nonatomic,weak) id<PictureBrowerCellDelegate> celldelegate;

@property(nonatomic,weak) UIImageView *imageView;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath;

@end

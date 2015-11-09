//
//  PictureCollectionViewCell.h
//  PictureSelectView
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureCollectionViewCell;
@protocol PictureCollectionViewCellDelegate <NSObject>

- (void)pictureCollectionViewCell:(PictureCollectionViewCell *)pictureCell DeleteBtnClick:(UIButton *)deletaBtn;

@end

@interface PictureCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak) id <PictureCollectionViewCellDelegate> delegate;

@property(nonatomic,strong) UIImage *image;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView WithIndexPath:(NSIndexPath *)indexPath;
@end

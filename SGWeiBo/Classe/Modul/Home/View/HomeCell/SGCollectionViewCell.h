//
//  SGCollectionViewCell.h
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)NSString * imageUrl;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath;

@end

//
//  emotionCell.h
//  SGEmotion
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Emotion;
@interface emotionCell : UICollectionViewCell

@property (nonatomic,strong)Emotion * emtion;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath;

@end

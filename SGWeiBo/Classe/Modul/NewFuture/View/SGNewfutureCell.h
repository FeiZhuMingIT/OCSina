//
//  SGNewfutureCell.h
//  SGWeiBo
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGNewfutureCell : UICollectionViewCell

-(void)showBtnAnimation;
@property (nonatomic,assign)NSInteger  index;

+ (instancetype)newfutureCellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,assign)BOOL  showBtn;

-(void)showBtnAnimation;
@end

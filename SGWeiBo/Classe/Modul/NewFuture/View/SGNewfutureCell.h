//
//  SGNewfutureCell.h
//  SGWeiBo
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGNewfutureCell;
@protocol SGNewfutureCellDelegate <NSObject>

- (void)newfutureCellBtnDidClick;

@end

@interface SGNewfutureCell : UICollectionViewCell
@property (nonatomic,assign)NSInteger  index;
@property (nonatomic,assign)BOOL  showBtn;
@property (nonatomic,weak)id<SGNewfutureCellDelegate> delegate;


+ (instancetype)newfutureCellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath;
- (void)showBtnAnimation;
@end

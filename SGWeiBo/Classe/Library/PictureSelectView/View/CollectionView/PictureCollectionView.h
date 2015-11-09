//
//  PictureCollectionView.h
//  PictureSelectView
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureCollectionView : UICollectionView

@property(nonatomic,strong) NSMutableArray *imageArr;

+ (instancetype)pictureViewWithIndex:(NSInteger)index WithImageArr:(NSArray *)imageArr;

@end

//
//  SGPictureView.h
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGPictureView : UICollectionView
 // 全部图片的链接 可以为 nil
@property (nonatomic,strong)NSArray * picUrls;

- (CGSize)pictureViewImageCount;

@end

//
//  SGPhotoView.h
//  SGWeiBo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGPhotoView;

//@protocol SGPhotoViewDelegate <NSObject>
//
//- (void)photoView:(SGPhotoView *)photoView index:(UIImageView *)imageView;
//
//@end

@interface SGPhotoView : UIView

// 全部图片的链接 可以为 nil
@property (nonatomic,strong)NSArray * picUrls;

//@property(nonatomic,weak) id<SGPhotoViewDelegate> delegate;

- (CGSize)countSize;
@end

//
//  SGPictureBrowerDismissAnimation.m
//  SGWeiBo
//
//  Created by pkxing on 15/11/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGPictureBrowerDismissAnimation.h"
#import "PictureBrowerCollectionVC.h"
#import "SGImageModel.h"
@interface SGPictureBrowerDismissAnimation()

@property(nonatomic,strong) PictureBrowerCollectionVC *picVc;
@property(nonatomic,strong) NSArray *imageModels;
@property(nonatomic,strong) UIImageView *tempView;
@end

@implementation SGPictureBrowerDismissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.picVc = (PictureBrowerCollectionVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 拿到要转换的那个控制器
    self.picVc.collectionView.hidden = YES;
    // 拿到当前picVc.collectionView的image
    self.imageModels = self.picVc.imageModels;
    // 拿到contestView
    UIView *format = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    self.tempView = [self tempViewWithThume:[self.picVc currentShowView]];
    
    // 到底是谁
//    format.backgroundColor = [UIColor orangeColor];
    
//    [[transitionContext containerView] addSubview:format];
    
      [[transitionContext containerView] addSubview:self.tempView];
    [UIView animateWithDuration:0.5 animations:^{
        format.alpha = 0;
        self.tempView.alpha = 0;
        self.tempView.frame = [self dismissImageRect];
        NSLog(@"%@",NSStringFromCGRect([self dismissImageRect]));
       
    } completion:^(BOOL finished) {
         [self.tempView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}
// 根据fromView获得过度的imageView
- (UIImageView *)tempViewWithThume:(UIImageView *)thumView {
    UIImageView *tempView = [[UIImageView alloc] initWithImage:thumView.image];
    // 先让thumView回到原来大小
    tempView.contentMode = thumView.contentMode;
    tempView.frame = thumView.frame;
    return tempView;
}
// 两个imageView相等则代表是控制器的view
- (CGRect)dismissImageRect {
    // 拿都homeBtn上的cell的frame

    SGImageModel *imageModel = self.imageModels[[self.picVc currentRow]];
    
    return [imageModel.imageView.superview convertRect:imageModel.imageView.frame toCoordinateSpace:self.picVc.view];
}

// 返回缩小后的frame

/*
    思路，与modal正好相反
    1.让toView视图视图隐藏，获得根据collection的位置获取过渡视图
    2.将过度视图添加到容器中，
 
 */
@end

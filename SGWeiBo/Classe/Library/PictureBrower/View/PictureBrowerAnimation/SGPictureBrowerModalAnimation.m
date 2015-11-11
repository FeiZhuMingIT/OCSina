//
//  SGPictureBrowerModalAnimation.m
//  SGWeiBo
//
//  Created by pkxing on 15/11/10.
//  Copyright © 2015年 apple. All rights reserved.
//
/*
 思路:
 1.拿到转场过来的view和控制器，view加入到容器中，controler隐藏
 2.设置photo模型，让from控制器上的数据为数图片，得到from控制器的时候可以得到那一张图片 的大小和位置
 3.判断图片的大小，缩放，width缩放放大缩小
 4.开始动画，当动画结束的时候移除过渡视图，过度视图是浏览器创建的，会删掉的，让collectionView显示，注意背景
 5.转场动画完成
 */

#import "SGPictureBrowerModalAnimation.h"
#import "PictureBrowerCollectionVC.h"
@interface SGPictureBrowerModalAnimation()
@property(nonatomic,strong) PictureBrowerCollectionVC *picVc;
@end

@implementation SGPictureBrowerModalAnimation



- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 拿到转场动画过来的那个view
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    toView.backgroundColor = [UIColor blackColor];
    
    // 设置动画
    toView.alpha = 0;
    
    // 添加到容器中
    [[transitionContext containerView] addSubview:toView];
    
    // 获得modal出来的控制器
    self.picVc = (PictureBrowerCollectionVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    self.picVc.collectionView.hidden = YES;
    
    // 拿到控制器的tempView
    UIImageView *transitionView = [self modalTempImageViewSetFrame:self.picVc.tempView];
    
    // 添加到容器视图上
    [[transitionContext containerView] addSubview:transitionView];
    
    self.picVc.collectionView.hidden = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        // 转换后的frame
        transitionView.frame = [self modalTempImageFrame:self.picVc.tempView];
        
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        // 移除
        [transitionView removeFromSuperview];
        
        self.picVc.collectionView.hidden = NO;
        
        [transitionContext completeTransition:YES];
        
        toView.backgroundColor = [UIColor clearColor];
    }];
    
    
}

#pragma mark - 设置frame为从父图过来时候的frame
- (UIImageView *)modalTempImageViewSetFrame:(UIImageView *)tempView {
    
        // 获得temView从父控件过来时候的值
    // 对不起，ImageView不能使用copy
    UIImageView *transitionView = [[UIImageView alloc] initWithImage:tempView.image];
    
    // 图片的浏览模式
    transitionView.contentMode = tempView.contentMode;
    
    // 可以裁剪
    transitionView.clipsToBounds = YES;
    
    transitionView.frame = [tempView.superview convertRect:tempView.frame toCoordinateSpace:self.picVc.view];
    
    return transitionView;
}

#pragma mark - 根据传入的图片,获得缩放后的frame
- (CGRect)modalTempImageFrame:(UIImageView *)tempView {
    
    CGSize size = tempView.image.size;
    
    // 计算宽高
    CGFloat sizeW = kScreenWidth;
    
    CGFloat sizeH = size.height / size.width * kScreenWidth;
    
    CGFloat imageY = 0;
    
    if (sizeH < kScreenHeight) {
        imageY = 0.5 * (kScreenHeight - sizeH);
    }
    
    return CGRectMake(0, imageY, sizeW, sizeH);
}

@end

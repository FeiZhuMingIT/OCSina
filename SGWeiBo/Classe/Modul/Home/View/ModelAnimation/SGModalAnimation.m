//
//  SGModalAnimation.m
//  SGWeiBo
//
//  Created by pkxing on 15/11/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGModalAnimation.h"
@interface SGModalAnimation()

@end

@implementation SGModalAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 实现动画
    /**
        当实现这个方法,model出来的控制器的view是需要我们自己添加到容器视图
     transitionContext:
     转场的上下文.提供转场相关的元素
     
     containerView():
     容器视图
     
     completeTransition:
     当转场完成一定要调用,否则系统会认为转场没有完成,不能继续交互
     
     viewControllerForKey(key: String):
     拿到对应的控制器:
     modal时:
     UITransitionContextFromViewControllerKey: 调用presentViewController的对象
     UITransitionContextToViewControllerKey:
     modal出来的控制器
     
     viewForKey
     拿到对应的控制器的view
     UITransitionContextFromViewKey
     UITransitionContextToViewKey
     */
    // 从modal的控制器中拿到modal的控制器
    UIView * toView = [transitionContext viewForKey:(UITransitionContextToViewKey)];
    // 设置缩放
    toView.transform = CGAffineTransformMakeScale(1, 0);
    // 设置锚点
    toView.layer.anchorPoint = CGPointMake(0.5, 0);
    // 添加到容器视图
    [[transitionContext containerView] addSubview:toView];
    // 添加动画
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:2 options:0 animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
       // 记得告诉别人转场完成
        [transitionContext completeTransition:YES];
    }];
    
}

@end

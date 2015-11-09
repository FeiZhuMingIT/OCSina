//
//  SGDIsmissAnimation.m
//  SGWeiBo
//
//  Created by pkxing on 15/11/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGDIsmissAnimation.h"

@implementation SGDIsmissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
   UIView *contextView = [transitionContext viewForKey: UITransitionContextFromViewKey];
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:2 options:0 animations:^{
        contextView.transform = CGAffineTransformMakeScale(1, 0.01);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

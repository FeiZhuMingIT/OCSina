//
//  SGPresentVc.m
//  SGWeiBo
//
//  Created by pkxing on 15/11/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGPresentVc.h"

@implementation SGPresentVc
#pragma mark - 构造方法
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
    }
    return self;
}

#pragma mark - 单击contenView点击事件
- (void)containerViewTapGestureClick {
    // 发一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kSGPresentVcContainViewTapGestureClick object:nil];
}

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    // presentedView是Controller自身的view
    // 这个记得要在这里写我日
    self.containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(containerViewTapGestureClick)];
    self.containerView.gestureRecognizers = @[tapGesture];
    
    
    self.presentedView.frame = CGRectMake(kScreenWidth / 2 - 100, 60, 200, 200);
    // containerView才是容器的view
}

@end

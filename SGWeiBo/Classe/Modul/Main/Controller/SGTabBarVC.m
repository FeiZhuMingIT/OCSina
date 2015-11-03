//
//  SGTabBarVC.m
//  SGWeiBo
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGTabBarVC.h"
#import "SGHomeTableViewVc.h"
#import "SGDiscoverTableViewVc.h"
#import "SGProfileTableViewVc.h"
#import "SGMessageTableViewVc.h"
#import "SGSendController.h"
@implementation SGTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor orangeColor];
    
    //设置全局导航控制器属性
//    [self setupNavgationBar];
    //添加五个控制器
    SGHomeTableViewVc *homeVc = [[SGHomeTableViewVc alloc] init];
    [self addChildViewController:homeVc image:@"tabbar_home" title:@"主页"];
    
    SGMessageTableViewVc *messageVc = [[SGMessageTableViewVc alloc] init];
    [self addChildViewController:messageVc image:@"tabbar_message_center" title:@"信息"];
    
    //加一个add
    UIViewController *addVc = [[UIViewController alloc] init];
    [self addChildViewController:addVc image:nil title:@""];
    
    SGDiscoverTableViewVc *discoverVc = [[SGDiscoverTableViewVc alloc] init];
    [self addChildViewController:discoverVc image:@"tabbar_discover" title:@"发现"];
    
    SGProfileTableViewVc *profileVc = [[SGProfileTableViewVc alloc] init];
    [self addChildViewController:profileVc image:@"tabbar_profile" title:@"我"];
    
    //添加一个按钮区上面
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setAddBtn];
}

//添加按钮
- (void)setAddBtn {
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // 设置frame
    CGFloat width = self.tabBar.bounds.size.width / 5;
    addBtn.frame = CGRectMake(width * 2, 0, width, self.tabBar.bounds.size.height);
    [self.tabBar addSubview:addBtn];
}

- (void)addBtnClick {
    SGSendController *sendVc = [[SGSendController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sendVc];
    [self presentViewController:nav animated:YES completion:nil];

}

- (void)addChildViewController:(UIViewController *)controller image:(NSString *)image title:(NSString *)title {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    controller.tabBarItem.image = [UIImage imageNamed:image];
    controller.tabBarItem.title = title;
    [self addChildViewController:nav];
}


//- (void)setupNavgationBar {
//    UINavigationBar *bar = [UINavigationBar appearance];
//    bar.tintColor = [UIColor orangeColor];
//}

@end

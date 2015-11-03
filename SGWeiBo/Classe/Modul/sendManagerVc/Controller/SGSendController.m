//
//  SGSendController.m
//  SGWeiBo
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGSendController.h"
#import "UIButton+Extension.h"
#import "SGUserAccount.h"
#import "SGTitleView.h"
@interface SGSendController ()
@property (nonatomic,strong)SGUserAccount * userAccount;
//
@property (nonatomic,strong)UILabel * titlebel;
@end

@implementation SGSendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupNavigationItem];
    // 设置标题栏
    [self setupTitleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - 设置navigationItem
- (void)setupNavigationItem {
   

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backVc)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage)];
    
    
}
#pragma mark - 设置标题title
- (void)setupTitleView {
    if (!self.userAccount.name) {
        // OC居然不可以加
//        self.titlebel = [[UILabel alloc] init];
//        self.titlebel.font = [UIFont systemFontOfSize:14];
//        [self.titlebel sizeToFit];
//        self.titlebel.text = [NSString stringWithFormat:@"发微博"];
//        self.titlebel.backgroundColor = [UIColor orangeColor];
        
//        UIButton *button = [uib];
        // 只能用view查两个label了
        SGTitleView *view = [[SGTitleView alloc] init];
        view.backgroundColor = [UIColor orangeColor];
        view.name = self.userAccount.name;
        view.frame = CGRectMake(0, 0, 100, view.height);
        self.navigationItem.titleView = view;
    } else {
        self.navigationItem.title = @"发微博";
    }

    
}

#pragma mark - 返回方法
- (void)backVc {
    
}
#pragma mark - 发送微博方法
- (void)sendMessage {

}


@end

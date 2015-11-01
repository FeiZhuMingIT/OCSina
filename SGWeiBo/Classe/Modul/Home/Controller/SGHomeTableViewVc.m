//
//  SGHomeTableViewVc.m
//  SGWeiBo
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGHomeTableViewVc.h"
#import "Masonry.h"
#import "SGStatus.h"
#import "SGUserAccount.h"
#import "SGHomeBtn.h"
#import "SGHomeCell.h"
#import "SGAFNTool.h"
#import "MJExtension.h"

@interface SGHomeTableViewVc() <UITabBarDelegate,UITableViewDataSource>
@property (nonatomic,weak)UIButton * leftBtn;
@property (nonatomic,weak)UIButton * rightBtn;
@property (nonatomic,weak)UIButton * titleBtn;

@property (nonatomic,strong)SGUserAccount * userAccount;


// 数据
@property (nonatomic,strong)NSArray * statuses;
@end

@implementation SGHomeTableViewVc

- (void)viewDidLoad {
    [super viewDidLoad];
    if([SGUserAccount loadAccount].access_token)
    [self setUpNavigationItem];
    [self setUpNavigationItemFrame];
    
    // setuptableView
    [self setupTableView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 500;
   
}

#pragma mark - 添加子控件

- (void)setupTableView {
    
}
- (void)setUpNavigationItem {
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn sizeToFit];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendsearch"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = leftBtn;
    
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn sizeToFit];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = rightBtn;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    SGHomeBtn *titleBtn = [[SGHomeBtn alloc] init];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn sizeToFit];
    [titleBtn setTitle:self.userAccount.name forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [titleBtn addTarget:self action:@selector(titleBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.titleBtn = titleBtn;
    self.navigationItem.titleView = titleBtn;
    
    
}

- (void)setUpNavigationItemFrame {

    
}

- (void)titleBtnDidClick {
    // 发生旋转
    self.titleBtn.selected = !self.titleBtn.selected;
    if (self.titleBtn.selected) {
        // 就近原则
        [UIView animateWithDuration:0.25 animations:^{
        self.titleBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI - 0.01);
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
           self.titleBtn.imageView.transform = CGAffineTransformIdentity;
        }];
    }
}


#pragma mark - tableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SGHomeCell *homeCell = [SGHomeCell homeCellWithTableView:tableView];
    homeCell.status = self.statuses[indexPath.row];
    return homeCell;
}

#pragma mark -  建立set & get
- (void)leftBtnClick {
    
}

- (void)rightBtnClick {
    
}
- (SGUserAccount *)userAccount {
    if (_userAccount == nil) {
        _userAccount = [SGUserAccount loadAccount];
    }
    return _userAccount;
}

- (NSArray *)statuses {
    if (!_statuses) {
        
       NSDictionary* dictionary = [SGAFNTool shareAFNTool].loadData;
        NSArray *statuses = dictionary[@"statuses"];
        _statuses = [SGStatus objectArrayWithKeyValuesArray:statuses];
    }
    return _statuses;
}

@end

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
#import "SGAFNTool.h"
#import "SVProgressHUD.h"
#import <MJRefresh.h>
@interface SGHomeTableViewVc() <UITabBarDelegate,UITableViewDataSource>
@property (nonatomic,weak)UIButton * leftBtn;
@property (nonatomic,weak)UIButton * rightBtn;
@property (nonatomic,weak)UIButton * titleBtn;

@property (nonatomic,strong)SGUserAccount * userAccount;

@property (nonatomic,strong)SGAFNTool * afnTool;
// 数据
@property (nonatomic,strong)NSMutableArray * statuses;

// 提示刷新了多少条的button
@property (nonatomic,strong)UIButton * updataBtn;
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
//    self.tableView.rowHeight = 500;
    
    
//    [self loadNewStatus];
    
    // 注册一个cell
    [self.tableView registerClass:[SGHomeCell class] forCellReuseIdentifier:@"homeCell"];
    
    
    // 集成刷新控件
   [self setupRefresh];
    [self setupFooterRefresh];
}


#pragma mark - 上拉
- (void)setupRefresh {
    // 1.上拉刷新(进入刷新状态就会调用self的headerRereshing)
     MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置文字
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置刷新控件
    self.tableView.header = header;
}


#pragma mark - 下拉
- (void)setupFooterRefresh {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
      MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 禁止自动加载
//    footer.automaticallyRefresh = NO;
    
    // 设置footer
    self.tableView.footer = footer;
}



#pragma mark - 上下拉刷新的两个方法
// refresh头部刷新的方法
- (void)loadNewData {
    if (self.statuses == nil) {
        [self loadNewWorkWithSince_id:0 withMax_id:0];
    } else {
        SGStatus *status = [self.statuses firstObject];
        NSInteger since_id = status.id;
        [self loadNewWorkWithSince_id:since_id withMax_id:0];
    }
}

- (void)loadMoreData {
    // 刷新表格
    SGStatus * status= [self.statuses firstObject];
    if (status == nil) {
        [self loadNewWorkWithSince_id:0 withMax_id:0];
    } else {
        NSInteger max_id = status.id;
        [self loadNewWorkWithSince_id:0 withMax_id:max_id];
    }
    
    // 拿到当前的上拉刷新控件，结束刷新状态
    [self.tableView.footer endRefreshing];
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

#pragma mark -  tableView 数据源方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 是一样的
    SGHomeCell *cell = [[SGHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    SGHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    cell.status = self.statuses[indexPath.row];
    // 重新布局子控件
    [cell layoutIfNeeded];
    NSLog(@"%lf",[cell cellHeight]);
    return [cell cellHeight];
}


/**
 *   estimated ：预估 大概 contentSize
 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

#pragma mark -加载数据
-(void)loadNewStatusWithSinceId:(NSString *)sinceID complete:(void (^)(NSInteger newCount))complete {
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
     parameters[@"access_token"] = self.userAccount.access_token;
    // 将数据插入到最前面，然后刷新表格
    
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

- (SGAFNTool *)afnTool {
    if (!_afnTool) {
        _afnTool = [SGAFNTool shareAFNTool];
    }
    return _afnTool;
}

- (NSMutableArray *)statuses {
    if (!_statuses) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (UIButton *)updataBtn {
    if (!_updataBtn) {
        _updataBtn = [[UIButton alloc] init];
        [_updataBtn setBackgroundColor:[UIColor orangeColor]];
        _updataBtn.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 44);
        [self.view addSubview:_updataBtn];
    }
    return _updataBtn;
}
#pragma mark - 上啦下拉刷新

- (void)loadNewWorkWithSince_id:(NSInteger)since_id withMax_id:(NSInteger)max_id {
    __block NSArray *newArr = nil;
    [self.afnTool loadNewStatusWithSince_id:since_id WithMax_id:max_id Success:^(id data) {
        
        // 添加数据
        newArr = [SGStatus objectArrayWithKeyValuesArray:data];
        NSLog(@"%@",newArr);
        if (max_id > 0) {
            [self.statuses addObjectsFromArray:newArr];
            [self.tableView.footer endRefreshing];
            
            // 这里可以换一种方式
            [self.tableView reloadData];
        } else {
            [self.tableView.header endRefreshing];
            
            NSIndexSet *insert = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newArr.count)];
            // 这里弹出一个view告诉别人加载了多少条数据
            [self showUpdataView:newArr.count];
            [self.statuses insertObjects:newArr atIndexes:insert];
            [self.tableView reloadData];
        }
    } andFalure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)showUpdataView:(NSInteger)updataCount {
      self.updataBtn.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
      
        [self.updataBtn setTitle:[NSString stringWithFormat:@"更新了%ld条数据",updataCount] forState:UIControlStateNormal];
        self.updataBtn.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.updataBtn.frame =CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 44);
        } completion:^(BOOL finished) {
           self.updataBtn.hidden = YES;
        }];
    }];
    
}
@end

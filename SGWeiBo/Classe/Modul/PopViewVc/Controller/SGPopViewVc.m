//
//  SGPopViewVc.m
//  SGWeiBo
//
//  Created by pkxing on 15/11/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGPopViewVc.h"
@interface SGPopViewVc()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *popoverImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong) NSArray *DataTitle;
@end
@implementation SGPopViewVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 接收标题头弹出的pop控制器的containView被点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissController) name:kSGPresentVcContainViewTapGestureClick object:nil];
    
}

- (void)dismissController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.DataTitle.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"popViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.DataTitle[indexPath.row];
    return cell;
}

#pragma mark - set & get
- (NSArray *)DataTitle {
    if (_DataTitle == nil) {
        _DataTitle = @[@"发微博",@"扫一扫",@"加朋友",@"都不知道要干嘛"];
    }
    return _DataTitle;
}



@end

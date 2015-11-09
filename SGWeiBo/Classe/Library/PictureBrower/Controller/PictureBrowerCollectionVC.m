//
//  PictureBrowerCollectionVC.m
//  PictureBrowser
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "PictureBrowerCollectionVC.h"
#import "PictureBrowerCell.h"
#import "UIButton+Extension.h"
#define kTipLabelY 40
#define kTipLabelH 60
#define kMarginLeft 30
#define kMarginRight 30
#define kBtnHeight 40
#define kBtnWidth 100
#define KScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kPictureBrowerCellIdentifier @"PictureBrowerCellIdentifier"
@interface  PictureBrowerCollectionVC()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) NSArray *imageUrls;

@property(nonatomic,assign) NSInteger index;
// 图片浏览
@property(nonatomic,weak) UICollectionView *collectionView;
// 提示文本
@property(nonatomic,weak) UILabel *tipLabel;
// 返回按钮
@property(nonatomic,weak) UIButton *backBtn;
// 保存图片按钮
@property(nonatomic,weak) UIButton *savaBtn;
@end

@implementation PictureBrowerCollectionVC


- (instancetype)initWithImageUrls:(NSArray *)imageUrls Index:(NSInteger)index {
    if (self = [super init]) {
        self.imageUrls = imageUrls;
        self.index = index;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubView];
    // 注册cell
    [self.collectionView registerClass:[PictureBrowerCell class] forCellWithReuseIdentifier:kPictureBrowerCellIdentifier];
    
    [self setCollectionViewOffset];
}

#pragma mark - 设置collectionView属性
- (void)setupCollectionViewProperty {
    self.collectionView.collectionViewLayout = [self setupLayoutFlower];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 给collView添加子控件

}

#pragma mark - 定义layout
- (UICollectionViewFlowLayout *)setupLayoutFlower {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
}

#pragma mark - 添加子控件
- (void)setupSubView {
    
    //图片浏览collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self setupLayoutFlower]];
    self.collectionView = collectionView;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    [self setupCollectionViewProperty];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.frame = CGRectMake(0, kTipLabelY, [UIScreen mainScreen].bounds.size.width, kTipLabelH);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.text = [NSString stringWithFormat:@"%ld / %ld",self.index + 1,self.imageUrls.count];
    self.tipLabel = tipLabel;
    [self.view addSubview:tipLabel];
    
    UIButton *backBtn = [UIButton buttonWithTitle:@"退出" norImage:@"health_button_orange_line" heilightImage:@"health_button_orange_line"];
    
    backBtn.frame = CGRectMake(kMarginLeft, KScreenH - kBtnHeight - 60, kBtnWidth, kBtnHeight);
    [backBtn addTarget:self action:@selector(backBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    self.backBtn = backBtn;
    
    UIButton *savaBtn = [UIButton buttonWithTitle:@"保存" norImage:@"health_button_orange_line" heilightImage:@"health_button_orange_line"];
    savaBtn.frame = CGRectMake(kScreenW - kBtnWidth - kMarginRight, KScreenH - kBtnHeight - 60, kBtnWidth, kBtnHeight);
    [savaBtn addTarget:self action:@selector(saveBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.savaBtn = savaBtn;
    [self.view addSubview:savaBtn];
    
}

#pragma mark - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureBrowerCell *cell = [PictureBrowerCell cellWithCollectionView:collectionView IndexPath:indexPath];
    cell.largeString = self.imageUrls[indexPath.row];
    return cell;
}
#pragma mark - 当停止滑动的时候调用的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint point = self.collectionView.contentOffset;
    NSInteger curent = point.x / kScreenW;
    self.tipLabel.text = [NSString stringWithFormat:@"%ld / %ld",curent + 1 , self.imageUrls.count];
}

#pragma mark - 根据index的值设定偏移量
- (void)setCollectionViewOffset {
    self.collectionView.contentOffset = CGPointMake((self.index -1) * kScreenW , 0);
    NSLog(@"%@",self.collectionView);
}

#pragma mark - 保存按钮点击时间
- (void)saveBtnDidClick {
    NSLog(@"%@",@"点击了保存按钮");
}

#pragma mark - 退出按钮点击事件
- (void)backBtnDidClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}















@end

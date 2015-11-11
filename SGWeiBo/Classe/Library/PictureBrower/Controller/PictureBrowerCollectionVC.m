//
//  PictureBrowerCollectionVC.m
//  PictureBrowser
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "PictureBrowerCollectionVC.h"
#import "PictureBrowerCell.h"
#import "SGPictureBrowerModalAnimation.h"
#import "SGPictureBrowerDismissAnimation.h"

#import "SGImageModel.h"
#define kTipLabelY 40
#define kTipLabelH 60
#define kMarginLeft 30
#define kMarginRight 30
#define kBtnHeight 40
#define kBtnWidth 100
#define KScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kPictureBrowerCellIdentifier @"PictureBrowerCellIdentifier"

@interface  PictureBrowerCollectionVC()<UICollectionViewDataSource,UICollectionViewDelegate,PictureBrowerCellDelegate>

@property(nonatomic,assign) NSInteger index;

// 提示文本
@property(nonatomic,weak) UILabel *tipLabel;

// 返回按钮
@property(nonatomic,weak) UIButton *backBtn;

// 保存图片按钮
@property(nonatomic,weak) UIButton *savaBtn;

// 当前的cell
@property(nonatomic,weak) PictureBrowerCell *currentCell;

@end

@implementation PictureBrowerCollectionVC


- (instancetype)initWithImageModel:(NSArray *)imageModel imageView:(UIImageView *)tempView {
    if (self = [super init]) {
        
        self.transitioningDelegate = self;
        
        // 不定义PrensenttionStyle 默认是黑色透明背景
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        self.imageModels = imageModel;
        
        self.tempView = tempView;
        
        self.index = tempView.tag +1;

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

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
    
    // 添加提示文本
    UILabel *tipLabel = [[UILabel alloc] init];
    
    tipLabel.frame = CGRectMake(0, kTipLabelY, [UIScreen mainScreen].bounds.size.width, kTipLabelH);
    
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    tipLabel.textColor = [UIColor whiteColor];
    
    tipLabel.font = [UIFont systemFontOfSize:14];
    
    tipLabel.text = [NSString stringWithFormat:@"%ld / %ld",self.index,self.imageModels.count];
    
    self.tipLabel = tipLabel;
    
    [self.view addSubview:tipLabel];
    
    // 返回按钮
    UIButton *backBtn = [self buttonWithTitle:@"退出" norImage:@"health_button_orange_line" heilightImage:@"health_button_orange_line"];
    
    backBtn.frame = CGRectMake(kMarginLeft, KScreenH - kBtnHeight - 60, kBtnWidth, kBtnHeight);
    
    [backBtn addTarget:self action:@selector(backBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
    self.backBtn = backBtn;
    
    // 添加保存按钮
    UIButton *savaBtn = [self buttonWithTitle:@"保存" norImage:@"health_button_orange_line" heilightImage:@"health_button_orange_line"];
    
    savaBtn.frame = CGRectMake(kScreenW - kBtnWidth - kMarginRight, KScreenH - kBtnHeight - 60, kBtnWidth, kBtnHeight);
    
    [savaBtn addTarget:self action:@selector(saveBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.savaBtn = savaBtn;
    
    [self.view addSubview:savaBtn];
    
}

#pragma mark - 自定义button
- (UIButton *)buttonWithTitle:(NSString *)title norImage:(NSString *)norImage heilightImage:(NSString *)heilightImage {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:heilightImage] forState:UIControlStateHighlighted];
    return button;
}

#pragma mark - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureBrowerCell *cell = [PictureBrowerCell cellWithCollectionView:collectionView IndexPath:indexPath];
    SGImageModel *imageModel = self.imageModels[indexPath.row];
    cell.imageModel = imageModel;
    self.currentCell = cell;
    cell.backgroundColor = [UIColor clearColor];
    cell.celldelegate =self;
    return cell;
}

#pragma mark - 当停止滑动的时候调用的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint point = self.collectionView.contentOffset;
    NSInteger curent = point.x / kScreenW;
    self.tipLabel.text = [NSString stringWithFormat:@"%ld / %ld",curent + 1 , self.imageModels.count];
}

#pragma mark - 根据index的值设定偏移量
- (void)setCollectionViewOffset {
    
    self.collectionView.contentOffset = CGPointMake((self.index -1) * kScreenW , 0);
}

#pragma mark - 保存按钮点击时间
- (void)saveBtnDidClick {
    
#warning -mark 判断是否可以访问相册
    // 如果不可以访问相册那就不比保存直接提示用户不可以访问相册需要设置就好了
    if ( ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    /**
     completionTarget: 保存成功或失败,回调这个对象
     completionSelector: 回调的方法
     - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
     image didFinishSavingWithError contextInfo : 前面的名称 都相当于swift里面的外部参数名
     */
    UIImage *image = self.currentCell.imageView.image;
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}

// 写入相册的时候这个方法一定要实现
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}



#pragma mark - 获取正在显示的视图
- (NSInteger)currentRow {
    
    NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    
    return indexPath.row;
}

- (UIImageView *)currentShowView {
    
    return self.currentCell.imageView;
}

#pragma mark - 退出按钮点击事件
- (void)backBtnDidClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 转场动画代理方法
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [[SGPictureBrowerModalAnimation alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [[SGPictureBrowerDismissAnimation alloc] init];
}

#pragma mark - cellDelegate的代理方法
- (void)pictureBrowerCellClose:(PictureBrowerCell *)cell {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)pictureBrowerCell:(PictureBrowerCell *)cell WithAlpha:(CGFloat)alpha {
    
    self.collectionView.alpha = alpha;
}

#pragma mark - 当控制器消失的时候调用
- (void)dealloc {
    
    NSLog(@"浏览图片挂掉");
}





@end

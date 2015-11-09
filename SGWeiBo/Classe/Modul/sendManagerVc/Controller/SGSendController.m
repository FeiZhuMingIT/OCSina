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
#import "SGSendToolBar.h"
#import "SGEmotionKeyBoard.h"
#import "UILabel+Extension.h"
#import "PictureCollectionView.h"
#import "UIImage+Extension.h"
#import "PictureCollectionViewCell.h"
#import "SVProgressHUD.h"
#import "SGAFNTool.h"
@interface SGSendController ()<SGSendToolBarDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)SGUserAccount * userAccount;
//
@property (nonatomic,strong)UILabel * titlebel;

// 工具条
@property (nonatomic,weak)SGSendToolBar * sendToolBar;
// textView
@property (nonatomic,weak)UITextView * textView;

// 表情键盘懒加载
@property(nonatomic,strong) SGEmotionKeyBoard *emotionKeyBoard;
// 添加提示文本
@property(nonatomic,strong) UILabel *tipLabel;
// 添加一条文本提示按钮
@property(nonatomic,strong) UILabel *tipNumberLabel;

// 图片发送选择器
@property(nonatomic,strong) NSMutableArray *selectImageArr;

@property(nonatomic,strong) PictureCollectionView *pictureView;

// 系统的选择控制器
@property(nonatomic,strong) UIImagePickerController *pickerController;
// pictureCollectionViewCell传出来的cell
@property(nonatomic,strong) PictureCollectionViewCell *soulCell;
// 网络请求工具类
@property(nonatomic,strong) SGAFNTool *afnTool;
@end

@implementation SGSendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupNavigationItem];
    // 设置标题栏
    [self setupTitleView];
    // 加一个UITextView
    [self setupUITextView];
    // 加一条提示文本
    [self setupTipLabel];
    // 添加pictureView
    [self setupPictureView];
    // 加一条工具条
    [self setupSendBarTool];
    // 加一条提示文本数量文本
    [self setupTipNumberLabel];
    // 接受键盘value Frame值改变的value
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // 监听textView值的改变 没用
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange) name:UITextViewTextDidBeginEditingNotification object:nil];
    [self.textView becomeFirstResponder];
    
    
    
    // 接收通知 这个object填 nil代表谁的通知都可以接收
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentUIImagePickerController:) name:kPictureCollectionViewCellDefaultBtnDidClickNotification object:nil];
    
    
    // 利用KVO监听值的selectImageArr的改变
//    self.selectImageArr observeValueForKeyPath:<#(nullable NSString *)#> ofObject:self change: context:nil

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - 添加picurView
- (void)setupPictureView {
    // 模拟
    self.pictureView = [PictureCollectionView pictureViewWithIndex:0 WithImageArr:self.selectImageArr];
    // 一开始让PictureView隐藏到下面去
    self.pictureView.frame = CGRectMake(0, kScreenHeight, [UIScreen mainScreen].bounds.size.width, 300);
    
    [self.view addSubview:self.pictureView];
    self.pictureView.backgroundColor = [UIColor orangeColor];
}
#pragma mark  - cell被点击了访问了系统相册
- (void)presentUIImagePickerController:(NSNotification *)notification {
    
    self.soulCell = (PictureCollectionViewCell *)notification.object;
    
    // 判断相册是否可以被访问 不可以访问返回
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    // 接收一下
    // 嵌套一个导航控制器它?
    _pickerController = [[UIImagePickerController alloc] init];
    _pickerController.delegate = self;
    [self.navigationController presentViewController:_pickerController animated:YES completion:nil];
}

#pragma mark - 监听textView的值改变的事件
- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ((NSInteger)self.textView.attributedText.length > 0) {
        self.tipLabel.hidden = YES;
    } else {
        self.tipLabel.hidden = NO;
    }
    if (kTextViewMaxLanbelNumber - (NSInteger)self.textView.attributedText.length > 0 && self.textView.attributedText.length != 0) {
        self.tipNumberLabel.textColor = [UIColor grayColor];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.tipNumberLabel.textColor = [UIColor redColor];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    self.tipNumberLabel.text = [NSString stringWithFormat:@"%ld",kTextViewMaxLanbelNumber - self.textView.attributedText.length];
}

#pragma mark -控制器即将消失的时候调用的方法
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}

#pragma mark - 键盘值开始改变的按钮
- (void)KeyboardWillChangeFrame:(NSNotification *)notification {

    NSDictionary *dic=notification.userInfo;
    CGRect endFrame=[dic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat offsetY=endFrame.origin.y-self.view.frame.size.height;
    
    [self.sendToolBar setTransform:CGAffineTransformMakeTranslation(0, offsetY)];
    
}
#pragma mark - 设置navigationItem
- (void)setupNavigationItem {
   

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backVc)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
#pragma mark - 设置标题title
- (void)setupTitleView {
    if (!self.userAccount.name) {
        // OC居然不可以加
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
#pragma mark -加一条提示文本
- (void)setupTipLabel {
    [self.textView addSubview:self.tipLabel];
}
#pragma mark - 加一个textView
- (void)setupUITextView {
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(0, 0, kScreenWidth, 300);
    // 当开始滑动的时候消失键盘
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    textView.scrollEnabled = YES;
    textView.bounces = YES;
    textView.alwaysBounceVertical = YES;
    textView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:textView];
    // 因为监听值的改变不能监听到表情的添加所以使用代理
    textView.delegate = self;

    self.textView = textView;
}
#pragma mark - 加一条工具条
- (void)setupSendBarTool {
    SGSendToolBar *toolBar = [[SGSendToolBar alloc]init];
    toolBar.backgroundColor = [UIColor colorWithWhite:235.0/255.0 alpha:1];
    toolBar.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
    toolBar.delegate = self;
    self.sendToolBar = toolBar;
    // 添加五个按钮在里面
       // 因为是多了一个弹簧所以要移除最后一个弹簧
    // 拿到最后一个弹簧
    [self.view addSubview:toolBar];
}
#pragma mark - 加一条提示方法
- (void)setupTipNumberLabel {
    [self.view addSubview:self.tipNumberLabel];
}
#pragma mark - SGSendToolBar代理方法
- (void)sendToolBarDidClick:(SGSendToolBar *)toolBar WithSendToolBarBtnType:(SGSendToolBarBtnType)ComposeToolBarBtnType {
    if (ComposeToolBarBtnType == SGSendToolBarBtnTypeEmoticon) {
        // 让表情键盘成为第一响应者
        [self.textView resignFirstResponder];
        // 时间太快来不及切换
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 先让之前的变成不是第一响应者
            self.textView.inputView = self.textView.inputView == nil? self.emotionKeyBoard: nil;
            // 再改变键盘让它成为第一响应者
            [self.textView becomeFirstResponder];
        });
    } if (ComposeToolBarBtnType == SGSendToolBarBtnTypeImage) {
        // 点击后让它上来
        [UIView animateWithDuration:0.25 animations:^{
             self.pictureView.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 300);
        }];
    }
}
#pragma mark -工具条按钮点击方法
// 没办法，无法根据图片名字来获取方法
- (void)TabBarToolItemDidClick:(UIButton *)button {
    
}
#pragma mark - 返回方法
- (void)backVc {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 发送微博方法
- (void)sendMessage {
    // 文本
    NSString *sendString = [self.emotionKeyBoard realText];
    // 提示用户正在发送微博
    [SVProgressHUD showWithStatus:@"正在发送微博" maskType:SVProgressHUDMaskTypeBlack];
    UIImage *sendImage = nil;
    // 找到第一张图片
    if (self.selectImageArr.count > 0) {
        sendImage = self.selectImageArr[0];
    }
   
    // 发送
    [self.afnTool sendStatusWithImage:sendImage statues:sendString success:^(id data) {
        [SVProgressHUD showSuccessWithStatus:@"发送成功" maskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            });
        });
        
        [SVProgressHUD dismiss];
    } falure:^(NSError *error) {
        // 发送微博失败
        [SVProgressHUD showErrorWithStatus:@"发送失败" maskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            //回到主线程
        });
    }];
}

#pragma mark - UIImagePickerController的代理方法
// 过期
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
    
}

//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = [UIScreen mainScreen].bounds;
    // 这样就拿到了自己选择的从相册拿出来的image
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    // 压缩图片
    UIImage *newImage = [UIImage scaleImage:image];
    // 加到数组中 然后刷新界面
    if (self.soulCell.image == nil) {
        [self.selectImageArr addObject:newImage];
    } else {
        self.selectImageArr[self.soulCell.tag] = newImage;
    }
    
    self.pictureView.imageArr = self.selectImageArr;
    if (self.selectImageArr.count > 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else if (self.selectImageArr.count == 0 && self.textView.attributedText.length == 0) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    // 刷新
    [self.pictureView reloadData];
    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
    // 重新让它成为第一响应者
    [self.textView becomeFirstResponder];
}
#pragma mark -  set& get 
// 表情键盘懒加载
- (SGEmotionKeyBoard *)emotionKeyBoard {
    if (!_emotionKeyBoard) {
        _emotionKeyBoard = [[SGEmotionKeyBoard alloc] initWithFrame:CGRectMake(0, kScreenHeight - 214, kScreenWidth, 214)];
        _emotionKeyBoard.textView = self.textView;
    }
    return _emotionKeyBoard;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel labelWithFontSize:15 textColor:[UIColor grayColor]];
        _tipLabel.text = @"请输入要发送的微博内容";
        [_tipLabel sizeToFit];
        _tipLabel.frame = CGRectMake(2, 5, _tipLabel.frame.size.width, _tipLabel.frame.size.height);
    }
    return _tipLabel;
}
- (UILabel *)tipNumberLabel {
    if (!_tipNumberLabel) {
        _tipNumberLabel = [UILabel labelWithFontSize:13 textColor:[UIColor grayColor]];
        _tipNumberLabel.text = [NSString stringWithFormat:@"%d",kTextViewMaxLanbelNumber];
        [_tipNumberLabel sizeToFit];
        _tipNumberLabel.frame = CGRectMake(kScreenWidth - 50, 300 - 20, 50, 20);
    }
    return _tipNumberLabel;
}

- (NSMutableArray *)selectImageArr {
    if (_selectImageArr == nil) {
        _selectImageArr = [NSMutableArray array];
    }
    return _selectImageArr;
}

- (SGAFNTool *)afnTool {
    if (_afnTool == nil) {
        _afnTool = [SGAFNTool shareAFNTool];
    }
    return _afnTool;
}

#pragma mark - 当控制器移除的时候
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
@end

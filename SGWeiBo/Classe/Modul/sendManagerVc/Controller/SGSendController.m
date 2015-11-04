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
@interface SGSendController ()<SGSendToolBarDelegate,UITextViewDelegate>
@property (nonatomic,strong)SGUserAccount * userAccount;
//
@property (nonatomic,strong)UILabel * titlebel;

// 工具条
@property (nonatomic,weak)SGSendToolBar * sendToolBar;
// textView
@property (nonatomic,weak)UITextView * textView;
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
    // 加一条工具条
    [self setupSendBarTool];
    // 接受键盘value Frame值改变的value
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -控制器即将消失的时候调用的方法
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}

//#pragma mark - 键盘值开始改变的按钮
- (void)KeyboardWillChangeFrame:(NSNotification *)notification {
//
    NSDictionary *dic=notification.userInfo;
    CGRect endFrame=[dic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat offsetY=endFrame.origin.y-self.view.frame.size.height;
    
    [self.sendToolBar setTransform:CGAffineTransformMakeTranslation(0, offsetY)];
    
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
#pragma mark - 加一条工具条
- (void)setupUITextView {
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = self.view.bounds;
    // 当开始滑动的时候消失键盘
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    textView.scrollEnabled = YES;
    textView.bounces = YES;
//    textView.showsVerticalScrollIndicator = YES;
    textView.alwaysBounceVertical = YES;
    textView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:textView];
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
#pragma mark - SGSendToolBar代理方法
- (void)sendToolBarDidClick:(SGSendToolBar *)toolBar WithSendToolBarBtnType:(SGSendToolBarBtnType)ComposeToolBarBtnType {
    NSLog(@"来了这里");
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

}
#pragma mark - 当控制器移除的时候 
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

@end

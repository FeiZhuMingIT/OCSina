//
//  SGEmotionVc.m
//  SGEmotion
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGEmotionVc.h"

#import "EmotionAttachment.h"
#import "EmotionToolBar.h"
#import "Emotion.h"
#import "EmtionTool.h"
#import "SGCollectionViewFlowLayout.h"
#import "emotionCell.h"
#define kSreenHeight [UIScreen mainScreen].bounds.size.height
#define kSreenWidth  [UIScreen mainScreen].bounds.size.width
#define kkeyBoardHeight 214

@interface SGEmotionVc ()<UICollectionViewDelegate,UICollectionViewDataSource,EmotionToolBarDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,weak)UICollectionView * collectionView;

// 存储的是所有表情的路径
@property (nonatomic,strong)NSArray * emojis;

// 键盘高度214
@end
@implementation SGEmotionVc

- (void)viewDidLoad {
    [super viewDidLoad];
    EmotionToolBar *toolBar = [[EmotionToolBar alloc] initWithFrame:CGRectMake(0, kSreenHeight - 44, kSreenWidth, 44)];
    toolBar.backgroundColor = [UIColor lightGrayColor];
    toolBar.toolBarDelegate = self;
    [self.view addSubview:toolBar];
    [self setupSubView];
    [self.collectionView registerClass:[emotionCell class] forCellWithReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setupSubView {
    
    SGCollectionViewFlowLayout *layout = [[SGCollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kSreenHeight - 44 -kkeyBoardHeight, kSreenWidth, kkeyBoardHeight) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor cyanColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.emojis.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    EmotionAttachment *emotionArrachment = self.emojis[section];
    return emotionArrachment.emoticons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    emotionCell *cell = [emotionCell cellWithCollectionView:collectionView withIndexPath:indexPath];
    EmotionAttachment *emotionArrachment = self.emojis[indexPath.section];
    Emotion *emtion = emotionArrachment.emoticons[indexPath.row];
    cell.emtion = emtion;
    return cell;
}


#pragma mark - 工具条代理方法
- (void)emotionToolBar:(EmotionToolBar *)emotionToolBar WithSelectIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:index];
    // 奔溃是因为没有添加最近
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
}

#pragma mark - set && get
- (NSArray *)emojis {
    if (_emojis == nil) {
        _emojis = [EmotionAttachment emotionAttachments];
        NSLog(@"%ld",_emojis.count);
    }
    return _emojis;
}

@end

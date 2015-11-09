//
//  SGEmotionKeyBoard.m
//  SGEmotion
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGEmotionKeyBoard.h"
#import "SGEmotionCollectionView.h"
#import "EmotionToolBar.h"
#import "SGCollectionViewFlowLayout.h"
#import "emotionCell.h"
#import "EmotionAttachment.h"
#import "Emotion.h"
#import "SGEmotionAttachment.h"
#define kBaseTag 1000
@interface SGEmotionKeyBoard()<EmotionToolBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,weak)SGEmotionCollectionView *collectionView;
@property (nonatomic,weak)EmotionToolBar *toolBar;
// 存储的是所有表情的路径
@property (nonatomic,strong)NSArray * emojis;


// 保存上一个section
@property (nonatomic,assign)NSInteger preSection;
@end

@implementation SGEmotionKeyBoard

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    EmotionToolBar *toolBar = [[EmotionToolBar alloc] init];
    toolBar.toolBarDelegate = self;
    [self addSubview:toolBar];
    self.toolBar = toolBar;
    
    SGCollectionViewFlowLayout *layout = [[SGCollectionViewFlowLayout alloc] init];
    SGEmotionCollectionView *collectionView = [[SGEmotionCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor colorWithWhite:233/255.0f alpha:1];
    // 注册cell一定是在和collectionView一起的view或者控制器上
    [self.collectionView registerClass:[emotionCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    // 创建通知中心接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectionIndexPathSectionValueChange:) name:@"collectionIndexPathSectionValueChange" object:nil];
}


- (void)collectionIndexPathSectionValueChange:(NSNotification *) notification {

}

#pragma mark - 工具条代理方法
- (void)emotionToolBar:(EmotionToolBar *)emotionToolBar WithSelectIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index - kBaseTag];
    // 奔溃是因为没有添加最近
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
}


#pragma mark - collectionView数据源方法
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

#pragma mark - collectionView代理方法
// 监听scrollView滚动，当停下来的时候判断显示的是哪一个section
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 如果section没有改变就不用继续
    // 获得collectionView正在显示的cell的indexpath
    NSIndexPath *indexPath = self.collectionView.indexPathsForVisibleItems.firstObject;
    // 获得对应的组
    NSInteger section = indexPath.section;
    if (section != self.preSection) {
        // 根据tag去找，因为里面还有弹簧
        // 因为toolBar的tag默认是0，当他找到tag的时候会让自己消失,所以要加上基础的tag值
        UIButton *currentBtn = (UIButton *)[self.toolBar viewWithTag:section + kBaseTag];
        [self.toolBar toolBarBtnSelect:currentBtn];
        self.preSection = section;
    }
}
#pragma mark - 当item表情点击的时候触发的方法
// 记得把btn与用户交互给禁止掉，不然会让btn接受到时间
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    // 拿到当前cell的数据
    EmotionAttachment *emotionAttachment = self.emojis[indexPath.section];
    Emotion *emotion = emotionAttachment.emoticons[indexPath.row];
    // 如果是删除按钮，删除文本返回
     if (emotion.removeEmoji != nil) {
        [self.textView deleteBackward];
         return;
    }
    EmotionAttachment *resentEmotion = self.emojis[0];
    if (resentEmotion != emotionAttachment) {
        [resentEmotion appendEmotion:emotion];
    }
    // 只有有数据的时候才点点击表情
    if (emotion.png != nil || emotion.code != nil) {
        [self insertEmotion:emotion];
    }
    
    
}
#pragma mark - 点击了删除按钮删除textView上的元素


#pragma mark - 将图片的名字
- (void)insertEmotion:(Emotion *)emotion {
    if (self.textView == nil) {
        return;
    }
    if (emotion.code) {
        // 通过insert方法来添加表情，会发送 文字内容改变的通知和调用代理
        [self.textView insertText:emotion.code];
    } else {
        NSMutableAttributedString *attStrM = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        SGEmotionAttachment *attach = [[SGEmotionAttachment alloc] init];
        attach.emotion = emotion;
        // 设置图片大小 = 字体的高度
//        CGFloat imgW = self.textView.font.lineHeight + 2;
        // 这里就是应该给真实值，不然会出现 表情大小不匹配的问题，最好是与外面的默认值是一样的值
        CGFloat imgW = 12 + 2;
        CGFloat imgH = imgW;
        // 普通图片位置不好看，往下移动，负数即可
        attach.bounds = CGRectMake(0, -3, imgW, imgH);
        NSAttributedString *imgAttStr = [NSAttributedString attributedStringWithAttachment:attach];
        // 插入的时候，要获取插入的位置
        NSInteger insertIndex = self.textView.selectedRange.location;
        [attStrM insertAttributedString:imgAttStr atIndex:insertIndex];
        // 每次重新设置文本字体大小
        // 如果一开始没有值，就让它返回

            
            [attStrM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, attStrM.length)];

        
        self.textView.attributedText = attStrM;
        // 光标回到插入后的位置
        self.textView.selectedRange = NSMakeRange(insertIndex + 1, 0);
        if ([self.textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [self.textView.delegate textViewDidChange:self.textView];
        }
    }
    
}
#pragma mark - set && get
- (NSArray *)emojis {
    if (_emojis == nil) {
        _emojis = [EmotionAttachment emotionAttachments];
        NSLog(@"%ld",_emojis.count);
    }
    return _emojis;
}

#pragma mark - 自动布局
- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 44);
    self.toolBar.frame = CGRectMake(0, self.frame.size.height - 44, self.frame.size.width, 44);
}

#pragma mark - 真实字符串
// 真实的字符串
- (NSString *)realText {
    NSMutableString *strM = [NSMutableString string];
    [self.textView.attributedText enumerateAttributesInRange:NSMakeRange(0, self.textView.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        //        CZLog(@"%@",attrs);
        SGEmotionAttachment *textAtt = attrs[@"NSAttachment"];
        //有附件，获取表情chs
        if(textAtt){
            [strM appendString:textAtt.emotion.chs];
        }else{//文字
            NSAttributedString *attStr =[self.textView.attributedText attributedSubstringFromRange:range];
            [strM appendString:attStr.string];
        }
    }];
    
    return [strM copy];
}

@end

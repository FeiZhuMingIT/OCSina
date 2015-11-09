//
//  EmotionToolBar.m
//  SGEmotion
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "EmotionToolBar.h"
#import "EmotionAttachment.h"
#define kBasetag 1000
@interface EmotionToolBar()

@property (nonatomic,weak)UIButton *selectBtn;
@end
@implementation EmotionToolBar

- (instancetype)init {
    if (self = [super init]) {
        [self setupSubview];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubview];
    }
    return self;
}

- (void)setupSubview {

    NSMutableArray *mtbArr = [NSMutableArray array];
    UIBarButtonItem *itemRecent = [self setupButtonWithTitle:@"最近" WithIndex:0];
     UIBarButtonItem *fixspace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [mtbArr addObjectsFromArray:@[itemRecent,fixspace]];
    // 根据
    NSArray *pagers = [EmotionAttachment emotionAttachments];
    for (NSInteger index = 1; index < pagers.count; index ++) {
        EmotionAttachment *attachment = pagers[index];
        UIBarButtonItem *itemRecent = [self setupButtonWithTitle:attachment.group_name_cn WithIndex:index];
        [mtbArr addObjectsFromArray:@[itemRecent,fixspace]];
    }
    // 删除最后一个元素
    [mtbArr removeLastObject];
    self.items = mtbArr;
}


- (UIBarButtonItem *)setupButtonWithTitle:(NSString *)title WithIndex:(NSInteger)index{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn
    ];
    btn.tag = index + kBasetag;
    [btn addTarget:self action:@selector(toolBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return item;
}

- (void)toolBarBtnClick:(UIButton *)btn {
    
    [self toolBarBtnSelect:btn];
    if ([self.toolBarDelegate respondsToSelector:@selector(emotionToolBar:WithSelectIndex:)]) {
        [self.toolBarDelegate emotionToolBar:self WithSelectIndex:btn.tag];
    }
}


- (void)toolBarBtnSelect:(UIButton *)btn {
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
}

@end

//
//  SGSendToolBar.m
//  SGWeiBo
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGSendToolBar.h"
#import "UIButton+Extension.h"
#define kBtnCount 5
@interface SGSendToolBar()
// 存储item的数组字典
@property (nonatomic,strong)NSArray * itemSettings;
@end

@implementation SGSendToolBar

- (instancetype)init {
    if (self = [super init]) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    for (NSInteger index = 0; index < self.itemSettings.count ; index ++) {
        UIButton *button = [[UIButton alloc] initWithTitle:nil bgColor:nil imageName:self.itemSettings[index][@"imageName"]];
        button.tag = index;
        [button addTarget:self action:@selector(TabBarToolItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(TabBarToolItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat width = kScreenWidth / kBtnCount;
        button.frame = CGRectMake(index * width, 0, width, 44);
        [self addSubview:button];
    }
}

- (void)TabBarToolItemDidClick:(UIButton *)selectBtn {
    if ([self.delegate respondsToSelector:@selector(sendToolBarDidClick:WithSendToolBarBtnType:)]) {
        [self.delegate sendToolBarDidClick:self WithSendToolBarBtnType:selectBtn.tag];
    }
}

#pragma mark - set && get
- (NSArray *)itemSettings {
    if (_itemSettings == nil) {
        _itemSettings = @[@{@"imageName": @"compose_toolbar_picture"},
                          @{@"imageName": @"compose_trendbutton_background"},
                          @{@"imageName": @"compose_mentionbutton_background"},
                          @{@"imageName": @"compose_emoticonbutton_background"},
                          @{@"imageName": @"compose_addbutton_background"}];
        
    }
    return _itemSettings;
}


#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
 
}

@end

//
//  emotionCell.m
//  SGEmotion
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "emotionCell.h"
#import "Emotion.h"
#define kEmotionBundlePath [[NSBundle mainBundle] pathForResource:@"Emoticons.bundle" ofType:nil]
#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)
@interface emotionCell()
@property (nonatomic,weak)UIButton * button;
@end
@implementation emotionCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath {
    emotionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    // 缓冲区已经有一个button了这里又给它加一个button
    // 所以这里应该加一个判断如果它有了就不需要再次添加了
    if (cell.button == nil) {
        [cell setupSubView];
    }
    
    return cell;
}

// 重写dequ

- (void)setupSubView {
    UIButton *button = [[UIButton alloc] init];
    [self addSubview:button];
    button.userInteractionEnabled = NO;
    self.button = button;
}

// 一定要先给cell赋值再添加到到cell的父控件中
- (void)layoutSubviews {
    [super layoutSubviews];
    self.button.frame = self.bounds;
}


- (void)setEmtion:(Emotion *)emtion {
    // 将code16位转换成emoji表情
    _emtion = emtion;
    if (emtion.code) {
        [self.button setTitle:emtion.code forState:UIControlStateNormal];
        self.button.titleLabel.font = [UIFont systemFontOfSize:28];
        [self.button setImage:nil forState:UIControlStateNormal];
    } else if (emtion.png) {
        [self.button setImage:[UIImage imageNamed:emtion.png] forState:UIControlStateNormal];
        [self.button setTitle:nil forState:UIControlStateNormal];
    } else if (emtion.removeEmoji != nil) {
        [self.button setImage:[UIImage imageNamed:emtion.removeEmoji] forState:UIControlStateNormal];
        [self.button setTitle:nil forState:UIControlStateNormal];
    } else {
        [self.button setTitle:nil forState:UIControlStateNormal];
        [self.button setImage:nil forState:UIControlStateNormal];
    }
  
}


@end

//
//  EmotionToolBar.h
//  SGEmotion
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionToolBar;
@protocol EmotionToolBarDelegate <NSObject>

- (void)emotionToolBar:(EmotionToolBar *)emotionToolBar WithSelectIndex:(NSInteger)index;

@end
@interface EmotionToolBar : UIToolbar

@property (nonatomic,weak)id<EmotionToolBarDelegate>  toolBarDelegate;

// 放开这个方法
- (void)toolBarBtnSelect:(UIButton *)btn;
@end

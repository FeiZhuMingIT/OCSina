//
//  SGSendToolBar.h
//  SGWeiBo
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger,SGSendToolBarBtnType){
    SGSendToolBarBtnTypeImage = 0,//图片
    SGSendToolBarBtnTypeMetion,//@
    SGSendToolBarBtnTypeTrend,//#
    SGSendToolBarBtnTypeEmoticon,//表情
    SGSendToolBarBtnTypeKeyboard,//键盘
    SGSendToolBarBtnTypeAdd //添加
} ;
@class SGSendToolBar;
@protocol SGSendToolBarDelegate <NSObject>

- (void)sendToolBarDidClick:(SGSendToolBar *)toolBar WithSendToolBarBtnType:(SGSendToolBarBtnType)ComposeToolBarBtnType;

@end
@interface SGSendToolBar : UIView

@property (nonatomic,weak)id<SGSendToolBarDelegate>  delegate;

@end

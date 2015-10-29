//
//  SGLoginView.h
//  SGWeiBo
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGLoginView;
@protocol SGLoginViewDelegate <NSObject>

- (void)loginView:(SGLoginView *)loginView loginBtn:(UIButton *)loginBtn;
- (void)loginView:(SGLoginView *)loginView registerBtn:(UIButton *)loginBtn;

@end

@interface SGLoginView : UIView

@property (nonatomic,weak) id<SGLoginViewDelegate> delegate;

- (void)setSubViewWithMasterImage: (NSString *)masterImage loopImage:(NSString *)loopImage title: (NSString *)title;

+ (instancetype)loginViewWithMasterImage: (NSString *)masterImage loopImage:(NSString *)loopImage title: (NSString *)title;

@end

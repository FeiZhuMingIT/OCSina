//
//  SGEmotionCollectionView.m
//  SGEmotion
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGEmotionCollectionView.h"
#import "EmotionAttachment.h"
#import "emotionCell.h"
#import "SGCollectionViewFlowLayout.h"
@interface SGEmotionCollectionView()
@property (nonatomic,weak)UICollectionView * collectionView;

@end
@implementation SGEmotionCollectionView

- (instancetype) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {

    }
    return self;
}

@end

//
//  SGPhotoView.m
//  SGWeiBo
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGPhotoView.h"
#import "UIImageView+WebCache.h"
#define kImageViewCount 9
#define kImageWidth 90
#define kMargin 10
#define kGifW 27
#define kGifH 20


@interface SGPhotoView()

@property(nonatomic,weak) UIImageView *imageView;


@property(nonatomic,weak) UIImageView *gifView;
@end

@implementation SGPhotoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        [self setupSubView];
        [self setupSubViewFrame];
    }
    return self;
}


- (void)setupSubView {
    for (NSInteger index = 0; index < kImageViewCount; index ++) {
        UIImageView *imageViwe = [[UIImageView alloc] init];
        // 添加单击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGestureClick:)];
        imageViwe.gestureRecognizers = @[tapGesture];
        imageViwe.tag = index;
        imageViwe.userInteractionEnabled = YES;
        [self addSubview:imageViwe];
        
        UIImageView *gifView = [[UIImageView alloc] init];
        [imageViwe addSubview:gifView];
        gifView.image = [UIImage imageNamed:@"timeline_image_gif"];
        gifView.hidden = YES;
    }
}

- (void)imageTapGestureClick:(UITapGestureRecognizer *)tapgesture {
    // 传一个字典出去吧  再添加一个元素，把当前点击的imageView传出去，利用这个imageView做过度视图
    // 那么这样就不用传tag出去了因为imageView本来就有tag
    NSDictionary *dic = @{@"picUrls" : self.picUrls,@"didClickImageView":(UIImageView *)tapgesture.view};
    
    // 用代理传出去不好，用block吧block传不出去给控制器 ,通知吧
    [[NSNotificationCenter defaultCenter] postNotificationName:kPhotoViewImageViewTapGestureNotification object:dic];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSLog(@"%s",__func__);
}

- (void)setupSubViewFrame {
   for (NSInteger index = 0; index < kImageViewCount; index ++) {
       UIImageView *imageViwe = self.subviews[index];
       imageViwe.contentMode = UIViewContentModeScaleToFill;
       CGFloat imageViewX = index % 3 * (kMargin + kImageWidth);
       CGFloat imageViewY = index / 3 * (kMargin + kImageWidth);
       imageViwe.frame = CGRectMake(imageViewX, imageViewY, kImageWidth, kImageWidth);
       UIImageView *gif = [imageViwe.subviews lastObject];
       gif.frame = CGRectMake(kImageWidth - kGifW, kImageWidth - kGifH, kGifW, kGifH);
       
   }
}

- (void)setPicUrls:(NSArray *)picUrls {
    _picUrls = picUrls;
    NSInteger count = picUrls.count;
    // 如果都不在则全部隐藏
    for (NSInteger index = 0; index < kImageViewCount; index ++) {
        UIImageView *imageView = self.subviews[index];
        if (index < count) {
            NSString *imagePath = picUrls[index];
            // 如果有gif就让gifView显示如果没有就不显示
            if ([imagePath hasSuffix:@"gif"]) {
                [imageView.subviews lastObject].hidden = NO;
            } else {
                [imageView.subviews lastObject].hidden = YES;
            }
            // 加载图片
            [imageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
            imageView.hidden = NO;
        } else {
            imageView.hidden = YES;
        }
    }
}
// 计算行高
- (CGSize)countSize {
    CGFloat count = _picUrls.count;
    if (count == 0) {
        return CGSizeZero;
    } else if (count == 1) {
        return CGSizeMake(kImageWidth, kImageWidth);
    } else if  (count == 4) {
        return CGSizeMake((kImageWidth + kMargin) * 2, (kImageWidth + kMargin) * 2);
    } else {
        // 行数
        NSInteger row = (count - 1) / 3 + 1;
        // 高度
        NSInteger height = row * kImageWidth + kMargin * (row - 1);
        // 宽度按
        NSInteger width = count == 2? (kMargin +2 * kImageWidth): (3 * kImageWidth + 2 * kMargin);
        return CGSizeMake(width, height);
    }
}


@end

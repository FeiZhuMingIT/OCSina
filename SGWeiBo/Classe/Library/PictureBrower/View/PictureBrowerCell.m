//
//  PictureBrowerCell.m
//  PictureBrowser
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "PictureBrowerCell.h"
#define kPictureBrowerCellIdentifier @"PictureBrowerCellIdentifier"

@interface PictureBrowerCell()<UIScrollViewDelegate>

@property(nonatomic,weak) UIScrollView *scrollerView;


@end

@implementation PictureBrowerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubView];
    }
    return self;
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath {
    PictureBrowerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPictureBrowerCellIdentifier forIndexPath:indexPath];
    [cell resetProperties];
    
    return cell;
}
#pragma mark - 清除属性防止复用
- (void)resetProperties {
    self.imageView.transform = CGAffineTransformIdentity;
    
    self.scrollerView.contentInset = UIEdgeInsetsZero;
    self.scrollerView.contentOffset = CGPointZero;

}
// 在collectionView上面添加一个UIScrollView
- (void)setupSubView {
    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    scrollerView.userInteractionEnabled = YES;
    scrollerView.bounces = YES;
    scrollerView.maximumZoomScale = 2;
    scrollerView.minimumZoomScale = 0.5;
    scrollerView.delegate = self;
    [self addSubview:scrollerView];
    self.scrollerView = scrollerView;
    
    // 给scollerView里面添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.scrollerView.bounds;
    imageView.userInteractionEnabled = YES;
    [self.scrollerView addSubview:imageView];
    self.imageView = imageView;

}

#pragma mark - 图片拉伸的方法
- (void)scaleImage:(UIImage *)image {
    self.imageView.image = image;
    // 就算图片没有这么大也要拉伸到这么大
    CGFloat width = kScreenWidth;
    CGFloat height = image.size.height / image.size.width * width;

    if (height > kScreenHeight) {
        self.imageView.frame = CGRectMake(0, 0, width, height);
        self.scrollerView.contentSize = CGSizeMake(width, height);
        self.scrollerView.bounces = YES;
    } else {
        // 这里不能用frame因为用frame会很坑爹，只能让scrollerView的约束防止它乱走
        self.imageView.frame = CGRectMake(0, 0, width, height);
        self.scrollerView.contentInset = UIEdgeInsetsMake( 0.5 * (kScreenHeight - height), 0,  0.5 * (kScreenHeight - height), 0);
        self.scrollerView.bounces = NO;
    }
}
#pragma mark - ScrollView代理方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}
// 缩放时调用

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"缩放时");
}

// 缩放后调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"缩放结束");
    CGFloat offerY = (self.scrollerView.bounds.size.height- self.imageView.frame.size.height) * 0.5;
    CGFloat offerX = (self.scrollerView.bounds.size.width - self.imageView.frame.size.width ) * 0.5;
    // 目的就是不让它出去，一出去了就拖动不动了
    if (offerY < 0) {
        offerY = 0;
    }
    if (offerX < 0) {
        offerX = 0;
    }
    [UIView animateWithDuration:0.25 animations:^{
        NSLog(@"%lf",offerY);
     
        // 设置scrollView的contentInset来居中图片
//        self.imageView.frame = CGRectMake(offerX, offerY, kScreenWidth - 2 * offerX, kScreenHeight - 2 * offerY);
        self.scrollerView.contentInset = UIEdgeInsetsMake(offerY, offerX, offerY, offerX);
//        self.scrollerView.contentOffset = CGPointMake(offerX, offerY);
           NSLog(@"%@",NSStringFromCGRect(self.imageView.frame));
        NSLog(@"%@",NSStringFromCGRect(self.scrollerView.frame));
    }];
}

#pragma mark - set & get
- (void)setLargeString:(NSString *)largeString {
    _largeString = largeString;
    [SVProgressHUD showWithStatus:@"正在加载图片" maskType:SVProgressHUDMaskTypeBlack];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:largeString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if  (error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"图片加载出错"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                return ;
            });
        }
        [SVProgressHUD dismiss];
        [self scaleImage:image];
    }];
}






@end



























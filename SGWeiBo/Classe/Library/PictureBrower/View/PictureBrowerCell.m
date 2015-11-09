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

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath {
    PictureBrowerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPictureBrowerCellIdentifier forIndexPath:indexPath];
    [cell setupSubView];
    return cell;
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
        self.imageView.frame = CGRectMake(0, 0.5 * (kScreenHeight - height), width, height);
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
//    // 缩放结束后要拿到frame值，让它回到中间
//    CGRect rect = view.frame;
//    CGFloat viewW = rect.size.width;
//    CGFloat viewH = rect.size.height;
//    CGFloat viewX = 0.5 * (kScreenWidth - viewW);
//    CGFloat viewY = 0.5 * (kScreenHeight - viewH);
//    [UIView animateWithDuration:0.5 animations:^{
//        view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
//        view.bounds = CGRectMake(0, 0, viewW, viewH);
//    }];
//    NSLog(@"%@",NSStringFromCGRect(CGRectMake(viewX, viewY, viewW, viewH)));
    
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



























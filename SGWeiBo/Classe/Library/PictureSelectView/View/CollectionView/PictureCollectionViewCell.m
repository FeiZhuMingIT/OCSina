//
//  PictureCollectionViewCell.m
//  PictureSelectView
//
//  Created by pkxing on 15/11/8.
//  Copyright © 2015年 晓志. All rights reserved.
//

#import "PictureCollectionViewCell.h"
#import "UIButton+Extension.h"
#define kPictureCollectionViewCellIdentifier @"pictureCollectionViewCellIdentifier"
#define kPictureCollectionViewCellDefaultBtnDidClickNotification @"PictureCollectionViewCellDefaultBtnDidClickNotification"
#define kDeleteImageWidth 24
#define kPitureCollectionViewCellWidth 90
@interface PictureCollectionViewCell()

@property(nonatomic,weak) UIButton *defaultBtn;

@property(nonatomic,weak) UIButton *deleteBtn;

@property(nonatomic,weak) UIImageView *pictureImageView;

@end

@implementation PictureCollectionViewCell


// 写在init方法里面将不会调用，所以写在这个方法里边
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
         [self setupSubView];
    }
    return self;
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView WithIndexPath:(NSIndexPath *)indexPath {
    
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPictureCollectionViewCellIdentifier forIndexPath:indexPath];
    
    return cell;
}


// 三个子控件， 按钮，图片，默认图片,独立事件应该放在一起  并且一起设frame值
- (void)setupSubView {
    
    UIButton *defaultBtn = [UIButton buttonWIthBgNorImage:@"compose_pic_add" WithHeilight:@"compose_pic_add_highlighted" WithFram:CGRectMake(0, 0, 90, 90)];
    
    [self addSubview:defaultBtn];
    
    [defaultBtn addTarget:self action:@selector(addImageWithPictureSelect) forControlEvents:UIControlEventTouchUpInside];
    // 为什么？？？ 给默认颜色就会把后面的图片给遮住，不给就不会让它变为nil??
    defaultBtn.backgroundColor = [UIColor grayColor];
    self.defaultBtn = defaultBtn;
    
    // 图片
    UIImageView *pictureImageView = [[UIImageView alloc]init];
    
    pictureImageView.frame = CGRectMake(0, 0, kPitureCollectionViewCellWidth, kPitureCollectionViewCellWidth);
    //  设置图片的显示模式
    pictureImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:pictureImageView];
    self.pictureImageView = pictureImageView;
    
    // deleteBtn
    UIButton *deleteBtn = [UIButton buttonWIthBgNorImage:@"compose_photo_close" WithHeilight:@"compose_photo_close" WithFram:CGRectMake(kPitureCollectionViewCellWidth - kDeleteImageWidth, 0, kDeleteImageWidth, kDeleteImageWidth)];
    
    [self addSubview:deleteBtn];
    
    [deleteBtn addTarget:self action:@selector(deletePicture) forControlEvents:UIControlEventTouchUpInside];
    
    self.deleteBtn = deleteBtn;
}


- (void)addImageWithPictureSelect {
    
    // 如果点击的是已经有图片的cell那么就不需要进行下面的事件了

        [[NSNotificationCenter defaultCenter] postNotificationName:kPictureCollectionViewCellDefaultBtnDidClickNotification object:self];
    // 改需求，如果是点击的是已经有图片的cell那么就替换那张图片
    // 发布一个通知告诉cell它被点击了？ 代理吧
    
}


#pragma mark 用一个代理传出去
- (void)deletePicture {
    // 如果是选择器的x那就什么都不做
    if (self.image == nil) {
        NSLog(@"return了回去");
        return;
    }
    // 这个是应该让view去删除然后刷新 用一个代理传出去
    if ([self.delegate respondsToSelector:@selector(pictureCollectionViewCell:DeleteBtnClick:)]) {
        [self.delegate pictureCollectionViewCell:self DeleteBtnClick:self.deleteBtn];
    }
}

#pragma mark - UIImagePickerController代理方法


#pragma mark - set&get
- (void)setImage:(UIImage *)image {
    _image = image;
    self.pictureImageView.image = image;
}




@end

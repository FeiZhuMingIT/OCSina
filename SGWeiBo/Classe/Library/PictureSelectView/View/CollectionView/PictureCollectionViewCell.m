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

// 默认按钮
@property(nonatomic,weak) UIButton *defaultBtn;

// 删除按钮
@property(nonatomic,weak) UIButton *deleteBtn;

// 图片按钮
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


// 添加子控件，设置子控件frame
- (void)setupSubView {
    
    //添加默认按钮
    UIButton *defaultBtn = [UIButton buttonWIthBgNorImage:@"compose_pic_add" WithHeilight:@"compose_pic_add_highlighted" WithFram:CGRectMake(0, 0, 90, 90)];
    
    [self addSubview:defaultBtn];
    
    [defaultBtn addTarget:self action:@selector(addImageWithPictureSelect) forControlEvents:UIControlEventTouchUpInside];
    
    // 把它给遮住
    defaultBtn.backgroundColor = [UIColor grayColor];
    self.defaultBtn = defaultBtn;
    
    // 图片
    UIImageView *pictureImageView = [[UIImageView alloc]init];
    
    pictureImageView.frame = CGRectMake(0, 0, kPitureCollectionViewCellWidth, kPitureCollectionViewCellWidth);
    
    //  设置图片的显示模式
    pictureImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview:pictureImageView];
    
    self.pictureImageView = pictureImageView;
    
    // 删除按钮
    UIButton *deleteBtn = [UIButton buttonWIthBgNorImage:@"compose_photo_close" WithHeilight:@"compose_photo_close" WithFram:CGRectMake(kPitureCollectionViewCellWidth - kDeleteImageWidth, 0, kDeleteImageWidth, kDeleteImageWidth)];
    
    [self addSubview:deleteBtn];
    
    [deleteBtn addTarget:self action:@selector(deletePicture) forControlEvents:UIControlEventTouchUpInside];
    
    self.deleteBtn = deleteBtn;
}

#pragma mark - 添加图片
- (void)addImageWithPictureSelect {
    
    // 发出通知给控制器，添加图片或者修改图片
    [[NSNotificationCenter defaultCenter] postNotificationName:kPictureCollectionViewCellDefaultBtnDidClickNotification object:self];
}

#pragma mark 用一个代理传出去
- (void)deletePicture {
    
    // 如果没有图片就直接返回
    if (self.image == nil) {
        NSLog(@"return了回去");
        return;
    }
    
    // 删除了一个view所以要重新布局
    if ([self.delegate respondsToSelector:@selector(pictureCollectionViewCell:DeleteBtnClick:)]) {
        [self.delegate pictureCollectionViewCell:self DeleteBtnClick:self.deleteBtn];
    }
}

#pragma mark - set&get
- (void)setImage:(UIImage *)image {
    _image = image;
    self.pictureImageView.image = image;
}


@end

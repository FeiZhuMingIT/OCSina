//
//  SGCollectionViewCell.m
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface SGCollectionViewCell()
@property (nonatomic,weak)UIImageView * imageView;
@end

@implementation SGCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath {
    SGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    [cell setupSubView];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (void)setupSubView {
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.frame = self.bounds;
    [self addSubview:imageView];
}


- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

@end

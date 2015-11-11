//
//  SGPhotoModel.h
//  SGWeiBo
//
//  Created by pkxing on 15/11/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGPhotoModel : NSObject

// 大图url
@property(nonatomic,copy) NSString *url;

// 大图image
@property(nonatomic,strong) UIImageView *imageView;
@end

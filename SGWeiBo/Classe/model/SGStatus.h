//
//  SGStatus.h
//  SGWeiBo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGUser.h"
@interface SGStatus : NSObject
@property (nonatomic,strong)NSString * created_at;
@property (nonatomic,strong)NSString * idstr;
@property (nonatomic,strong)NSString * text;
@property (nonatomic,strong)NSString * source;
@property (nonatomic,strong)NSString * pic_urls;
@property (nonatomic,strong)SGUser * user;

@end

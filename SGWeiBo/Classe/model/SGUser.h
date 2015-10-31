//
//  SGUser.h
//  SGWeiBo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SGUser : NSObject
// 字符串型的用户UID
@property (nonatomic,strong)NSString * idstr;
// 友好显示名称
@property (nonatomic,strong)NSString * name;
// 用户头像地址（中图）,50 * 50
@property (nonatomic,strong)NSString * profile_image_url;
// 没有认证 -1 ，认证用户: 0 企业认证:2,3,5 达人: 220
@property (nonatomic,assign)NSInteger  verified_type;
// 会员等级mbrank
@property (nonatomic,assign)NSInteger  mbrank;
// 根据不同会员配置不同图片
@property (nonatomic,strong,readonly)UIImage * mbrankImage;

-(instancetype)initWithDiction:(NSDictionary *)dic;
+(instancetype)userWithDiction:(NSDictionary *)dic;

// 自己实现了这个方法当没找到的时候就不会报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end

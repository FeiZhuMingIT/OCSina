//
//  SGUser.m
//  SGWeiBo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SGUser.h"

@implementation SGUser

-(instancetype)initWithDiction:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)userWithDiction:(NSDictionary *)dic
{
    return [[self alloc] initWithDiction:dic];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}


#pragma mark - set && get
-(void)setMbrank:(NSInteger)mbrank {
    _mbrank = mbrank;
    _mbrankImage = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%ld",mbrank]];
}
// 对象打印
- (NSString *)description {
    [super description];
    NSArray *descriptionDic = @[@"idstr", @"name", @"profile_image_url", @"verified_type", @"mbrank"];
    // 把数组的值全部打印出来
    return [NSString stringWithFormat:@"%@",[self dictionaryWithValuesForKeys:descriptionDic]];
}


- (void)setVerified_type:(NSInteger)verified_type
{
    // 根据用户的  status.user.verified_type来判断认真图片
    _verified_type = verified_type;
        switch (verified_type) {
            case 220:
                self.verified_image = [UIImage imageNamed:@"avatar_grassroot"];
                break;
            case 1:
                self.verified_image = [UIImage imageNamed:@"avatar_vip"];
                break;
            case 2:
            case 3:
            case 5:
                self.verified_image = [UIImage imageNamed:@"avatar_enterprise_vip"];
                break;
            default:
                break;
        }
    
}


@end

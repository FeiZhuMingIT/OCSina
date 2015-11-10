//
//  SGStatus.h
//  SGWeiBo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SGUser;
@interface SGStatus : NSObject
@property (nonatomic,copy)NSString *created_at;
@property (nonatomic,copy)NSString *idstr;
@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy)NSString *source;
@property (nonatomic,strong)NSArray *pic_urls;
@property (nonatomic,assign)NSInteger  id;

// sina转化后的时间
@property(nonatomic,copy) NSString *creadtedDate;
// 文本属性转换
@property(nonatomic,readonly) NSAttributedString *attributedString;
// 图片数据字典
@property (nonatomic,strong)NSArray * picUrls;
/*
 thumbnail_pic   :	ww2.sinaimg.cn/thumbnail    /8debe637gw1exs55ik582j20cs0mtgoi.jpg
 bmiddle_pic     :	ww2.sinaimg.cn/bmiddle      /8debe637gw1exs55ik582j20cs0mtgoi.jpg
 original_pic    :	ww2.sinaimg.cn/large        /8debe637gw1exs55ik582j20cs0mtgoi.jpg
 
 geo	:	null
 
 */
// 把小图地址编程large 和bmiddle就变成了大图地址
@property(nonatomic,copy) NSArray *bmiddleStrings;
@property(nonatomic,copy) NSArray *largeStrings;
@property (nonatomic,strong)SGUser * user;

// 先模拟数据
//+ (NSArray *)loadStatusData;
+ (NSString *)getLargeURlWithpicUrl:(NSString *)picUrl;
@end

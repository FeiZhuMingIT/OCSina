//
//  SGHomeCell.h
//  SGWeiBo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SGStatus;
@interface SGHomeCell : UITableViewCell

@property (nonatomic,strong)SGStatus * status;

+ (instancetype)homeCellWithTableView:(UITableView *)tableView;
@end

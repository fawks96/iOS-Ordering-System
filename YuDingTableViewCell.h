//
//  YuDingTableViewCell.h
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuDingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumber;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

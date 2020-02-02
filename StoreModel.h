//
//  StoreModel.h
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject
@property (nonatomic,copy) NSNumber *shop_id;
@property (nonatomic,copy) NSNumber *shop_send_price;
@property (nonatomic,copy) NSNumber *shop_delivery_price;
@property (nonatomic,copy) NSNumber *distance;
@property (nonatomic,copy) NSString *shop_name;
@property (nonatomic,copy) NSString *shop_icon;
@property (nonatomic,copy) NSString *shop_avg_send_time;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end

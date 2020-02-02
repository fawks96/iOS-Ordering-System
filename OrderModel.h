//
//  OrderModel.h
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
@property (nonatomic,copy) NSString *orderName;
@property (nonatomic,copy) NSString *orderPrice;
@property (nonatomic,copy) NSString *orderNumber;

@property (nonatomic,copy) NSString *foodID;
@end

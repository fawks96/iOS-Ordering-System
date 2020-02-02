//
//  UserModel.h
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *headimage;
//@property (nonatomic,copy) NSString *headimage;
@property (nonatomic,copy) NSString *lastactivity;
@end

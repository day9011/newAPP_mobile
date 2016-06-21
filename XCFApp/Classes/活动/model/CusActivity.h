//
//  CusActivity.h
//  TFApp
//
//  Created by qujingkun on 16/6/15.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CusActivity : NSObject
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *theme;
@property(nonatomic,copy)NSString *abstract;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *adress;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *detailurl;
@property(nonatomic,assign)bool hasJoin;
@end

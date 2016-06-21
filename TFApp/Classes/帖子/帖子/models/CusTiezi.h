//
//  CusTiezi.h
//  TFApp
//
//  Created by qujingkun on 16/6/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface CusTiezi : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *abstract;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *commit_time;
@property(nonatomic,assign)int ID;
-(NSComparisonResult)compareTiezi:(CusTiezi *)tiezi;
@end

//
//  CusTiezi.m
//  TFApp
//
//  Created by qujingkun on 16/6/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "CusTiezi.h"

@implementation CusTiezi
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
//自定义排序方法
-(BOOL)compareForName:(CusTiezi *)other{
    if (self.ID>other.ID) {
        return YES;
    }else{
        return NO;
    }
}
@end

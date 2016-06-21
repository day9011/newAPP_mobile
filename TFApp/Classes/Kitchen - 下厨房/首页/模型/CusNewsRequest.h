//
//  CusNewsRequest.h
//  自己的百思
//
//  Created by qujingkun on 16/3/29.
//  Copyright © 2016年 USTC. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlock)(id returnValue);
typedef void(^FailureBlock)(NSError *error);
@interface CusNewsRequest : NSObject
+(void)requestWithSucessBlock:(SuccessBlock)suceessBlock FailureBlock:(FailureBlock)failureBlock Page:(NSUInteger)page;
@end

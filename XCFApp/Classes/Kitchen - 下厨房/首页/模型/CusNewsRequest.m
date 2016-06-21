//
//  CusNewsRequest.m
//  自己的百思
//
//  Created by qujingkun on 16/3/29.
//  Copyright © 2016年 USTC. All rights reserved.
//

#import "CusNewsRequest.h"
#import <AFNetworking.h>
static NSString * const kNewsRequestUrl=@"http://121.42.145.214:8888/news-abstract";
//http://121.42.145.214:8888/news-num?cursor=10&num=6
@implementation CusNewsRequest
+(void)requestWithSucessBlock:(SuccessBlock)suceessBlock FailureBlock:(FailureBlock)failureBlock Page:(NSUInteger)page{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:kNewsRequestUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        suceessBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    }
@end

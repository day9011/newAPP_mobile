//
//  CusNewsRequest.m
//  自己的百思
//
//  Created by qujingkun on 16/3/29.
//  Copyright © 2016年 USTC. All rights reserved.
//

#import "CusNewsRequest.h"
#import "AFHTTPRequestOperationManager.h"
static NSString * const kNewsRequestUrl=@"http://121.42.145.214:8888/news-abstract";
@implementation CusNewsRequest
+(void)requestWithSucessBlock:(SuccessBlock)suceessBlock FailureBlock:(FailureBlock)failureBlock Page:(NSUInteger)page{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:kNewsRequestUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        suceessBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
@end

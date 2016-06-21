

#import <Foundation/Foundation.h>
@class XCFAuthorDetail;

@interface XCFMyInfo : NSObject

+ (XCFAuthorDetail *)info;
+ (void)updateInfoWithNewInfo:(XCFAuthorDetail *)info;
+(void)clear;
+ (BOOL)isLogin;
@end


#import "XCFMyInfo.h"
#import "XCFAuthorDetail.h"

@implementation XCFMyInfo

static XCFAuthorDetail *_myInfo;
static NSString *const kMyInfo = @"myInfo";
+ (BOOL)isLogin{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kMyInfo];
    _myInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
   return  _myInfo==nil ? NO:YES;
}
+ (XCFAuthorDetail *)info {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kMyInfo];
    _myInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (!_myInfo) {
       
            _myInfo = [[XCFAuthorDetail alloc]init];
    }
    return _myInfo;
}

+ (void)updateInfoWithNewInfo:(XCFAuthorDetail *)info {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:info];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kMyInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)clear{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kMyInfo];
}
@end

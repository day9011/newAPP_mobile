
#import <Foundation/Foundation.h>
@class XCFCity;

@interface XCFLocation : NSObject
@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *province_id;
@property (nonatomic, strong) NSArray<XCFCity *> *cities;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)locationWithDict:(NSDictionary *)dict;

@end

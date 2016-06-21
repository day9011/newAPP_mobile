

#import <Foundation/Foundation.h>

@interface XCFCity : NSObject
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *city_id;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cityWithDict:(NSDictionary *)dict;

@end

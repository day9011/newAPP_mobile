

#import "XCFCity.h"

@implementation XCFCity

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)cityWithDict:(NSDictionary *)dict {
    return [[XCFCity alloc] initWithDict:dict];
}

@end

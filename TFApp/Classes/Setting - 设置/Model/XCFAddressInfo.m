

#import "XCFAddressInfo.h"

@implementation XCFAddressInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_state          forKey:@"state"];
    [aCoder encodeObject:_name            forKey:@"name"];
    [aCoder encodeObject:_phone           forKey:@"phone"];
    [aCoder encodeObject:_province        forKey:@"province"];
    [aCoder encodeObject:_detailAddress   forKey:@"detailAddress"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.state           = [decoder decodeIntegerForKey:@"state"];
        self.name            = [decoder decodeObjectForKey:@"name"];
        self.phone           = [decoder decodeObjectForKey:@"phone"];
        self.province        = [decoder decodeObjectForKey:@"province"];
        self.detailAddress   = [decoder decodeObjectForKey:@"detailAddress"];
    }
    return self;
}

@end

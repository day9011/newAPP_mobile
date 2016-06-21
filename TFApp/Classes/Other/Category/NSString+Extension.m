
#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)getSizeWithTextSize:(CGSize)size fontSize:(CGFloat)fontSize {
    CGSize resultSize = [self boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}
                                           context:nil].size;
    return resultSize;
}

@end



typedef NS_ENUM(NSInteger, XCFAddressInfoCellState) {
    XCFAddressInfoCellStateNone,
    XCFAddressInfoCellStateSelected
};

#import <Foundation/Foundation.h>

@interface XCFAddressInfo : NSObject <NSCoding>

@property (nonatomic, assign) XCFAddressInfoCellState state;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *detailAddress;

@end

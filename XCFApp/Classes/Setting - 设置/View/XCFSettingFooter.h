//
//  XCFSettingFooter.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFSettingFooter : UIView
@property(nonatomic,copy)void (^signUpBlock)();
-(void)refreshBtn;
@end

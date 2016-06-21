//
//  XCFSearchViewHeader.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFSearchViewHeader.h"
#import <Masonry.h>


@implementation XCFSearchViewHeader
//重写init方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        //添加最近搜索文本框
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = XCFLabelColorGray;
        titleLabel.text = @"最近搜索";
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(15);
            make.centerY.equalTo(view);
        }];
        //添加清除按钮
        UIButton *clearAllButton = [[UIButton alloc] init];
        [clearAllButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [clearAllButton addTarget:self
                           action:@selector(clearAllSearchHistory)
                 forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:clearAllButton];
        [clearAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.equalTo(view).offset(-20);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    return self;
}
//点击清除按钮 block存在，执行block
- (void)clearAllSearchHistory {
    self.clearBlock ? self.clearBlock():nil;
}

@end

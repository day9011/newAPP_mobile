//
//  XCFSearchViewFooter.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFSearchViewFooter.h"
#import <Masonry.h>

@interface XCFSearchViewFooter ()
@property (nonatomic, strong) UIView *buttonView; // 按钮数组
@end

@implementation XCFSearchViewFooter

static NSInteger const kButtonCount = 9;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //流行搜索view
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(30));
        }];
        //流行搜索label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = XCFLabelColorGray;
        titleLabel.text = @"流行搜索";
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(15);
            make.centerY.equalTo(view);
        }];
        //按钮view
        _buttonView = [[UIView alloc] init];
        _buttonView.backgroundColor = XCFGlobalBackgroundColor;
        [self addSubview:_buttonView];
        [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(view.mas_bottom);
            make.height.equalTo(@(120));
        }];
        
        NSInteger lineCount = 3;
        CGFloat width = (XCFScreenWidth-2) / lineCount;
        CGFloat height = (120-3) / lineCount;
        
        CGFloat margin = 1;
        CGFloat x = 0;
        CGFloat y = 0;
        
        for (NSInteger index=0; index<kButtonCount; index++) {
            //取得button对应的行数
            NSInteger line = index / lineCount;
            //取得button对应的列数
            NSInteger colunms = index % lineCount;
            //算出x和y值
            x = (width + margin) * colunms;
            y = margin + (height + margin) * line;
            
            UIButton *button = [[UIButton alloc] init];
            button.frame = CGRectMake(x, y, width, height);
            button.backgroundColor = [UIColor whiteColor];
            button.tag = index;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonView addSubview:button];
            [button addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}
//点击按钮，执行block
- (void)search:(UIButton *)sender {
    !self.searchCallBack ? : self.searchCallBack(sender.tag);
}
/**
 *  重写keywords的set方法
 *
 *  @param keywords 关键词
 */
- (void)setKeywords:(NSArray *)keywords {
    _keywords = keywords;
    //重新设置button的文字
    for (NSInteger index=0; index<kButtonCount; index++) {
        UIButton *button = self.buttonView.subviews[index];
        [button setTitle:keywords[index] forState:UIControlStateNormal];
    }
}

@end

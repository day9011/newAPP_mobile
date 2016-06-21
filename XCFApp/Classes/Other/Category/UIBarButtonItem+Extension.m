//
//  UIBarButtonItem+Extension.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/9.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
//#import "XCFCartIcon.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)barButtonLeftItemWithImageName:(NSString *)imageName
                                        target:(id)target
                                        action:(SEL)action {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

+ (instancetype)barButtonRightItemWithImageName:(NSString *)imageName
                                         target:(id)target
                                         action:(SEL)action {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 22)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 28, 0, 0);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
    
}
/**
 *  自定义barButtonItem 文字＋图标
 *
 *  @param imageName       图标
 *  @param imageEdgeInsets 图标的内部inset
 *  @param target          监听对象
 *  @param action          动作
 *
 *  @return UIBarButtonItem
 */
+ (instancetype)barButtonItemWithImageName:(NSString *)imageName
                           imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
                                    target:(id)target
                                    action:(SEL)action {
    //1 创建一个按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
    //2 设置按钮相关属性
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    /*typedef struct {
        CGFloat top, left, bottom, right;
    } UIEdgeInsets;
    */
    //3 调整按钮图标位置
    button.imageEdgeInsets = imageEdgeInsets;
    //4 用button创建UIBarButtonItem
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    //5 返回
    return barButtonItem;
}
/**
 *  自定义barButtonItem 只有文字
 *
 *  @param title  文字
 *  @param target 监听对象
 *  @param action 动作
 *
 *  @return UIBarButtonItem
 */
+ (instancetype)barButtonItemWithTitle:(NSString *)title
                                target:(id)target
                                action:(SEL)action {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button setTitleColor:XCFThemeColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}
/**
 *  自定义barButtonItem 只有文字（点击会切换文字)
 *
 *  @param title  文字
 *  @param selTitle  按钮选中时的文字
 *  @param target 监听对象
 *  @param action 动作
 *
 *  @return UIBarButtonItem
 */
+ (instancetype)barButtonItemWithTitle:(NSString *)title
                         selectedTitle:(NSString *)selTitle
                                target:(id)target
                                action:(SEL)action {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [button setTitleColor:XCFThemeColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selTitle forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

@end

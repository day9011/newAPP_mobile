//
//  XCFTabBarController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTabBarController.h"
#import "XCFNavigationController.h"
#import "TieziController.h"
#import "ActivityController.h"

#import "XCFCommunityViewController.h"
#import "XCFMeController.h"
#import "CusNewsController.h"
#import "XCFSettingViewController.h"
@interface XCFTabBarController ()

@end

@implementation XCFTabBarController
//设置tabbar的相关属性
+ (void)initialize {
    //未选中时的颜色
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    normalAttrs[NSForegroundColorAttributeName] = XCFTabBarNormalColor;
    //选中时的颜色
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = XCFThemeColor;
    //拿到appearance
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [self setupChildViewController:[[CusNewsController alloc] init]
                             title:@"首页"
                             image:@"tabADeselected"
                     selectedImage:@"tabASelected"];
    [self setupChildViewController:[[TieziController alloc] init]
                             title:@"论坛"
                             image:@"tabBDeselected"
                     selectedImage:@"tabBSelected"];
    [self setupChildViewController:[[ActivityController alloc] init]
                             title:@"活动"
                             image:@"tabCDeselected"
                     selectedImage:@"tabCSelected"];
    [self setupChildViewController:[[XCFSettingViewController alloc] init]
                             title:@"我"
                             image:@"tabDDeselected"
                     selectedImage:@"tabDSelected"];
}
/**
 *  自定义子控制器
 *
 *  @param childController 子控制器
 *  @param title           标题
 *  @param image           图标
 *  @param selectedImage   选中时的图标
 */
- (void)setupChildViewController:(UIViewController *)childController
                           title:(NSString *)title
                           image:(NSString *)image
                   selectedImage:(NSString *)selectedImage {
    childController.title = title;
    [childController.tabBarItem setImage:[UIImage imageNamed:image]];
    [childController.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    //导航控制器
    XCFNavigationController *navCon = [[XCFNavigationController alloc] initWithRootViewController:childController];
    navCon.title = title;
    
    [self addChildViewController:navCon];
}


@end

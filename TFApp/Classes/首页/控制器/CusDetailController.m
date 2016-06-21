//
//  CusDetailController.m
//  自己的百思
//
//  Created by qujingkun on 16/4/6.
//  Copyright © 2016年 USTC. All rights reserved.
//

#import "CusDetailController.h"

@interface CusDetailController ()<UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;

@end

@implementation CusDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.webView.delegate=self;
    self.webView.scalesPageToFit=YES;
    self.webView.scrollView.bouncesZoom=NO;
    NSURL *url=[NSURL URLWithString:_urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

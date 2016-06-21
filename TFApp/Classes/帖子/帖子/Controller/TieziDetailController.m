//
//  TieziDetailController.m
//  TFApp
//
//  Created by qujingkun on 16/6/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "TieziDetailController.h"
#import "TieziMarkViewController.h"
#import "CommentTool.h"
#import "CusTiezi.h"
#import <Masonry.h>
@interface TieziDetailController ()<UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;
@property(nonatomic,weak)CommentTool *commentTool;

@end

@implementation TieziDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    //self.automaticallyAdjustsScrollViewInsets=NO;
    self.webView.delegate=self;
    self.webView.scalesPageToFit=YES;
    self.webView.scrollView.bouncesZoom=NO;
    NSURL *url=[NSURL URLWithString:_urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self setupSubViews];
    [self setupNavigationBars];

}

-(void)setupNavigationBars{
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithTitle:@"评论" target:self action:@selector(mark)];
}
-(void)mark{
    TieziMarkViewController *desvc=[[TieziMarkViewController alloc]init];
    desvc.topic_id=self.topic_id;
    [self.navigationController pushViewController:desvc animated:YES];
}
-(void)setupSubViews{
//    CommentTool *commentTool=[[[NSBundle mainBundle]loadNibNamed:@"CommentTool" owner:nil options:nil]lastObject];
//    
//    self.commentTool=commentTool;
//    commentTool.editBlock=^{
//        TieziMarkViewController *desvc=[[TieziMarkViewController alloc]init];
//        desvc.topic_id=self.topic_id;
//        [self.navigationController pushViewController:desvc animated:YES];
//    };
//    [self.view insertSubview:commentTool aboveSubview:self.webView];
//    [self.commentTool mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.right.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//        make.height.mas_equalTo(60);
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.webView reload];
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

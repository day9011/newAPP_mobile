//
//  AvtivityDetailController.m
//  TFApp
//
//  Created by qujingkun on 16/6/15.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "AvtivityDetailController.h"
#import <Masonry.h>
@interface AvtivityDetailController ()<UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;
@property(nonatomic,weak)UIButton *joinButton;
@property(nonatomic,assign)bool hasJoin;
@end

@implementation AvtivityDetailController
-(UIButton *)joinButton{
    if (!_joinButton) {
        UIButton *joinbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.joinButton=joinbtn;
        [self.view insertSubview:self.joinButton aboveSubview:self.webView];
        //[self.joinButton setTitle:@"我要参加" forState:UIControlStateNormal];
        [self.joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.joinButton setBackgroundColor:[UIColor orangeColor]];
        [self.joinButton addTarget:self action:@selector(joinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinButton;
}
-(void)refreshBtn{
    if (self.hasJoin) {
        [self.joinButton setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        [self.joinButton setTitle:@"我要参加" forState:UIControlStateNormal];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasJoin=NO;
//    [[NSUserDefaults standardUserDefaults] setBool:self.hasJoin forKey:self.urlString];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    self.webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    //self.automaticallyAdjustsScrollViewInsets=NO;
    self.webView.delegate=self;
    self.webView.scalesPageToFit=YES;
    self.webView.scrollView.bouncesZoom=NO;
    NSRange range = [_urlString rangeOfString:@"huodong"];//查找子串，找不到返回NSNotFound 找到返回location和length
    
    if (range.location != NSNotFound) {
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index"
                                                              ofType:@"html"];
        NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                        encoding:NSUTF8StringEncoding
                                                           error:nil];
        [self.webView loadHTMLString:htmlCont baseURL:baseURL];
        
    }else{
        NSURL *url=[NSURL URLWithString:_urlString];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view).offset(-10);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    self.hasJoin=[[NSUserDefaults standardUserDefaults] boolForKey:self.urlString];
    if (self.hasJoin==0) {
        self.hasJoin=NO;
    }
    [self refreshBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)joinButtonClick{
    self.hasJoin=!self.hasJoin;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.joinButton.transform=CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        self.joinButton.transform=CGAffineTransformIdentity;
    }];
    [self refreshBtn];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setBool:self.hasJoin forKey:self.urlString];
    [[NSUserDefaults standardUserDefaults] synchronize];
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

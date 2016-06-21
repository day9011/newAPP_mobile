//
//  TieziMarkViewController.m
//  TFApp
//
//  Created by qujingkun on 16/6/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "TieziMarkViewController.h"
#import "XCFMyInfo.h"
#import "XCFAuthorDetail.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
static NSString *const kSendMarkUrl = @"http://121.42.145.214:8888/comment-post";
@interface TieziMarkViewController ()<UITextViewDelegate>
@property(nonatomic,weak)UITextView *editView;
@property(nonatomic,strong) AFHTTPSessionManager *mananger;

@end

@implementation TieziMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupSubViews];
    self.view.backgroundColor=[UIColor whiteColor];

}

- (void)setupNavigationBar {
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"发送" target:self action:@selector(send)];
}
-(void)setupSubViews{
    __weak typeof (self) weakSelf = self;
    
    UITextView *editView=[[UITextView alloc]init];
    editView.font=[UIFont systemFontOfSize:20];
    self.editView=editView;
    self.editView.delegate=self;
    [self.view addSubview:self.editView];
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.leading.equalTo(weakSelf.view).offset(5);
        make.right.equalTo(weakSelf.view).offset(-5);
    }];
    
}
-(void)send{
    if (self.editView.text==nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    if (self.editView.text.length>140) {
        [SVProgressHUD showErrorWithStatus:@"超出140字"];
        return;
    }
    XCFAuthorDetail *authorDetail = [XCFMyInfo info];
    
    NSDictionary *params=@{@"username":authorDetail.name,@"topic_id":@(self.topic_id),@"content":self.editView.text};
    [self.mananger POST:kSendMarkUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSNumber *status=responseObject[@"status"];
        if ([status compare:@(0)]==NSOrderedSame){
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.editView resignFirstResponder];
}
- (AFHTTPSessionManager *)mananger {
    if (!_mananger) {
        _mananger = [AFHTTPSessionManager manager];
    }
    return _mananger;
}
@end

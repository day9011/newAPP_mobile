//
//  EditController.m
//  TFApp
//
//  Created by qujingkun on 16/6/14.
//  Copyright © 2016年 Joey. All rights reserved.
//
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "EditController.h"
#import "XCFMyInfo.h"
#import "XCFAuthorDetail.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
static NSString *const kSendUrl = @"http://121.42.145.214:8888/topic-post";
@interface EditController()<UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,weak)UITextField *titleField;
@property(nonatomic,weak)UITextView *editView;
@property(nonatomic,strong) AFHTTPSessionManager *mananger;
@end
@implementation EditController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupSubViews];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    
}
- (void)setupNavigationBar {
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"发送" target:self action:@selector(send)];
}
-(void)setupSubViews{
    __weak typeof (self) weakSelf = self;
    UITextField *titleField=[[UITextField alloc]init];
    self.titleField=titleField;
    self.titleField.placeholder=@"主题:";
    self.titleField.delegate=self;
    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.titleField.leftViewMode = UITextFieldViewModeAlways;
    self.titleField.leftView = leftview;
    [self.view addSubview:self.titleField];
    [self.titleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.right.equalTo(weakSelf.view);
        make.top.equalTo(64);
        make.height.equalTo(44);
    }];

    UITextView *editView=[[UITextView alloc]init];
    self.editView=editView;
    self.editView.delegate=self;
    
    
    

    [self.view addSubview:self.editView];
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.titleField.mas_bottom);
    }];

}
-(void)send{
    if (self.titleField.text==nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入主题"];
        return;
    }
    if (self.editView.text==nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    if (self.editView.text.length>140) {
        [SVProgressHUD showErrorWithStatus:@"超出140字"];
        return;
    }
    XCFAuthorDetail *authorDetail = [XCFMyInfo info];
    NSDictionary *params=@{@"username":authorDetail.name,@"title":self.titleField.text,@"content":self.editView.text};
    [self.mananger POST:kSendUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

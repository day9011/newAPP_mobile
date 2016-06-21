//
//  LoginController.m
//  TFApp
//
//  Created by qujingkun on 16/5/28.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "LoginController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "XCFAuthorDetail.h"
@interface LoginController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property(nonatomic,strong) AFHTTPSessionManager *mananger;
@property (nonatomic, strong) XCFAuthorDetail *authorDetail;
@end

@implementation LoginController
static LoginController *_loginvc;
static NSString *const kLoginUrl = @"http://121.42.145.214:8888/login";
static NSString *const kRegisterUrl = @"http://121.42.145.214:8888/register";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=XCFGlobalBackgroundColor;
    [self setupNavigationbar];
    [self.pwdField addTarget:self action:@selector(enterpwd) forControlEvents:UIControlEventEditingDidBegin];
    // Do any additional setup after loading the view from its nib.
}
-(void)enterpwd{
    self.view.transform=CGAffineTransformMakeTranslation(0, -64);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(instancetype)shared{
    if (_loginvc==nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _loginvc=[[LoginController alloc]init];
        });
    }
    return _loginvc;
}
-(void)setupNavigationbar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"取消" target:self action:@selector(cancel)];
}
- (IBAction)loginClick:(id)sender {
    if (self.usernameField.text==nil || self.pwdField.text==nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入完整"];
        return;
    }
    NSDictionary *params=@{@"username":self.usernameField.text,@"password":self.pwdField.text};
    [self.mananger POST:kLoginUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject);
        NSNumber *status=responseObject[@"status"];
        if ([status compare:@(0)]==NSOrderedSame) {
            [self save];
            [self cancel];
        }else {
            [SVProgressHUD showErrorWithStatus:@"输入错误"];
            //[SVProgressHUD dismiss];
        }
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

/**
 *    注册
 *
 *  @param sender 注册按钮
 */
- (IBAction)registerClick:(id)sender {
    if (self.usernameField.text==nil || self.pwdField.text==nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入完整"];
        return;
    }

    NSDictionary *params=@{@"username":self.usernameField.text,@"password":self.pwdField.text};
    [self.mananger POST:kRegisterUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSNumber *status=responseObject[@"status"];
        if ([status compare:@(0)]==NSOrderedSame) {
            [self save];
            [self cancel];
        }else {
            [SVProgressHUD showErrorWithStatus:@"输入错误"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];


}
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [SVProgressHUD dismiss];
}
- (AFHTTPSessionManager *)mananger {
    if (!_mananger) {
        _mananger = [AFHTTPSessionManager manager];
    }
    return _mananger;
}
- (XCFAuthorDetail *)authorDetail {
    if (!_authorDetail) {
        _authorDetail = [XCFMyInfo info];
    }
    return _authorDetail;
}
- (void)save {
    self.authorDetail.name=self.usernameField.text;
    self.authorDetail.password=self.pwdField.text;
    [XCFMyInfo updateInfoWithNewInfo:self.authorDetail];
    XCFAuthorDetail *new =[XCFMyInfo info];
    [SVProgressHUD showSuccessWithStatus:@"成功"];
    [SVProgressHUD dismiss];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

@end

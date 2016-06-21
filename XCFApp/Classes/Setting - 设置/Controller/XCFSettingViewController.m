//
//  XCFSettingViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFSettingViewController.h"
#import "XCFProfileEditingController.h"
#import "ContactsController.h"
#import "XCFMyInfoCell.h"
#import "XCFSettingFooter.h"
#import "XCFAuthorDetail.h"
#import "LoginController.h"
#import "XCFNavigationController.h"
#import <Social/Social.h>
#import <AddressBook/AddressBook.h>
#import <SVProgressHUD.h>
@interface XCFSettingViewController ()
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) XCFAuthorDetail *authorDetail;
@property(nonatomic,weak)XCFSettingFooter *footer;
@end

@implementation XCFSettingViewController

static NSString *const myInfoCellIdentifier = @"myInfoCellIdentifier";
static NSString *const normalCellIdentifier = @"normalCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupTableViewFooter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.authorDetail = [XCFMyInfo info];
    [self.tableView reloadData];
    [self.footer refreshBtn];
}


#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        XCFMyInfoCell *myInfoCell = [tableView dequeueReusableCellWithIdentifier:myInfoCellIdentifier forIndexPath:indexPath];
        myInfoCell.authorDetail = [XCFMyInfo info];
        cell = myInfoCell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[[XCFProfileEditingController alloc] init] animated:YES];
        return;
    }
    if (indexPath.section == 1) {
        if(indexPath.row == 0){
            [self.navigationController pushViewController:[[ContactsController alloc] init] animated:YES]
;
        }else{
            [SVProgressHUD showErrorWithStatus:@"老板携款潜逃 功能不做了"];
                    }
    }
    if (indexPath.section == 2) {
        if (indexPath.row==0) {
            //分享
            [self share];
        }else{
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.apple.com/cn/iphone/"]];
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [SVProgressHUD dismiss];
}
-(void)share{
    // 首先判断新浪分享是否可用
//    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
//        return;
//    }
    // 创建控制器，并设置ServiceType
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    // 添加要分享的图片
    
    // 添加要分享的文字
    [composeVC setInitialText:@"我发现了一个好玩的应用，快来试试吧"];
    // 添加要分享的url
    [composeVC addURL:[NSURL URLWithString:@"http://baike.baidu.com/link?url=aT_wIN5txkj_DgVqi2GZYtTJVP9zjahhtXTETBwaVN-F-AcoqjQGca-_BzJAhIiBVzc5Aj3BnsikPpPVyL5_oa"]];
    // 弹出分享控制器
    [self presentViewController:composeVC animated:YES completion:nil];
    // 监听用户点击事件
    composeVC.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultDone) {
            NSLog(@"点击了发送");
        }
        else if (result == SLComposeViewControllerResultCancelled)
        {
            NSLog(@"点击了取消");
        }
        [composeVC dismissViewControllerAnimated:YES completion:nil];
    };
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    if (section == 1) return 2;
    if (section == 2) return 2;
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 60;
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}


#pragma mark - 属性
- (void)setupNavigationBar{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"登录" target:self action:@selector(login)];
}
- (void)setupTableView {
    self.title = @"设置";
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFMyInfoCell class]) bundle:nil]
         forCellReuseIdentifier:myInfoCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:normalCellIdentifier];
}

- (void)setupTableViewFooter {
    XCFSettingFooter *footer = [[XCFSettingFooter alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 100)];
    self.footer=footer;
    __weak XCFSettingViewController *weakvc=self;
    footer.signUpBlock=^{
        if ([XCFMyInfo isLogin]==NO) {
            [weakvc login];
        }else{
            UIAlertController *alertvc=[UIAlertController alertControllerWithTitle:@"确定退出吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alertvc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [XCFMyInfo clear];
                [footer refreshBtn];
                [weakvc.tableView reloadData];
                [alertvc dismissViewControllerAnimated:YES completion:nil];
            }]];
            [alertvc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [alertvc dismissViewControllerAnimated:YES completion:nil];
            }]];
            [weakvc presentViewController:alertvc animated:YES completion:nil];
        }
    };
    self.tableView.tableFooterView = footer;
}
- (void)login{
    XCFNavigationController *navvc=[[XCFNavigationController alloc]initWithRootViewController:[LoginController shared]];
    
    [self presentViewController:navvc animated:YES completion:nil];
}
- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        NSArray *section0 = @[];
        
        NSArray *section1 = @[@"发现好友", @"消息推送"];
        NSArray *section2 = @[@"告诉朋友", @"评分"];
        [_titleArray addObject:section0];
        [_titleArray addObject:section1];
        [_titleArray addObject:section2];
        
        
    }
    return _titleArray;
}

- (XCFAuthorDetail *)authorDetail {
    if (!_authorDetail) {
        _authorDetail = [XCFMyInfo info];
    }
    return _authorDetail;
}

@end

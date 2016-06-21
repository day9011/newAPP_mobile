//
//  ActivityController.m
//  TFApp
//
//  Created by qujingkun on 16/6/15.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "ActivityController.h"
#import "ActivityCell.h"
#import "AvtivityDetailController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "CusActivity.h"
#import "CusDetailController.h"
#import <SVProgressHUD.h>
@interface ActivityController ()
@property(nonatomic,strong) NSMutableArray *activitys;
@property(nonatomic,weak)XCFSearchBar *searchbar;

@end

@implementation ActivityController
-(NSMutableArray *)activitys{
    if (!_activitys) {
        _activitys=[NSMutableArray array];
    }
    return _activitys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTabelView];
    [self setupRefreshControl];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self loadNewactivitys];
}
- (void)setupNavigationBar {
    XCFSearchBar *bar=[XCFSearchBar searchBarWithPlaceholder:@"搜索活动"];
    self.searchbar=bar;
    self.navigationItem.titleView = self.searchbar;
    
    
}

/**
 *  设置tableview
 */
-(void)setupTabelView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActivityCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ActivityCell class])];
    self.tableView.rowHeight=135;
    //self.tableView.rowHeight=UITableViewAutomaticDimension;
    
}
-(void)setupRefreshControl{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewactivitys)];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreactivitys)];
    self.tableView.mj_footer.hidden=YES;
    
}
/**
 *  加载新的用户数据
 */
-(void)loadNewactivitys{
    [self.tableView.mj_footer endRefreshing];
    //发送get请求
    NSArray *dataArray=[CusActivity mj_objectArrayWithFilename:@"ActivityLists.plist"];
    [self.activitys removeAllObjects];
    [self.activitys addObjectsFromArray:dataArray];
    [self.tableView reloadData];
    [SVProgressHUD showWithStatus:@"没有更多活动"];
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.3];
    [self.tableView.mj_header endRefreshing];
    
    
}
-(void)delayMethod{
    [SVProgressHUD dismiss];
}
-(void)loadMoreactivitys{
    [self.tableView.mj_header endRefreshing];
    //发送get请求
   
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
    [SVProgressHUD showErrorWithStatus:@"没有更多活动"];
    
}

#pragma mark - Private

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count=self.activitys.count;
    self.tableView.mj_footer.hidden=count?NO:YES;
    return self.activitys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"ActivityCell";
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.activity=self.activitys[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AvtivityDetailController *detailVC=[[AvtivityDetailController alloc]init];
    CusActivity *activity=self.activitys[indexPath.row];
    detailVC.urlString=activity.detailurl;
        [self.navigationController pushViewController:detailVC animated:YES];
}

@end

//
//  TieziController.m
//  TFApp
//
//  Created by qujingkun on 16/6/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "TieziController.h"
#import "TieziCell.h"
#import "CusTiezi.h"
#import "XCFAuthorDetail.h"
#import "LoginController.h"
#import "EditController.h"
#import "MJRefresh.h"
#import "AFHTTPSessionManager.h"
#import "MJExtension.h"
#import "TieziDetailController.h"
static NSString *const kNewTieziUrl = @"http://121.42.145.214:8888/topic/list?num=10&cursor=0";
static NSString *const kMoreTieziUrl = @"http://121.42.145.214:8888/topic/list";
static NSString *const DetailUrl =@"http://121.42.145.214:8888/topic/detail/";
@interface TieziController () 
@property(nonatomic,weak)XCFSearchBar *searchBar;
@property(nonatomic,strong) NSMutableArray *tiezis;
@property(nonatomic,strong) AFHTTPSessionManager *httpManager;
@property(nonatomic,strong) NSMutableDictionary *params;
@end

@implementation TieziController
-(AFHTTPSessionManager *)httpManager{
    if (!_httpManager) {
        _httpManager=[AFHTTPSessionManager manager];
    }
    return _httpManager;
}
-(NSMutableDictionary *)params{
    if (!_params) {
        _params=[NSMutableDictionary dictionary];
    }
    return _params;
}
-(NSMutableArray *)tiezis{
    if (!_tiezis) {
        _tiezis=[NSMutableArray array];
    }
    return _tiezis;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTabelView];
    [self setupRefreshControl];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self loadNewtiezis];
}
- (void)setupNavigationBar {
    XCFSearchBar *bar=[XCFSearchBar searchBarWithPlaceholder:@"搜索帖子"];
    self.searchBar=bar;
    self.navigationItem.titleView = self.searchBar;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonRightItemWithImageName:@"addMark" target:self action:@selector(add)];
}

- (void)add {
    if ([XCFMyInfo isLogin]) {
        [self.navigationController pushViewController:[[EditController alloc]init] animated:YES];
    }else{
        [self.navigationController pushViewController:[LoginController shared] animated:YES];
    }
}
/**
 *  设置tableview
 */
-(void)setupTabelView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TieziCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TieziCell class])];
    self.tableView.estimatedRowHeight=60;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    //self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)setupRefreshControl{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewtiezis)];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoretiezis)];
    self.tableView.mj_footer.hidden=YES;
}
/**
 *  加载新的用户数据
 */
-(void)loadNewtiezis{
    [self.tableView.mj_footer endRefreshing];
    //发送get请求
    [self.httpManager GET:kNewTieziUrl
               parameters:nil
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSArray *dataArray=[CusTiezi mj_objectArrayWithKeyValuesArray:responseObject[@"topics"]];
                      [self.tiezis removeAllObjects];
                      [self.tiezis addObjectsFromArray:dataArray];
                      [self.tableView reloadData];
                      [self.tableView.mj_header endRefreshing];
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      NSLog(@"%@",error);
                      [self.tableView.mj_header endRefreshing];
                  }];
    
}
-(void)loadMoretiezis{
    [self.tableView.mj_header endRefreshing];
    NSNumber *cursor=[NSNumber numberWithInt:self.tiezis.count];
    NSNumber *num=[NSNumber numberWithInt:10];
    NSDictionary *params=@{@"curosr":cursor,@"num":num};
    //发送get请求
    [self.httpManager GET:kMoreTieziUrl
               parameters:params
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      
                      NSMutableArray *dataArray=[CusTiezi mj_objectArrayWithKeyValuesArray:responseObject[@"topics"]];
                    [self.tiezis addObjectsFromArray:dataArray];
                      [self.tableView reloadData];
                      [self.tableView.mj_footer endRefreshing];
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      NSLog(@"%@",error);
                      [self.tableView.mj_footer endRefreshing];
                  }];
    
}

#pragma mark - Private
-(void)tagClick{
    
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count=self.tiezis.count;
    self.tableView.mj_footer.hidden=count?NO:YES;
    return self.tiezis.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"TieziCell";
    TieziCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.tiezi=self.tiezis[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TieziDetailController *detailVC=[[TieziDetailController alloc]init];
    CusTiezi *tiezi=self.tiezis[indexPath.row];
    detailVC.urlString=[NSString stringWithFormat:@"%@%d",DetailUrl,tiezi.ID];
    detailVC.topic_id=tiezi.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}
@end

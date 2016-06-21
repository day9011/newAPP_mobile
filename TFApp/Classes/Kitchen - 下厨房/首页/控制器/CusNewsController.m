//
//  CusEssenceController.m
//  
//
//  Created by qujingkun on 16/2/22.
//  Copyright © 2016年 USTC. All rights reserved.
//
//16055
//bf06c7463992447ea57f4505b9cff846
#import "CusNewsController.h"
#import "CusNewsCell.h"
#import "CusNews.h"
#import "MJRefresh.h"
#import "AFHTTPSessionManager.h"
#import "MJExtension.h"

#import "CusNewsRequest.h"
#import "CusDetailController.h"
//static NSString * const kNewsRequestUrl=@"http://121.42.145.214:8888/news-abstract";
static NSString * const kNewsRequestUrl=@"http://121.42.145.214:8888/news-num?cursor=0&num=10";
static NSString * const kMoreNewsRequestUrl=@"http://121.42.145.214:8888/news-num";

@interface CusNewsController ()
@property(nonatomic,assign) NSInteger currentPage;
@property(nonatomic,assign) NSInteger totalPage;
@property(nonatomic,strong) NSMutableArray *news;
@property(nonatomic,strong) AFHTTPSessionManager *httpManager;
@property(nonatomic,strong) NSMutableDictionary *params;
@end

@implementation CusNewsController
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
-(NSMutableArray *)news{
    if (!_news) {
        _news=[NSMutableArray array];
    }
    return _news;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItems];
    [self setupTabelView];
    [self setupRefreshControl];
    [self.tableView.mj_header beginRefreshing];
    self.currentPage=1;
    
}
-(void)setupNavigationItems{
    // 设置导航栏标题
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.title=@"新闻";
    
  
}
/**
 *  设置tableview
 */
-(void)setupTabelView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CusNewsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CusNewsCell class])];
    self.tableView.estimatedRowHeight=60;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)setupRefreshControl{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.tableView.mj_footer.hidden=YES;
}
/**
 *  加载新的用户数据
 */
-(void)loadNewUsers{
    [self.tableView.mj_footer endRefreshing];
    //发送get请求
    [self.httpManager GET:kNewsRequestUrl
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSArray *dataArray=[CusNews mj_objectArrayWithKeyValuesArray:responseObject[@"news"]];
                    [self.news removeAllObjects];
                    [self.news addObjectsFromArray:dataArray];
                   [self.tableView reloadData];
                   [self.tableView.mj_header endRefreshing];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"%@",error);
                   [self.tableView.mj_header endRefreshing];
               }];

}
-(void)loadMoreUsers{
    [self.tableView.mj_header endRefreshing];
    NSNumber *cursor=[NSNumber numberWithInt:self.news.count+1];
     NSNumber *num=[NSNumber numberWithInt:10];
    NSDictionary *params=@{@"cursor":cursor,@"num":num};
    //发送get请求
    [self.httpManager GET:kMoreNewsRequestUrl
               parameters:params
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSLog(@"%@",responseObject);
                      NSArray *dataArray=[CusNews mj_objectArrayWithKeyValuesArray:responseObject[@"news"]];
                      
                      [self.news addObjectsFromArray:dataArray];
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
    NSUInteger count=self.news.count;
    self.tableView.mj_footer.hidden=count?NO:YES;
    return self.news.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"CusNewsCell";
    CusNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.news=self.news[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CusDetailController *detailVC=[[CusDetailController alloc]init];
    CusNews *news=self.news[indexPath.row];
    detailVC.urlString=news.url;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end

//
//  CusEssenceController.m
//  自己的百思
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
#import "NSString+CusTimeStamp.h"
#import "CusNewsRequest.h"
#import "CusDetailController.h"
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
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = CusGlobalBg;

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
    
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    params[@"showapi_appid"]=@"16055";
//    params[@"showapi_sign"]=@"bf06c7463992447ea57f4505b9cff846";
//    params[@"showapi_timestamp"]=[NSString timeStamp];
//    params[@"type"]=@"29";
//    self.params=params;
//    [self.httpManager GET:@"http://route.showapi.com/255-1" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSDictionary *body=responseObject[@"showapi_res_body"];
//        NSDictionary *pageBean=body[@"pagebean"];
//        //NSLog(@"%@",pageBean[@"contentlist"]);
//        NSArray *news=[CusNews mj_objectArrayWithKeyValuesArray:pageBean[@"contentlist"]];
//
//        [self.news removeAllObjects];
//        self.news=[NSMutableArray arrayWithArray:news];
//        self.currentPage=1;
//        self.totalPage=[responseObject[@"allPages"] integerValue];
//         //不是最后一次请求
//        if (self.params != params) return;
//        // 刷新表格
//        [self.tableView reloadData];
//        // 结束刷新
//        [self.tableView.mj_header endRefreshing];
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////        if (self.params != params) return;
//        [self.tableView.mj_header endRefreshing];
//    }];
    [CusNewsRequest requestWithSucessBlock:^(id returnValue) {
        //CusLog(@"%@",returnValue);
        
            
            NSArray *dataArray=[CusNews mj_objectArrayWithKeyValuesArray:returnValue[@"news"]];
            [self.news removeAllObjects];
            [self.news addObjectsFromArray:dataArray];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } FailureBlock:^(NSError *error) {
        CusLog(@"%@",error);
    } Page:0];
    
}
-(void)loadMoreUsers{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"showapi_appid"]=@"16055";
    params[@"showapi_sign"]=@"bf06c7463992447ea57f4505b9cff846";
    params[@"showapi_timestamp"]=[NSString timeStamp];
    params[@"type"]=@"29";
    params[@"page"]=@"2";
    self.params=params;
    [self.httpManager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *body=responseObject[@"showapi_res_body"];
        NSDictionary *pageBean=body[@"pagebean"];
        //NSLog(@"%@",pageBean[@"contentlist"]);
        NSArray *news=[CusNews mj_objectArrayWithKeyValuesArray:pageBean[@"contentlist"]];
        [self.news addObjectsFromArray:news];
        if (self.params!=params) {
            return ;
        }
        [self.tableView reloadData];
        // 让底部控件结束刷新
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CusLog(@"%@",error);
        self.currentPage--;
        [self.tableView.mj_footer noticeNoMoreData];
    }];
}

#pragma mark - Private
-(void)tagClick{
    CusLogFunc;
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

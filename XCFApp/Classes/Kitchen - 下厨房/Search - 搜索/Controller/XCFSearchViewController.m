//
//  XCFSearchViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFSearchViewController.h"
#import "XCFSearchResultViewController.h"
#import "XCFSearchViewHeader.h"
#import "XCFSearchViewFooter.h"

@interface XCFSearchViewController ()
@property (nonatomic, strong) XCFSearchBar *searchBar;
@property (nonatomic, copy) NSString *searchContent;        // 搜索内容
@property (nonatomic, strong) NSArray *typeString;          // 搜索类型
@property (nonatomic, strong) XCFSearchViewHeader *header;  // 最近搜索
@property (nonatomic, strong) XCFSearchViewFooter *footer;  // 流行搜索
@property (nonatomic, strong) NSArray *hotSearchWords;      // 流行搜索关键词
@end

@implementation XCFSearchViewController

static NSString *const wordCellIdentifier = @"word";
static NSString *const searchCellIdentifier = @"search";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    self.typeString = @[@"搜菜谱", @"搜厨友", @"搜菜单"];
    [self setupNavBar];
    [self setupTableView];
    [self setupHeader];
    [self setupFooter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 时刻刷新
    //如果最近搜索没值或者搜索有内容时 隐藏header
    self.header.hidden = ![XCFSearchKeywordsTool totalWords].count || self.searchContent.length;
    self.tableView.tableHeaderView = self.header;
    //如果输入了搜索内容 隐藏footer
    self.footer.hidden = self.searchContent.length;
    self.tableView.tableFooterView = self.footer;
    
    return 3;
}
 //如果是第0组并且搜索内容为空时 第0组返回最近搜索词的数量 其余情况返回1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = 1;
    // 如果没有搜索内容就显示已经搜索过的关键词
   
    if (section == 0 && !self.searchContent.length) {
        count = [XCFSearchKeywordsTool totalWords].count;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.searchContent.length) { // 如果有搜索内容
        cell = [tableView dequeueReusableCellWithIdentifier:searchCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.image = [UIImage imageNamed:@"searchIcon"];
        NSString *displayString = [NSString stringWithFormat:@"%@：%@", self.typeString[indexPath.section], self.searchContent];
        //设置搜索内容的文字样式
        [cell.textLabel setAttributeTextWithString:displayString
                                             range:NSMakeRange(4, self.searchContent.length)];
        
    } else { // 如果没有搜索内容
        if (indexPath.section == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:wordCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = [XCFSearchKeywordsTool totalWords][indexPath.row];
        }
        else {
            cell = [tableView dequeueReusableCellWithIdentifier:searchCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.imageView.image = [UIImage imageNamed:@"searchIcon"];
            cell.textLabel.text = self.typeString[indexPath.section];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.searchContent.length) { // 如果有搜索内容
        [XCFSearchKeywordsTool addNewWord:self.searchContent];
        [self pushResultVCWithResult:[NSString stringWithFormat:@"%@ \n %@", self.typeString[indexPath.section], self.searchContent]];

    } else { // 如果没有搜索内容
        if (indexPath.section == 0) {
            NSString *searchString = [XCFSearchKeywordsTool totalWords][indexPath.row];
            [XCFSearchKeywordsTool addNewWord:searchString];
            [self pushResultVCWithResult:[NSString stringWithFormat:@"%@ \n %@", self.typeString[0], searchString]];
        }
        else if (indexPath.section == 1 || indexPath.section == 2) {
            [self pushResultVCWithResult:self.typeString[indexPath.section]];
        }
    }
}


#pragma mark - 收起键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

#pragma mark - 事件处理
- (void)cancel {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 属性
//设置导航条
- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem = nil;
    //隐藏返回按钮
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"取消"
                                                                              target:self
                                                                              action:@selector(cancel)];
    
    self.searchBar = [XCFSearchBar searchBarWithPlaceholder:@"菜谱、食材"];
    [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = self.searchBar;

    __weak XCFSearchBar *wSearchBar = self.searchBar;
    WeakSelf;
    //搜索框文字改变 tableview的内容也要随之改变
    self.searchBar.searchBarTextDidChangedBlock = ^{ // 文本编辑回调
        weakSelf.searchContent = wSearchBar.text;
        [weakSelf.tableView reloadData]; // 时刻刷新界面
    };
    self.searchBar.searchBarDidSearchBlock = ^{ // 搜索回调
        [XCFSearchKeywordsTool addNewWord:wSearchBar.text];
        [weakSelf pushResultVCWithResult:[NSString stringWithFormat:@"%@ \n %@", weakSelf.typeString[0], wSearchBar.text]];
    };
}
//设置tableview相关
- (void)setupTableView {

    self.tableView.rowHeight = 44;
    //设置每组头尾间隔
    self.tableView.sectionHeaderHeight = 0.1;
    self.tableView.sectionFooterHeight = 10;
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:wordCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:searchCellIdentifier];
}
//设置tableHeaderView
- (void)setupHeader {
    XCFSearchViewHeader *header = [[XCFSearchViewHeader alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 30)];
    header.hidden = ![XCFSearchKeywordsTool totalWords].count; // 本地有搜索数据的话，就不隐藏
    WeakSelf;
    // 右边清空按钮点击回调 清空最近搜索
    header.clearBlock = ^{
        [XCFSearchKeywordsTool removeAllWords];
        [weakSelf.tableView reloadData];
    };
    self.tableView.tableHeaderView = header;
    self.header = header;
}
//设置tableFooterView
- (void)setupFooter {
    XCFSearchViewFooter *footer = [[XCFSearchViewFooter alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 150)];
    //如果输入了文字，则隐藏底部的流行搜索
    footer.hidden = self.searchContent.length;
    footer.keywords = self.hotSearchWords;
    WeakSelf;
    // 点击回调 点击就搜索
    footer.searchCallBack = ^(NSUInteger index) {
        [XCFSearchKeywordsTool addNewWord:weakSelf.hotSearchWords[index]];
        NSString *displayString = [NSString stringWithFormat:@"%@：%@", weakSelf.typeString[0], weakSelf.hotSearchWords[index]];
        [weakSelf pushResultVCWithResult:displayString];
    };
    self.tableView.tableFooterView = footer;
    self.footer = footer;
}

- (NSArray *)hotSearchWords {
    if(!_hotSearchWords) {
        NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                               pathForResource:@"keywords"
                                                               ofType:@"plist"]];
        NSArray *array = [NSArray arrayWithArray:dataDict[@"content"][@"keywords"]];
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSString *word in array) {
            [mArray addObject:word];
        }
        _hotSearchWords = mArray;
    }
    return _hotSearchWords;
}

- (void)pushResultVCWithResult:(NSString *)result {
    XCFSearchResultViewController *resultVC = [[XCFSearchResultViewController alloc] init];
    resultVC.result = result;
    [self.navigationController pushViewController:resultVC animated:YES];
}

@end

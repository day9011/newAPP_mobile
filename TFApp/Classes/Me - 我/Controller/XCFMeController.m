

#import "XCFMeController.h"
#import "XCFSettingViewController.h"

#import "XCFAuthorDetail.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface XCFMeController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) XCFAuthorDetail *authorDetail;
@property (nonatomic, strong) NSMutableArray *authorDishArray;
@end

@implementation XCFMeController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self setupNavigationBar];
    //[self setupCollectionView];
    }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.authorDetail = [XCFMyInfo info];
    //[self.collectionView reloadData];
}





#pragma mark - 属性
- (void)setupNavigationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navFindFriendsImage"
                                                                        imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
                                                                                 target:self
                                                                                 action:@selector(findFriends)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"rightPageSetting"
                                                                         imageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)
                                                                                  target:self
                                                                                  action:@selector(setting)];
}

- (NSMutableArray *)authorDishArray {
    if (!_authorDishArray) {
        _authorDishArray = [NSMutableArray array];
    }
    return _authorDishArray;
}

- (XCFAuthorDetail *)authorDetail {
    if (!_authorDetail) {
        _authorDetail = [XCFMyInfo info];
    }
    return _authorDetail;
}

#pragma mark - 点击事件
- (void)findFriends {

}

- (void)setting {
    [self.navigationController pushViewController:[[XCFSettingViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}


@end

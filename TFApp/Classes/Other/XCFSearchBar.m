
#import "XCFSearchBar.h"

@interface XCFSearchBar () <UISearchBarDelegate>

@end

@implementation XCFSearchBar
/**
 *  创建一个searchBar
 *
 *  @param placeholder 占位文字
 *
 *  @return searchBar
 **/
+ (XCFSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder {
    XCFSearchBar *searchBar = [[XCFSearchBar alloc] init];
    searchBar.delegate = searchBar;
    searchBar.placeholder = placeholder;
    //搜索框光标的颜色
    searchBar.tintColor = XCFSearchBarTintColor;
    //左边的放大镜图标
    [searchBar setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    UIView *searchBarSub = searchBar.subviews[0];
    for (UIView *subView in searchBarSub.subviews) {
        //设置搜索框中输入框的颜色
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [subView setBackgroundColor:RGB(247, 247, 240)];
        }
        //移除UISearchBarBackground
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
        }
    }
    return searchBar;
}
#pragma mark -searchBar的代理事件
//开始输入文字
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    //如果block存在调用block
    self.searchBarShouldBeginEditingBlock ?  self.searchBarShouldBeginEditingBlock():nil;
    return YES;
}
//文字改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchBarTextDidChangedBlock ? self.searchBarTextDidChangedBlock():nil;
}
//点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchBarDidSearchBlock ? self.searchBarDidSearchBlock():nil;
}

@end

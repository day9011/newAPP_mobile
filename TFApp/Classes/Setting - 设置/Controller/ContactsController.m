

#import "ContactsController.h"
#import <AddressBook/AddressBook.h>
#import <SVProgressHUD.h>
#import <Masonry.h>
@interface ContactsController ()
@property(nonatomic,strong) NSMutableArray *contacts;
@property(nonatomic,weak)UIImageView *tishiview;
@end

@implementation ContactsController
-(NSMutableArray *)contacts{
    if (!_contacts) {
        _contacts=[NSMutableArray array];
    }
    return _contacts;
}
- (void)loadPerson
{
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            
            CFErrorRef *error1 = NULL;
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
            [self copyAddressBook:addressBook];
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        [self copyAddressBook:addressBook];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [SVProgressHUD showErrorWithStatus:@"无法获取"];
        });
    }
}
- (void)copyAddressBook:(ABAddressBookRef)addressBook
{
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSMutableArray *dataArray=[NSMutableArray array];
    for ( int i = 0; i < numberOfPeople; i++){
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        NSString *name=[NSString stringWithFormat:@"%@%@",firstName,lastName];
        if (name==nil) {
            name=@"123";
        }
        //读取电话多值
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
       NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, 0);
        if (personPhone==nil) {
            personPhone=@"123";
        }
                
        //读取照片
        NSData *image = (__bridge NSData*)ABPersonCopyImageData(person);
        if (image==nil) {
            UIImage *defaultimage=[UIImage imageNamed:@"qiao"];
            image=UIImageJPEGRepresentation(defaultimage, 1);
        }
        NSDictionary *peppleDict=@{@"name":[NSString stringWithFormat:@"%@%@",firstName,lastName],@"number":personPhone};
        [dataArray addObject:peppleDict];
    }
    self.contacts=dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPerson];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    UIImageView *tishi=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tishi"]];
    self.tishiview=tishi;
    [self.view insertSubview:tishi aboveSubview:self.tableView];
//    tishi.frame=CGRectMake(150, 100, 100, 100);
    [tishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-64);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(200);

    }];
    tishi.alpha=0;
    [UIView animateWithDuration:2 animations:^{
        tishi.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.tishiview.alpha==1) {
        [UIView animateWithDuration:1 animations:^{
            self.tishiview.alpha=0;
        } completion:^(BOOL finished) {
            
        }];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [SVProgressHUD dismiss];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID=@"contacts";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    NSDictionary *dict=self.contacts[indexPath.row];
    cell.textLabel.text=dict[@"name"];
    cell.detailTextLabel.text=dict[@"number"];
    cell.accessoryType=UITableViewCellAccessoryDetailButton;
    

    return cell;
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

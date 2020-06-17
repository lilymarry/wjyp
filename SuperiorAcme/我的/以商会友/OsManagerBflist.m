//
//  OsManagerBflist.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/25.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "OsManagerBflist.h"
#import "OsManagerBflistModel.h"
#import "OsManagerBflistCell.h"
#import "BfriendcateList.h"
#import "BfriendcateModel.h"
#import "EaseMessageViewController.h"
#import "OsManagerBflistTopView.h"
#import "GetBfriendModel.h"
#import "MerchantInfor.h"
#import "AddBFrientList.h"
#import "AddShopFriendList.h"
#import "MemberExchang.h"
#import "OsManagerNewsView.h"
#import "SUserUserCenter.h"
@interface OsManagerBflist ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray * arr;//列表
   
    NSString *search;
    BOOL isSearch;
    NSMutableArray *brr;//搜索数组
    
    NSString *change_num;
    NSString *msg_num;
    UIView *flagView;
    BOOL isShowBtn;
    
    OsManagerNewsView *newsView;
     NSTimer           *timer;
    NSString *service_head_pic;
    NSString *service_nickname;
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIView *butView;
@property (strong, nonatomic) IBOutlet UIButton *exChangBtn;
@property (strong, nonatomic) IBOutlet UIButton *FriendBtn;



@end

@implementation OsManagerBflist

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     adjustsScrollViewInsets_NO(_mTable, self);
    
    [_mTable registerNib:[UINib nibWithNibName:@"OsManagerBflistCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OsManagerBflistCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 30);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.rightBarButtonItem = leftBtnItem;
  
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(6, 5, 20, 20)];
   [imageView setImage:[UIImage imageNamed:@"添加银行卡"]];
    [lefthBtn addSubview:imageView];
    
    flagView=[[UIView alloc]initWithFrame:CGRectMake(27, 6, 5, 5)];
    [flagView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:41/255.0 blue:42/255.0 alpha:1]];

    flagView.layer.cornerRadius = flagView.bounds.size.width * 0.5;
    flagView.layer.masksToBounds = YES;
    [lefthBtn addSubview:flagView];
    
    
    [lefthBtn addTarget:self action:@selector(addPress) forControlEvents:UIControlEventTouchUpInside];
    
 
    self.title=@"以商会友";
    isSearch =NO;
   
    
    brr = [NSMutableArray array];
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
          [self showModel];
          [self getUserCenter];
        };
        return;
    }
   [self getUserCenter];
    
}
-(void)addPress
{
    isShowBtn=!isShowBtn;
    _butView.hidden=isShowBtn;

}
-(void)viewWillAppear:(BOOL)animated
{
    isShowBtn=YES;
    _butView.hidden=YES;
    [self showModel];

}


-(void)viewDidAppear:(BOOL)animated
{
    if ([_type isEqualToString:@"1"]) {
        newsView  =[[OsManagerNewsView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        newsView.nameLab.text=@"好友请求在这里";
        [self.view.window addSubview:newsView];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hiddenNewsView) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer  forMode:NSRunLoopCommonModes];
    }
    else if ([_type isEqualToString:@"2"]) {
        newsView  =[[OsManagerNewsView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        newsView.nameLab.text=@"会员请求在这里";
        [self.view.window addSubview:newsView];
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hiddenNewsView) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer  forMode:NSRunLoopCommonModes];
    }
 
}
-(void)hiddenNewsView
{
    _type=nil;
    [self stopTimer];
    [newsView  removeFromSuperview];
}
-(void)stopTimer
{
    [timer invalidate];
    timer=nil;
}
- (void)showModel {
    OsManagerBflistModel * index = [[OsManagerBflistModel alloc] init];
    index.t = @"1";
    index.sta_mid=_sta_mid;
    [MBProgressHUD showMessage:nil toView:self.view];
    [index OsManagerBflistModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            OsManagerBflistModel * index =(OsManagerBflistModel *)data;
            arr = [NSArray arrayWithArray:index.data.list];
            [_exChangBtn setTitle:[NSString stringWithFormat:@"会员互换(%@)",index.data.change_num] forState:UIControlStateNormal];
             [_FriendBtn setTitle:[NSString stringWithFormat:@"新的好友(%@)",index.data.msg_num] forState:UIControlStateNormal];
            
            change_num=index.data.change_num;
            msg_num=index.data.msg_num;
            
            if ([index.data.change_num intValue]==0&&[index.data.msg_num intValue]==0) {
                flagView.hidden=YES;
            }
            else
            {
                flagView.hidden=NO;
            }
            
            [_mTable reloadData];
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (isSearch) {
        return  1;
    }
    else
    {
      return arr.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (isSearch) {
        return  brr.count;
    }
    else
    {
      
        OsManagerBflistModel * list = arr[section];
        
        return list.list.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0)
        
    {
        if (isSearch) {
            return  55;
        }
        else{
            if (KIsiPhoneX) {
                return 125;
            }
            else
            {
                return 95;
            }
        }
    }
    else
    {
    return 40;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        OsManagerBflistTopView *topView;
        if (!isSearch) {
            float yy;
            if (KIsiPhoneX) {
                yy= 125;
            }
            else
            {
                yy= 95;
            }
              OsManagerBflistModel * list = arr[section];
            topView=[[OsManagerBflistTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, yy)];
            topView.labViewHHH.constant=40;
            topView.labView.hidden=NO;
            topView.nameLab.text=list.name;
        }
        else
        {
           
          topView=[[OsManagerBflistTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 55)];
            topView.labViewHHH.constant=0;
            topView.labView.hidden=YES;
          
        }
        topView.searchTf.delegate=self;
        topView.searchTf.text=search;
        return topView;
    }
    else
    {
        if (isSearch) {
            return nil;
        }
        else
        {
        UIView * timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        timeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 40)];
        [timeView addSubview:name];
        
         OsManagerBflistModel * list = arr[section];
        name.text = list.name;
        
        name.textColor = WordColor;
        name.font = [UIFont systemFontOfSize:14];
        
        return timeView;
        }
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OsManagerBflistCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OsManagerBflistCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (isSearch) {
        NSDictionary * list_sub = brr[indexPath.row];
        
        [cell.headIma sd_setImageWithURL:[NSURL URLWithString:list_sub[@"head_pic"]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.nameLab.text=list_sub[@"nickname"];
        cell.friendLab.hidden=NO;
        if ([list_sub[@"status"] intValue]==1) {
           cell.friendLab.text=@"已为好友";
        }
        else{
           cell.friendLab.text=@"加好友";
        }
    }
    else
    {
   
        OsManagerBflistModel * list = arr[indexPath.section];
        OsManagerBflistModel * list_sub = list.list[indexPath.row];
    
        [cell.headIma sd_setImageWithURL:[NSURL URLWithString:list_sub.user_info.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
       cell.nameLab.text=list_sub.user_info.nickname;
        cell.friendLab.hidden=YES;
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSearch) {
        NSDictionary * list_sub = brr[indexPath.row];
        if ([list_sub[@"status"] intValue]!=1) {
            MerchantInfor *add=[[MerchantInfor alloc]init];
            add.head_pic=list_sub[@"head_pic"];
            add.sex=list_sub[@"sex"];
            add.nickname=list_sub[@"nickname"];
            add.id=list_sub[@"id"];
            add.area=list_sub[@"area"];
            add.m_id=list_sub[@"m_id"];
            add.m_name=list_sub[@"m_name"];
            add.merchant_id=list_sub[@"merchant_id"];
            add.sta_mid=_sta_mid;
            [self.navigationController pushViewController:add animated:YES];
        }
    }
    else
    {
    OsManagerBflistModel * list = arr[indexPath.section];
    OsManagerBflistModel * list_sub = list.list[indexPath.row];
        if (service_nickname.length>0&&service_head_pic.length>0) {
      
    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:list_sub.user_info.easemob_account conversationType:EMConversationTypeChat];
    chatController.titleTap=YES;
    
    chatController.nickname_mine = service_nickname;
    chatController.pic_mine = service_head_pic;
    chatController.nickname_other = list_sub.user_info.nickname;
    chatController.pic_other =  list_sub.user_info.head_pic;
        chatController.phone=list_sub.user_info.phone;
        chatController.sta_mid=_sta_mid;
            [self.navigationController pushViewController:chatController  animated:YES ];}
    }
}
- (void)getUserCenter {
    SUserUserCenter * center = [[SUserUserCenter alloc] init];

    [center sUserUserCenterSuccess:^(NSString *code, NSString *message, id data) {
     
        if ([code isEqualToString:@"1"]) {
            SUserUserCenter * center = (SUserUserCenter *)data;
    
            service_head_pic = center.data.head_pic;
            service_nickname = center.data.nickname;
           
        } else {
            [MBProgressHUD showError:message toView:self.view];
           
        }
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma mark 分组管理
- (IBAction)cateManagerPress:(id)sender {
    BfriendcateList *bf=[[BfriendcateList alloc]init];
    bf.sta_mid=_sta_mid;
    [self.navigationController pushViewController:bf animated:YES];
    
}
- (IBAction)AddShopFriendPress:(id)sender {
AddShopFriendList *add=[[AddShopFriendList alloc]init];
add.sta_mid=_sta_mid;
[self.navigationController pushViewController:add animated:YES];
}
#pragma mark 会员互换
- (IBAction)exChangHuiYuang:(id)sender {
    MemberExchang*add=[[MemberExchang alloc]init];
    add.sta_mid=_sta_mid;
    [self.navigationController pushViewController:add animated:YES];
}
#pragma mark 新的好友
- (IBAction)newfriend:(id)sender {
    AddBFrientList *add=[[AddBFrientList alloc]init];
    add.sta_mid=_sta_mid;
    [self.navigationController pushViewController:add animated:YES];
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    search=textField.text;
    isSearch=YES;
    
    if (search.length==0) {
         isSearch=NO;
        [self showModel];
    }
    else
    {
    GetBfriendModel *model=[[GetBfriendModel alloc]init];
    model.phone=search;
    model.sta_mid=_sta_mid;
    model.type=@"0";
    [MBProgressHUD showMessage:nil toView:self.view];
    [model GetBfriendModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [brr removeAllObjects];
        if ([code intValue]==1) {
          //  GetBfriendModel * index =(GetBfriendModel *)data;
            brr = [NSMutableArray arrayWithArray:data];
            
          
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
          [_mTable reloadData];
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    }
    
    return YES;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    return YES;
    
}
@end

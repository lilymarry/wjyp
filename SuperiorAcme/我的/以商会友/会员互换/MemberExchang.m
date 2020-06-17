//
//  MemberExchang.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "MemberExchang.h"
#import "MemberExchangModel.h"
#import "MemberExchangCell.h"
#import "SelectArea.h"
#import "ExchangInforCell.h"
#import "MemberExchangDetail.h"
@interface MemberExchang ()<UITableViewDelegate,UITableViewDataSource>
{
    UISegmentedControl *segment;
 
        NSArray * arr;//列表
        
        NSString *type;
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIView *noDataView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnHHH;
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UIView *labView;
@property (strong, nonatomic) IBOutlet UILabel *numLab;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labViewHHH;


@end

@implementation MemberExchang

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *array = [NSArray arrayWithObjects:@"我的会员",@"换入会员",@"互换消息", nil];
    //初始化UISegmentedControl
     segment = [[UISegmentedControl alloc]initWithItems:array];
    //设置frame
    segment.frame = CGRectMake(0, 0, ScreenW-100, 30);
    //添加到视图
    segment.tintColor = [UIColor colorWithRed:240/225.0 green:41/255.0 blue:42/255.0 alpha:1];
     segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
   segment.layer.cornerRadius = 10;
   segment.layer.masksToBounds = YES;
    segment.layer.borderWidth = 1;
    segment.layer.borderColor = [UIColor colorWithRed:240/255.0 green:41/255.0 blue:42/255.0 alpha:1].CGColor;
    
    self.navigationItem.titleView = segment;
    
  
    
    [_mTable registerNib:[UINib nibWithNibName:@"MemberExchangCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MemberExchangCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_mTable registerNib:[UINib nibWithNibName:@"ExchangInforCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ExchangInforCell"];
 
    self.title=@"会员互换";
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
  
}
-(void)lefthBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    segment.selectedSegmentIndex=0;
    type=@"1";
    [self showModel];
    
    MemberExchangModel * index = [[MemberExchangModel alloc] init];
    index.sta_mid=_sta_mid;
    index.flag=@"4";
    
    [index MemberExchangModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data,NSString * num) {
        
        if ([num intValue]>0) {
            [segment setTitle:@"互换消息 •" forSegmentAtIndex:2];
        }
        else
        {
          [segment setTitle:@"互换消息" forSegmentAtIndex:2];
        }
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(void)change:(UISegmentedControl *)sender{

    if (sender.selectedSegmentIndex == 0) {
         type=@"1";
        [self showModel];
        _btn.hidden=NO;
        _btnHHH.constant=44;
    }else if (sender.selectedSegmentIndex == 1){
         type=@"2";
       [self showModel];
        _btn.hidden=YES;
        _btnHHH.constant=0;
    }else {
         type=@"3";
        [self getData];
        _btn.hidden=YES;
        _btnHHH.constant=0;
    }
}
- (void)showModel {
    MemberExchangModel * index = [[MemberExchangModel alloc] init];
    index.type = type;
    index.sta_mid=_sta_mid;
    index.flag=@"1";
    [MBProgressHUD showMessage:nil toView:self.view];
    [index MemberExchangModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data,NSString * num) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            arr = [NSArray arrayWithArray:
                   data];
            _numLab.text=[NSString stringWithFormat:@"会员总数%@",num];
            _labViewHHH.constant=30;
            _labView.hidden=NO;
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        if (arr.count==0) {
            _noDataView.hidden=NO;
        }
        else
        {
           _noDataView.hidden=YES;
        }
        
             [_mTable reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(void)getData
{
    MemberExchangModel * index = [[MemberExchangModel alloc] init];
    index.sta_mid=_sta_mid;
    index.flag=@"3";
    [MBProgressHUD showMessage:nil toView:self.view];
    [index MemberExchangModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data,NSString * num) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            
            arr = [NSArray arrayWithArray:data];
        
            _labViewHHH.constant=0;
            _labView.hidden=YES;
            
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        if (arr.count==0) {
            _noDataView.hidden=NO;
        }
        else
        {
            _noDataView.hidden=YES;
        }
        
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return  arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 87;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([type isEqualToString:@"3"]) {
        ExchangInforCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"ExchangInforCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary * list_sub = arr[indexPath.row];
        
        [cell.headIma sd_setImageWithURL:[NSURL URLWithString:list_sub[@"head_pic"]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.nameLab.text=list_sub[@"nickname"];
        cell.timeLab.text=list_sub[@"create_time"];
        cell.contentLab.text=list_sub[@"title"];
        cell.stateLab.text=list_sub[@"status_desc"];
        if ([list_sub[@"read_status"]isEqualToString:@"0"]) {
            cell.newsView.hidden=YES;
        }
        else
        {
           cell.newsView.hidden=NO;
        }
        
        
        return cell;
    }
    else
    {
    MemberExchangCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MemberExchangCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
        NSDictionary * list_sub = arr[indexPath.row];
        
        [cell.headIma sd_setImageWithURL:[NSURL URLWithString:list_sub[@"head_pic"]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
      
        NSString *sex=@"";
        if ([list_sub[@"sex"] isEqualToString:@"1"]) {
            sex=@"男";
        }
        else  if ([list_sub[@"sex"] isEqualToString:@"2"])
        {
            sex=@"女";
        }
         cell.nameLab.text=[NSString stringWithFormat:@"%@     %@",list_sub[@"user_name"],sex];
       cell.leveLab.text=[NSString stringWithFormat:@" %@ ",list_sub[@"member_coding"]];
      cell.timeLab.text=list_sub[@"create_time"];
    return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ if ([type isEqualToString:@"3"]) {
  
    
    NSDictionary * list_sub = arr[indexPath.row];
    
    MemberExchangDetail *detail=[[MemberExchangDetail alloc]init];
    detail.sta_mid=_sta_mid;
    detail.c_id=list_sub[@"c_id"];
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
  
}
    
}
- (IBAction)changePress:(id)sender {
    SelectArea *sl=[[SelectArea alloc]init];
    sl.sta_mid=_sta_mid;
    sl.type=@"2";
    [self.navigationController pushViewController:sl animated:YES];
}


@end

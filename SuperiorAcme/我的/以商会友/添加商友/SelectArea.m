//
//  SelectArea.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "SelectArea.h"
#import "DatePicker_Country.h"
#import "SelectPickView.h"
#import "SelectResult.h"
#import "ExchangeItemModel.h"
#import "MemberExchangModel.h"
@interface SelectArea ()
{
    NSString *city_id;
    NSString *cate_id;
    
    NSArray *ageArr;
    NSString *age;
    NSString * sex;
    NSString * member_coding;
    NSString *shopkeeper_id;
    
}
@property (strong, nonatomic) IBOutlet UILabel *Lab1;
@property (strong, nonatomic) IBOutlet UILabel *subLab1;
@property (strong, nonatomic) IBOutlet UIButton *but1;

@property (strong, nonatomic) IBOutlet UILabel *Lab2;
@property (strong, nonatomic) IBOutlet UILabel *subLab2;
@property (strong, nonatomic) IBOutlet UIButton *but2;

@property (strong, nonatomic) IBOutlet UILabel *Lab3;
@property (strong, nonatomic) IBOutlet UILabel *subLab3;
@property (strong, nonatomic) IBOutlet UIButton *but3;

@property (strong, nonatomic) IBOutlet UILabel *Lab4;
@property (strong, nonatomic) IBOutlet UILabel *subLab4;
@property (strong, nonatomic) IBOutlet UIButton *but4;

@property (strong, nonatomic) IBOutlet UILabel *Lab5;
@property (strong, nonatomic) IBOutlet UILabel *subLab5;
@property (strong, nonatomic) IBOutlet UIButton *but5;

@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIView *view4;
@property (strong, nonatomic) IBOutlet UIView *view5;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view1HHH;

@property (strong, nonatomic) IBOutlet UIButton *subBtn;

@end

@implementation SelectArea

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([_type isEqualToString:@"1"]) {
        _Lab1.text=@"地区";
        _Lab2.text=@"行业";
        
        [_but1 addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
        
        [_but2 addTarget:self action:@selector(selectWork) forControlEvents:UIControlEventTouchUpInside];
        
        _view3.hidden=YES;
        _view4.hidden=YES;
        _view4.hidden=YES;
        _view5.hidden=YES;
        [_subBtn setTitle:@"筛选" forState:UIControlStateNormal];
        self.title=@"按筛选条件";
    }
    else   if ([_type isEqualToString:@"2"])
    {
         self.title=@"设置互换条件";
        _Lab1.text=@"选择商友";
        _Lab2.text=@"会员性别";
        _Lab3.text=@"会员年龄";
        _Lab4.text=@"会员等级";
        _Lab5.text=@"所在地区";
        
        sex=@"0";
        age=@"0";
        member_coding=@"0";
        
        [_but1 addTarget:self action:@selector(selectFriend) forControlEvents:UIControlEventTouchUpInside];
        
        [_but2 addTarget:self action:@selector(selectSex) forControlEvents:UIControlEventTouchUpInside];
        [_but3 addTarget:self action:@selector(selectAge) forControlEvents:UIControlEventTouchUpInside];
        [_but4 addTarget:self action:@selector(selectLeve) forControlEvents:UIControlEventTouchUpInside];
        [_but5 addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
        [_subBtn setTitle:@"确认" forState:UIControlStateNormal];
        
        
        ExchangeItemModel *model=[[ExchangeItemModel alloc]init];
        model.sta_mid=_sta_mid;
        model.type=@"2";
        [MBProgressHUD showMessage:nil toView:self.view];
        [model ExchangeItemModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code intValue]==1) {
                
                ageArr = [NSArray arrayWithArray:data];
                
            }
            else
            {
                [MBProgressHUD showError:message toView:self.view];
            }
            
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    else
    {
        self.title=@"设置互换条件";
        _Lab1.text=@"选择商友";
        _Lab2.text=@"会员性别";
        _Lab3.text=@"会员年龄";
        _Lab4.text=@"会员等级";
        _Lab5.text=@"所在地区";
        
        sex=@"0";
        age=@"0";
        member_coding=@"0";
        
        [_but1 addTarget:self action:@selector(selectFriend) forControlEvents:UIControlEventTouchUpInside];
        
        [_but2 addTarget:self action:@selector(selectSex) forControlEvents:UIControlEventTouchUpInside];
        [_but3 addTarget:self action:@selector(selectAge) forControlEvents:UIControlEventTouchUpInside];
        [_but4 addTarget:self action:@selector(selectLeve) forControlEvents:UIControlEventTouchUpInside];
        [_but5 addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
        [_subBtn setTitle:@"确认" forState:UIControlStateNormal];
        
        _view1.hidden=YES;
        _view1HHH.constant=0;
        
        ExchangeItemModel *model=[[ExchangeItemModel alloc]init];
        model.sta_mid=_sta_mid;
        model.type=@"2";
        [MBProgressHUD showMessage:nil toView:self.view];
        [model ExchangeItemModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code intValue]==1) {
                
                ageArr = [NSArray arrayWithArray:data];
                
            }
            else
            {
                [MBProgressHUD showError:message toView:self.view];
            }
            
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}

#pragma mark - 所在地区
- (void)selectArea {
    
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view addSubview:view];
    
    DatePicker_Country * pick = [[DatePicker_Country alloc] init];
    pick.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pick animated:YES completion:nil];
    
    pick.DatePicker_Country_Back = ^{
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        if ([_type isEqualToString:@"1"]) {
            _Lab1.text=@"地区";
            _subLab1.hidden=NO;
            city_id = nil;
        }
        else
        {
         //   _Lab5.text=@"地区";
            _subLab5.text=@"不限";
            city_id = nil;
        }
        
    };
    pick.DatePicker_Country_Submit = ^(NSString *one, NSString *two, NSString *three, NSString *one_id, NSString *two_id, NSString *three_id) {
        if ([_type isEqualToString:@"1"]) {
            _Lab1.text= [NSString stringWithFormat:@"%@%@%@",one,two,three];
            city_id = three_id;
            _subLab1.hidden=YES;
        }
        else
        {
          //  _Lab5.text= [NSString stringWithFormat:@"%@%@%@",one,two,three];
            city_id = three_id;
            _subLab5.text=[NSString stringWithFormat:@"%@%@%@",one,two,three];
        }
        
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
}
#pragma mark - 行业
- (void)selectWork
{
    
    NSMutableArray *data=[NSMutableArray array];
    for (int i=0; i<_cate_dataArr.count; i++)
    {   [data addObject:_cate_dataArr[i][@"text"]];
        
    }
    
    SelectPickView * header = [[SelectPickView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
    [header getData:data flag:@"1"];
    
    [self.view.window addSubview:header];
    
    
    header.topBtnBlock = ^(NSString * name,NSString *flag,NSInteger index) {
        _Lab2.text=name;
        _subLab2.hidden=YES;
        cate_id=_cate_dataArr[index][@"value"];
    };
    header.cancelBlock = ^{
        _Lab2.text=@"行业";
        _subLab2.hidden=NO;
        cate_id=nil;
    };
}
#pragma mark - 商友
- (void)selectFriend
{
    SelectResult *resu=[[SelectResult alloc]init];
    resu.sta_mid=_sta_mid;
    
    resu.type=@"2";
    resu.uidBlock = ^(NSString * _Nonnull name, NSString * _Nonnull uid) {
      //  _Lab1.text=name;
        _subLab1.text=name;
        shopkeeper_id=uid;
        
    };
    [self.navigationController pushViewController:resu animated:YES];
}
#pragma mark - 性别
- (void)selectSex
{
    NSArray *data=[NSArray arrayWithObjects:@"不限",@"男",@"女", nil];
    
    SelectPickView * header = [[SelectPickView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
    [header getData:data flag:@"1"];
    
    [self.view.window addSubview:header];
    
    
    header.topBtnBlock = ^(NSString * name,NSString *flag,NSInteger index) {
        if ([flag isEqualToString:@"1"]) {
           
            _subLab2.text=name;
            sex=[NSString stringWithFormat:@"%d",(int)index];
        }
        
    };
    header.cancelBlock = ^{
        
           _subLab2.text=@"不限";
            sex=@"0";
    };
}
#pragma mark - 年龄
- (void)selectAge
{
    
    
    NSMutableArray *data=[NSMutableArray array];
    for (int i=0; i<ageArr.count; i++)
    {   [data addObject:ageArr[i][@"title"]];
        
    }
    SelectPickView * header = [[SelectPickView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    if (data.count>0) {
        [header getData:data flag:@"2"];
    }
    
    
    [self.view.window addSubview:header];
    
    
    header.topBtnBlock = ^(NSString * name,NSString *flag,NSInteger index) {
        if ([flag isEqualToString:@"2"]) {
     
            _subLab3.text=name;
            age=ageArr[index][@"age"];
        }
    };
    header.cancelBlock = ^{
      
           _subLab3.text=@"不限";
            age=@"0";
    };
    
}

- (void)selectLeve
{
    NSArray *data=[NSArray arrayWithObjects:@"不限",@"无界会员",@"无忧会员",@"优享会员", nil];
    
    SelectPickView * header = [[SelectPickView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
    [header getData:data flag:@"3"];
    
    [self.view.window addSubview:header];
    
    
    header.topBtnBlock = ^(NSString * name,NSString *flag,NSInteger index) {
        if ([flag isEqualToString:@"3"]) {
          //  _Lab4.text=name;
            _subLab4.text=name;
             member_coding =[NSString stringWithFormat:@"%d",(int)index];;
        }
        
    };
    header.cancelBlock = ^{
      //   _Lab4.text=@"会员等级";
          _subLab4.text=@"不限";
        member_coding =@"0";
    };
}
- (IBAction)subPress:(id)sender {
    if ([_type isEqualToString:@"1"]) {
        SelectResult *resu=[[SelectResult alloc]init];
        resu.sta_mid=_sta_mid;
        resu.city_id=city_id;
        resu.cate_id=cate_id;
        resu.type=@"1";
        [self.navigationController pushViewController:resu animated:YES];
    }
    else if ([_type isEqualToString:@"2"])
    {
        
        if (shopkeeper_id.length==0) {
            [MBProgressHUD showError:@"选择商友" toView:self.view];
            return;
        }
        
        MemberExchangModel * index = [[MemberExchangModel alloc] init];
       
        index.sta_mid=_sta_mid;
        index.flag=@"2";
        index.shopkeeper_id=shopkeeper_id;
        index.sex=sex;
        index.age=age;
        index.member_coding=member_coding;
        index.city_id=city_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [index MemberExchangModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data,NSString * num) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
             [MBProgressHUD showError:message toView:self.view];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    else
    {
        self.selectAreaBlock(sex, age, member_coding,city_id);
        [self.navigationController popViewControllerAnimated:YES];
    }
  
    
    
}


@end

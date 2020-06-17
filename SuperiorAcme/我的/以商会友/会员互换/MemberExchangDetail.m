//
//  MemberExchangDetail.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/6.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "MemberExchangDetail.h"
#import "MemberExchangModel.h"
#import "SelectArea.h"
@interface MemberExchangDetail ()
{
    NSString *agreeStr;
    NSString *disgreeStr;
}
@property (strong, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *myViewHHH;
@property (strong, nonatomic) IBOutlet UILabel *myNameLab;

@property (strong, nonatomic) IBOutlet UILabel *myAgeLab;
@property (strong, nonatomic) IBOutlet UILabel *myLeveLab;
@property (strong, nonatomic) IBOutlet UILabel *myAreaLab;
@property (strong, nonatomic) IBOutlet UIButton *myArgreeBtn;

@property (strong, nonatomic) IBOutlet UIButton *myDisagreeBtn;


@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *userViewHHH;
@property (strong, nonatomic) IBOutlet UILabel *userNameLab;

@property (strong, nonatomic) IBOutlet UILabel *userAgeLab;
@property (strong, nonatomic) IBOutlet UILabel *userLeveLab;
@property (strong, nonatomic) IBOutlet UILabel *userAreaLab;
@property (strong, nonatomic) IBOutlet UIButton *userArgreeBtn;

@property (strong, nonatomic) IBOutlet UIButton *userDisagreeBtn;

@property (strong, nonatomic) IBOutlet UIButton *statusBtn;


@property (strong, nonatomic) IBOutlet UILabel *title1Lab;
@property (strong, nonatomic) IBOutlet UILabel *title2Lab;

@end

@implementation MemberExchangDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     self.title=@"详情";
    self.myView.layer.cornerRadius = 8;
    self.myView.layer.masksToBounds = YES;
    self.myView.layer.borderWidth = 1;
    self.myView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    
    self.userView.layer.cornerRadius = 8;
    self.userView.layer.masksToBounds = YES;
    self.userView.layer.borderWidth = 1;
    self.userView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    self.myDisagreeBtn.layer.cornerRadius = 8;
    self.myDisagreeBtn.layer.masksToBounds = YES;
    self.myDisagreeBtn.layer.borderWidth = 1;
    self.myDisagreeBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    self.userDisagreeBtn.layer.cornerRadius = 8;
    self.userDisagreeBtn.layer.masksToBounds = YES;
    self.userDisagreeBtn.layer.borderWidth = 1;
    self.userDisagreeBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.userDisagreeBtn.hidden=YES;
    
    
    self.statusBtn.layer.cornerRadius = 8;
    self.statusBtn.layer.masksToBounds = YES;
  
    
    self.myArgreeBtn.layer.cornerRadius = 8;
    self.myArgreeBtn.layer.masksToBounds = YES;

    
    self.userArgreeBtn.layer.cornerRadius = 8;
    self.userArgreeBtn.layer.masksToBounds = YES;
    
    _userViewHHH.constant=150;
    _userArgreeBtn.hidden=YES;
    _userDisagreeBtn.hidden=YES;

    
    _myViewHHH.constant=150;
    _myArgreeBtn.hidden=YES;
    _myDisagreeBtn.hidden=YES;
    
    _statusBtn.hidden=YES;
    
    [self getData];
}

-(void)getData
{
    MemberExchangModel * index = [[MemberExchangModel alloc] init];
    index.sta_mid=_sta_mid;
    index.cid=_c_id;
    index.flag=@"5";
    [MBProgressHUD showMessage:nil toView:self.view];
    [index MemberExchangModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data,NSString * num) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
         
            if ([data[@"u_condition"] count]>0) {
                _myView.hidden=NO;
                _myViewHHH.constant=150;
                
                NSDictionary *mydata=data[@"u_condition"][0];
                _myNameLab.text=mydata[@"sex"];
                _myAgeLab.text=mydata[@"age_name"];
                _myLeveLab.text=mydata[@"member_coding"];
                _myAreaLab.text=mydata[@"city_name"];
                
            }
            else
            {
                _myView.hidden=YES;
                _myViewHHH.constant=0;
            }
            if ([data[@"b_condition"] count]>0) {
                _userView.hidden=NO;
                _userViewHHH.constant=150;
                
                NSDictionary *userdata=data[@"b_condition"][0];
                _userNameLab.text=userdata[@"sex"];
                _userAgeLab.text=userdata[@"age_name"];
                _userLeveLab.text=userdata[@"member_coding"];
                _userAreaLab.text=userdata[@"city_name"];
            }
            else
            {
                _userView.hidden=YES;
                _userViewHHH.constant=0;
            }
            NSInteger num=[data[@"status"]  intValue];
            
            if ([data[@"type"] isEqualToString:@"1"]) {
               // _title1Lab.text=@"我的互换条件";
                if (num==0) {
                   [_statusBtn setTitle:@"请等待对方审核" forState:UIControlStateNormal];
                    _statusBtn.hidden=NO;
                }
               else if (num==1) {
              
                     [_statusBtn setTitle:@"成功交换" forState:UIControlStateNormal];
                     _statusBtn.hidden=NO;
                }
               else if (num==2) {
                   _userViewHHH.constant=270;
                   _userDisagreeBtn.hidden=NO;
                   _userArgreeBtn.hidden=NO;
                   _statusBtn.hidden=YES;
                   agreeStr=@"1";
                   disgreeStr=@"5";
               }
               else if (num==3) {
              
                    [_statusBtn setTitle:@"对方已拒绝" forState:UIControlStateNormal];
                    _statusBtn.hidden=NO;
               }
               else if (num==5) {
                   [_statusBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
                  _statusBtn.hidden=NO;
               }
            }
            else if ([data[@"type"] isEqualToString:@"2"])
            {
                // _title2Lab.text=@"对方互换条件";
                if (num==0) {
                    _myViewHHH.constant=270;
                    _myDisagreeBtn.hidden=NO;
                    _myArgreeBtn.hidden=NO;
                    _statusBtn.hidden=YES;
                     agreeStr=@"2";
                     disgreeStr=@"3";
                    
                }
               else if (num==1)
               {
                      [_statusBtn setTitle:@"成功交换" forState:UIControlStateNormal];
                      _statusBtn.hidden=NO;
               }
               else if (num==3)
               {
                    [_statusBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
                    _statusBtn.hidden=NO;
                
               }
               else if (num==5)
               {
                   [_statusBtn setTitle:@"对方已拒绝" forState:UIControlStateNormal];
                    _statusBtn.hidden=NO;
               }
            }
            if (_userView.hidden==NO&&_myView.hidden==NO) {
               
                if ([data[@"type"] isEqualToString:@"1"]){
                     _title1Lab.text=@"我的互换条件";
                }
               else {
                   _title2Lab.text=@"我的互换条件";
                }
               
            }
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
-(IBAction)degreeBtn:(UIButton *)but
{
    if ( but.tag==1000) {
        [self degree];
    }
    else if ( but.tag==1001)
    {
        [self disAgree];
    }
    else if ( but.tag==1002)
    {
         [self degree];
    }
    else
    {
         [self disAgree];
    }
    
  
}
-(void)degree
{
    if ([agreeStr isEqualToString:@"2"]) {
        
        SelectArea *sl=[[SelectArea alloc]init];
        sl.sta_mid=_sta_mid;
      
        sl.type=@"3";
        sl.selectAreaBlock = ^(NSString * _Nonnull sex, NSString * _Nonnull age, NSString * _Nonnull member_coding, NSString * _Nonnull city_id) {
            [self MemberExchang:sex age:age member_coding:member_coding city_id:city_id];
        };
        [self.navigationController pushViewController:sl animated:YES];
    }
    else
    {
         [self MemberExchang:@"" age:@"" member_coding:@"" city_id:@""];
    }
   
}
-(void)MemberExchang:(NSString *)sex age:(NSString *)age member_coding:(NSString *)member_coding city_id:(NSString *)city_id
{
    MemberExchangModel * index = [[MemberExchangModel alloc] init];
    index.sta_mid=_sta_mid;
    index.flag=@"6";
    index.status=agreeStr;
    index.c_id=_c_id;

    if ([agreeStr isEqualToString:@"2"]) {
        index.sex=sex;
        index.age=age;
        index.member_coding=member_coding;
        index.city_id=city_id;
    }
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [index MemberExchangModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data,NSString * num) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:message toView:self.view];
        [self getData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(void)disAgree
{
    MemberExchangModel * index = [[MemberExchangModel alloc] init];
    index.sta_mid=_sta_mid;
    index.flag=@"7";
    index.status=disgreeStr;
    index.c_id=_c_id;
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [index MemberExchangModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,  id data,NSString * num) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:message toView:self.view];
        [self getData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
@end

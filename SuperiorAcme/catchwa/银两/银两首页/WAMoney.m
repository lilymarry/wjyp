//
//  WAMoney.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/2.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMoney.h"
#import "WAMoneyPayCell.h"
#import "WAMoneyListCell.h"
#import "WAMoneyTittleCell.h"
#import "WAMoneyPayList.h"
#import "SUserSetting.h"
#import "MoneyExchangeListModel.h"
#import "SModifyLoginPassword.h"
#import "SPay_Pass.h"
#import "WAInRoom.h"
@interface WAMoney () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
    
    NSMutableArray *dataArr;
    NSString *money;
    BOOL payPass_isno;//余额支付、积分支付 是否密码验证
    
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UIButton *chargeBtn;

@property(nonatomic,strong)NSIndexPath *lastPath1;
@property(nonatomic,strong)NSIndexPath *lastPath2;

@end

@implementation WAMoney

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _chargeBtn.layer.masksToBounds = YES;
    _chargeBtn.layer.cornerRadius = 15;
    _chargeBtn.layer.borderWidth = 5;
    _chargeBtn.layer.borderColor =[UIColor clearColor].CGColor;
    
    [self createNav];
    arr = @[
            @{
                @"payIma"   :@"支付宝支付",
                @"payName"  :@"支付宝",
                @"payType"  :@"2"
                },
            @{
                @"payIma"   :@"微信支付",
                @"payName"  :@"微信支付",
                @"payType"  :@"1"
                },
            @{
                @"payIma"   :@"余额支付",
                @"payName"  :@"余额支付",
                @"payType"  :@"4"
                },
            @{
                @"payIma"   :@"积分支付",
                @"payName"  :@"积分支付",
                @"payType"  :@"5"
                }
            ];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WAMoneyPayCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMoneyPayCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"WAMoneyListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMoneyListCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"WAMoneyTittleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMoneyTittleCell"];
    //设置默认初值
    _lastPath1 = [NSIndexPath indexPathForRow:0 inSection:1];
    
    [_mTable selectRowAtIndexPath:_lastPath1 animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    
    _lastPath2 = [NSIndexPath indexPathForRow:0 inSection:2];
    
    [_mTable selectRowAtIndexPath:_lastPath2 animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    [self getData];
    
}
-(void)getData
{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    MoneyExchangeListModel *model=[[MoneyExchangeListModel alloc] init];
    [model MoneyExchangeListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            MoneyExchangeListModel *model=(MoneyExchangeListModel *)data;
            money=model.data.coin;
            
            self->dataArr =[NSMutableArray arrayWithArray:model.data.list];
            
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        [self->_mTable reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.navigationItem setTitle:@"银两"];
    
}

- (void)createNav {
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setBackgroundColor:[UIColor clearColor]];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)lefthBtnClick
{
    if (self.presentingView) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        
        BOOL isExit=NO;
        for(UIViewController *temp in self.navigationController.viewControllers) {
            if([temp isKindOfClass:[WAInRoom class]]){
                isExit=YES;
                [self.navigationController popToRootViewControllerAnimated:YES];
                break;
            }
            
        }
        if(isExit==NO)
        {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    else if (section==1)
    {
        return dataArr.count;
    }
    else
    {
        return arr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section==2) {
        return 40;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return @"选择支付方式";
    }
    else
    {
        return @"";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if ([_type isEqualToString:@"1"]) {
            return 0.01;
        }
        return 184;
    }
    else if (indexPath.section==1)
        return 55;
    else
        return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        WAMoneyTittleCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMoneyTittleCell" forIndexPath:indexPath];
        if ([_type isEqualToString:@"1"]) {
            cell.hidden=YES;
        }
        else
        {
            cell.hidden=NO;
        }
        cell.moneyLab.text=money;
        __weak typeof(self) WeakSelf = self;
        cell.wAMoneyTittleCellBtnBlock = ^{
            __strong typeof(WeakSelf) StrongSelf = WeakSelf;
            [StrongSelf moneyListPress];
        };
        
        return cell;
    }
    else if (indexPath.section==1)
    {
        WAMoneyListCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMoneyListCell" forIndexPath:indexPath];
        
        MoneyExchangeListModel *model= dataArr[indexPath.row];
        
        [ cell.head_icon sd_setImageWithURL:[NSURL URLWithString:model.prizeImg]
                           placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        cell.priceLab.text=[NSString stringWithFormat:@"¥%@",model.price];
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@两再送%@两",model.coinsNumber,model.giftNumber]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:navigationColor range:NSMakeRange(model.coinsNumber.length+1,model.giftNumber.length+3)];
        
        cell.nameLab.attributedText = AttributedStr;
        
        if (_lastPath1==nil) {
            ;
        }
        else
        {
            if (_lastPath1.row==indexPath.row) {
                cell.view_back.layer.borderColor =[UIColor colorWithRed:252/255.0 green:73/255.0 blue:155/255.0 alpha:1].CGColor;
                cell.view_back.backgroundColor=[UIColor colorWithRed:253/255.0 green:230/255.0 blue:248/255.0 alpha:1];
            }
            else
            {
                cell.view_back.layer.borderColor =[UIColor clearColor].CGColor;
                cell.view_back.backgroundColor=[UIColor whiteColor];
            }
        }
        return cell;
    }
    else
    {
        WAMoneyPayCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMoneyPayCell" forIndexPath:indexPath];
        NSDictionary *dic=arr[indexPath.row];
        cell.ima_pay.image=[UIImage imageNamed:dic[@"payIma"]];
        cell.lab_payName.text=dic[@"payName"];
        
        if (_lastPath2==nil) {
            ;
        }
        else{
            if (_lastPath2.row==indexPath.row) {
                cell.ima_state.image=[UIImage imageNamed:@"支付选中"];
                
            }
            
            else
            {
                
                cell.ima_state.image=[UIImage imageNamed:@"支付未选"];
                
            }
            
        }
        
        return cell;
    }
    
    
}
-(void)moneyListPress
{
    WAMoneyPayList *list=[WAMoneyPayList alloc];
    list.flag=@"1";
    [self.navigationController pushViewController:list animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int newRow =(int) [indexPath row];
    
    if(indexPath.section==1)
    {
        int oldRow = (int) ((_lastPath1 !=nil)?[_lastPath1 row]:-1);
        if (newRow != oldRow) {
            WAMoneyListCell *newcell=[tableView cellForRowAtIndexPath:indexPath];
            newcell.view_back.layer.borderColor =[UIColor colorWithRed:252/255.0 green:73/255.0 blue:155/255.0 alpha:1].CGColor;
            newcell.view_back.backgroundColor=[UIColor colorWithRed:253/255.0 green:230/255.0 blue:248/255.0 alpha:1];
            //   newcell.isChoosed=YES;
            
            WAMoneyListCell *oldCell=[tableView cellForRowAtIndexPath:_lastPath1];
            oldCell.view_back.layer.borderColor =[UIColor clearColor].CGColor;
            oldCell.view_back.backgroundColor=[UIColor whiteColor];
            //  oldCell.isChoosed=NO;
            _lastPath1 = indexPath;
        }
        
        
    }
    if (indexPath.section==2) {
        int oldRow =(int)( (_lastPath2 !=nil)?[_lastPath2 row]:-1);
        if (newRow != oldRow) {
            WAMoneyPayCell *newcell = [tableView cellForRowAtIndexPath:indexPath];
            newcell.ima_state.image=[UIImage imageNamed:@"支付选中"];
            
            WAMoneyPayCell *oldCell = [tableView cellForRowAtIndexPath:_lastPath2];
            oldCell.ima_state.image=[UIImage imageNamed:@"支付未选"];
            _lastPath2 = indexPath;
            
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section==2)
    {
        UIView * timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,ScreenW, 40)];
        timeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(8, 0,  ScreenW-16, 40)];
        [timeView addSubview:name];
        name.text = @"  选择支付方式";
        name.textColor = WordColor;
        name.font = [UIFont systemFontOfSize:14];
        name.backgroundColor=[UIColor whiteColor];
        
        return timeView;
    }
    
    return nil;
}
- (IBAction)chargBtnPress:(id)sender {
    
    
    NSDictionary *dic=arr[_lastPath2.row];
    
    if ([dic[@"payType"] isEqualToString:@"1"]||[dic[@"payType"] isEqualToString:@"2"]) {
        [self showTypeComing];
    }
    
    else
    {
        SUserSetting * set = [[SUserSetting alloc] init];
        [set sUserSettingSuccess:^(NSString *code, NSString *message, id data) {
            SUserSetting * set = (SUserSetting *)data;
            if ([set.data.is_pay_password integerValue] == 0) {
                [MBProgressHUD showError:@"请先设置支付密码" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
                    logPass.type = YES;
                    logPass.set_type = NO;
                    [self.navigationController pushViewController:logPass animated:YES];
                });
            } else {
                [self showTypeComing];
            }
        } andFailure:^(NSError *error) {
        }];
    }
}
-(void)showTypeComing
{
    NSDictionary *dic=arr[_lastPath2.row];
    if ([dic[@"payType"] isEqualToString:@"1"]||[dic[@"payType"] isEqualToString:@"2"]) {
        
    }
    else
    {
        
        if (payPass_isno == NO) {
            SPay_Pass * pass = [[SPay_Pass alloc] init];
            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self.navigationController presentViewController:pass animated:YES completion:nil];
            pass.SPay_Pass_back = ^{
                payPass_isno = YES;
                [self chargBtnPress:nil];
            };
            pass.SPay_Pass_set = ^{
                SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
                logPass.type = YES;
                logPass.set_type = NO;
                [self.navigationController pushViewController:logPass animated:YES];
            };
            return;
        }
        payPass_isno = NO;
        
        MoneyExchangeListModel *model= dataArr[_lastPath1.row];
        
        [MBProgressHUD showMessage:@"" toView:self.view];
        MoneyExchangeListModel *summodel=[[MoneyExchangeListModel alloc] init];
        summodel.pay_type=dic[@"payType"];
        summodel.coid=model.coId;
        
        [summodel MoneyExchangeModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self lefthBtnClick];
                
            });
            
        } andFailure:^(NSError * _Nonnull error) {
            
            [MBProgressHUD hideHUDForView:self.view animated:NO];
            [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
        }];}
}

@end

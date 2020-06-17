//
//  WAMineGameDetailApply.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMineGameDetailApply.h"
#import "WAMineGameDetailApplyCell.h"
#import "AppealApplyModel.h"
#import "AppealApplyRequstModel.h"
@interface WAMineGameDetailApply ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property(nonatomic,strong)NSIndexPath *lastPath1;
@end

@implementation WAMineGameDetailApply

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"申诉原因";
  
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.layer.cornerRadius = 15;
    _sureBtn.layer.borderWidth = 0.1;
    _sureBtn.layer.borderColor =[UIColor clearColor].CGColor;
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WAMineGameDetailApplyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMineGameDetailApplyCell"];
    
 
    [self getData];
    _lastPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_mTable selectRowAtIndexPath:_lastPath1 animated:YES scrollPosition:UITableViewScrollPositionNone];
}
-(void)getData
{
     [MBProgressHUD showMessage:nil toView:self.view];
    AppealApplyModel *model=[[AppealApplyModel alloc]init];
    [model AppealApplyModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            AppealApplyModel *model=(AppealApplyModel *)data;
            arr=[NSMutableArray arrayWithArray:model.data];
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];

        }
        
        [_mTable reloadData];
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WAMineGameDetailApplyCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMineGameDetailApplyCell" forIndexPath:indexPath];
    AppealApplyModel *model=arr[indexPath.row];
    cell.nameLab.text=model.value;
    if (_lastPath1.row==indexPath.row) {
        cell.flagImaView.image=[UIImage imageNamed:@"支付选中"];
    }
    else
    {
        cell.flagImaView.image=[UIImage imageNamed:@"支付未选"];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int newRow =(int) [indexPath row];
    int oldRow =(int)( (_lastPath1 !=nil)?[_lastPath1 row]:-1);
    if (newRow != oldRow) {
        WAMineGameDetailApplyCell * newcell = (WAMineGameDetailApplyCell *)[tableView cellForRowAtIndexPath:indexPath];
        newcell.flagImaView.image=[UIImage imageNamed:@"支付选中"];
        
        WAMineGameDetailApplyCell *oldCell = [tableView cellForRowAtIndexPath:_lastPath1];
        oldCell.flagImaView.image=[UIImage imageNamed:@"支付未选"];
        _lastPath1 = indexPath;
        
    }
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (IBAction)submitPress:(id)sender {
    if (_lastPath1==nil) {
         [MBProgressHUD showSuccess:@"请选择申诉原因" toView:self.view];
        return;
    }
    else
    {
        [MBProgressHUD showMessage:nil toView:self.view];
        AppealApplyModel *model=arr[_lastPath1.row];
        AppealApplyRequstModel *index=[[AppealApplyRequstModel alloc]init];
        index.id=_idStr;
        index.type=model.k;
        [index AppealApplyRequstModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              [MBProgressHUD showSuccess:message toView:self.view];
            if ([code intValue]==200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  
                    [self.navigationController popViewControllerAnimated: YES];
                });
                
            }
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            

        }];
    }
    
}


@end

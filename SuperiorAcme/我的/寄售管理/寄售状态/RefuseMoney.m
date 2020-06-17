//
//  RefuseMoney.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/11.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "RefuseMoney.h"
#import "RefuseMoneyModel.h"
#import "WAMineGameDetailApplyCell.h"
#import "RefuseDescCell.h"
@interface RefuseMoney ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    NSArray *arr;
    NSString *reason_desc;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@property(nonatomic,strong)NSIndexPath *lastPath1;

@end

@implementation RefuseMoney

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"退款";
    reason_desc= @"请输入退款原因~";
 
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WAMineGameDetailApplyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMineGameDetailApplyCell"];
       [_mTable registerNib:[UINib nibWithNibName:@"RefuseDescCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RefuseDescCell"];
    
    [self getData];
    _lastPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_mTable selectRowAtIndexPath:_lastPath1 animated:YES scrollPosition:UITableViewScrollPositionNone];
}

-(void)getData
{
    [MBProgressHUD showMessage:nil toView:self.view];
    RefuseMoneyModel *model=[[RefuseMoneyModel alloc]init];
    [model RefuseMoneyListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==1) {
            RefuseMoneyModel *model=(RefuseMoneyModel *)data;
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
    
  if (indexPath.section==0) {
        WAMineGameDetailApplyCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMineGameDetailApplyCell" forIndexPath:indexPath];
        RefuseMoneyModel *model=arr[indexPath.row];
        cell.nameLab.text=model.title;
        if (_lastPath1.row==indexPath.row) {
            cell.flagImaView.image=[UIImage imageNamed:@"支付选中"];
        }
        else
        {
            cell.flagImaView.image=[UIImage imageNamed:@"支付未选"];
        }
        return cell;
    }
    else
    {
        RefuseDescCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"RefuseDescCell" forIndexPath:indexPath];
        cell.desc_tf.text=reason_desc;
        cell.desc_tf.delegate=self;
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
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
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
     return arr.count;
      
    } else {
        return 1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath. section==0) {
      return 44;
    } else {
        return 116;
    }
   
}
- (IBAction)submitPress:(id)sender {
    if (_lastPath1==nil) {
        [MBProgressHUD showSuccess:@"请选择退款原因" toView:self.view];
        return;
    }
    else
    {
        [MBProgressHUD showMessage:nil toView:self.view];
        RefuseMoneyModel *model=arr[_lastPath1.row];
        RefuseMoneyModel *index=[[RefuseMoneyModel alloc]init];
        index.clean_id=_order_id;
        index.type=@"1";
        index.goods_num=_goods_num;
        index.cause_id=model.cause_id;
        index.reason_desc=reason_desc;
        [index RefuseMoneyModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showSuccess:message toView:self.view];
            if ([code intValue]==1) {
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
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    reason_desc=textView.text;
    [_mTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入退款原因~"]) {
        textView.text=@"";
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    
    return YES;
    
}
@end

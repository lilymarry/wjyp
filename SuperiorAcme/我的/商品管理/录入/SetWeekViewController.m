//
//  SetWeekViewController.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "SetWeekViewController.h"
#import "SetWeekCell.h"
#import "SetWeekTopCell.h"
@interface SetWeekViewController ()<SetWeekCellDelegate,UITableViewDelegate,UITableViewDataSource>
{
    // NSMutableArray *arr;
     NSArray *tittleArr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SetWeekViewController
-(id)initWithBlock:(SetWeekFinishBlock)ablock
{
    if (self=[super init]) {
        
        _block=[ablock copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_arr.count==0) {
        _arr=[NSMutableArray arrayWithObjects:@{@"price":@"",@"jiesuan_price":@""}, @{@"price":@"",@"jiesuan_price":@""},@{@"price":@"",@"jiesuan_price":@""},@{@"price":@"",@"jiesuan_price":@""},@{@"price":@"",@"jiesuan_price":@""},@{@"price":@"",@"jiesuan_price":@""},@{@"price":@"",@"jiesuan_price":@""},
             nil];
    }
 
   
//    tittleArr=[NSArray arrayWithObjects:@{@"tittle":@"星期一售价",@"Sub_tittle":@"星期一结算价"},@{@"tittle":@"星期二售价",@"Sub_tittle":@"星期二结算价"},@{@"tittle":@"星期三售价",@"Sub_tittle":@"星期三结算价"},@{@"tittle":@"星期四售价",@"Sub_tittle":@"星期四结算价"},@{@"tittle":@"星期五售价",@"Sub_tittle":@"星期五结算价"},@{@"tittle":@"星期六售价",@"Sub_tittle":@"星期六结算价"},@{@"tittle":@"星期日售价",@"Sub_tittle":@"星期日结算价"},
//         nil];
    
   tittleArr=[NSArray arrayWithObjects:@{@"tittle":@"星期一",@"Sub_tittle":@"星期一结算价"},@{@"tittle":@"星期二",@"Sub_tittle":@"星期二结算价"},@{@"tittle":@"星期三",@"Sub_tittle":@"星期三结算价"},@{@"tittle":@"星期四",@"Sub_tittle":@"星期四结算价"},@{@"tittle":@"星期五",@"Sub_tittle":@"星期五结算价"},@{@"tittle":@"星期六",@"Sub_tittle":@"星期六结算价"},@{@"tittle":@"星期日",@"Sub_tittle":@"星期日结算价"},
           nil];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SetWeekCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SetWeekCell"];
       [_mTable registerNib:[UINib nibWithNibName:@"SetWeekTopCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SetWeekTopCell"];
      self.title=@"星期范围";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{return 2;}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 54;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else
    {
        return tittleArr.count;}
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath. section==0) {
       SetWeekTopCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"SetWeekTopCell" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        SetWeekCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"SetWeekCell" forIndexPath:indexPath];
        NSDictionary *tittleDic=tittleArr[indexPath.row];
        NSDictionary *dic1=_arr[indexPath.row];
        
        cell.tittleLab.text=tittleDic[@"tittle"];
      //  cell.subTittleLab.text=tittleDic[@"Sub_tittle"];
        cell.contextTf.text=dic1[@"price"];
        cell.subContextTf.text=dic1[@"jiesuan_price"];
        
        cell.index=indexPath.row;
        cell.delgate=self;
        
        return cell;
    }
    
    
}


- (IBAction)savePress:(id)sender {
    
    
    for (int i=0;i<_arr.count;i++) {
        NSDictionary *dic=_arr[i];
        
        if ([self checkPriceNullMerchantCate:dic]==YES) {
             [MBProgressHUD showError:[NSString stringWithFormat:@"%@售卖价或结算价为空",tittleArr[i][@"tittle"]] toView:self.view];
            return;
        }
       else if ([dic[@"jiesuan_price"] doubleValue]>[dic[@"price"]  doubleValue]*[_MerchantCate doubleValue]) {
             [MBProgressHUD showError:[NSString stringWithFormat:@"%@结算价过高",tittleArr[i][@"tittle"]] toView:self.view];
            return ;
        }
     
    }
        if (_block)
        {
          
            _block(_arr,_type);
        }
        [self.navigationController popViewControllerAnimated:YES];

}
-(BOOL)checkPriceNullMerchantCate:(NSDictionary *)dic
{
    if (( [dic[@"jiesuan_price"] length]>0&& [dic[@"price"] length]==0)||( [dic[@"jiesuan_price"] length]==0&& [dic[@"price"] length]>0)) {
        return YES;
    }
    else
    {
        return NO;
    }
  
}
//-(BOOL)checkPriceMerchantCate
//{
//    for (NSDictionary *dic in _arr) {
//        if ([dic[@"jiesuan_price"] doubleValue]>[dic[@"price"]  doubleValue]*[_MerchantCate doubleValue]) {
//            return YES;
//        }
//    }
//    return NO;
//}
-(void)setWeekCell:(NSDictionary *)dict index:(NSInteger)index
{
    [_arr replaceObjectAtIndex:index withObject:dict];
    [_mTable reloadData];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

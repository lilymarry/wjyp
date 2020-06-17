//
//  AddAttr_name.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/14.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddAttr_name.h"
#import "AddAttr_nameCell.h"
#import "AddAttr_nameFootCell.h"
#import "AttrNameModle.h"
@interface AddAttr_name ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,AddAttr_nameCellDelegate>
{
  
    NSDictionary *dic;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation AddAttr_name
-(id)initWithBlock:(AddAttr_nameFinishBlock)ablock
{
    if (self=[super init]) {
        
        _block=[ablock copy];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_arr.count<=0) {
         _arr=[NSMutableArray array];
    }
   
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"AddAttr_nameCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddAttr_nameCell"];
     [_mTable registerNib:[UINib nibWithNibName:@"AddAttr_nameFootCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddAttr_nameFootCell"];
    
 dic=@{@"attr_id":@"",@"name":@"",@"price":@"",@"jiesuan_price":@""};
    if (_goods_id.length!=0) {
          [self getData];
    }
       self.title=@"组合商品";
   
}
-(void)getData
{
    [MBProgressHUD showMessage:nil toView:self.view];
    AttrNameModle *model=[[AttrNameModle alloc]init];
    model.goods_id=_goods_id;
    [model AttrNameModleSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, NSArray * _Nonnull arr) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==1) {
            _arr=[NSMutableArray arrayWithArray:arr];
            [_mTable reloadData];
        }
        else
        {
            [MBProgressHUD showSuccess:message toView:self.view];

        }
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(void)AddAtt_name
{
    [_arr addObject:dic];
    [_mTable reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section==0) {
          return 151;
    }
    else
    {
        return 50;
    }
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
         return _arr.count;
    }
    else
    {
        return 1;
    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        AddAttr_nameCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"AddAttr_nameCell" forIndexPath:indexPath];
        [cell reloadDic:_arr[indexPath.row]];
        
        cell.guigeNameLab.text=[NSString stringWithFormat:@"组合商品%d",(int)indexPath.row+1];
        
        cell.delgate=self;
        cell.index=indexPath.row;
        
        return cell;
    }
    else
    {
       AddAttr_nameFootCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"AddAttr_nameFootCell" forIndexPath:indexPath];
       [ cell.AddBtn addTarget:self action:@selector(AddAtt_name) forControlEvents:UIControlEventTouchUpInside];
        [ cell.AddBtn setTitle:@"+ 添加组合商品" forState:UIControlStateNormal];
        return cell;
    }
 
   
  
}

-(void)AddAttr_nameCell:(NSDictionary *)dict index:(NSInteger)index
{
    
    [_arr replaceObjectAtIndex:index withObject:dict];
    [_mTable reloadData];
}
-(void)deleAttr_nameCellIndex:(NSInteger)index
{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除此规格" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *dic=_arr[index];
        if ([dic[@"attr_id"] length]==0) {
              [_arr removeObjectAtIndex:index];
              [_mTable reloadData];
        }
        else
        {
            [self delectArrNameWithAttr_id:dic[@"attr_id"]];
        }
     
        
      
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (IBAction)savePress:(id)sender {
   
    for (int i=0;i<_arr.count;i++) {
        NSDictionary *dic=_arr[i];
        
        if ([dic[@"name"]  length]==0) {
           [MBProgressHUD showError:[NSString stringWithFormat:@"请输入组合商品%d的名称",i+1] toView:self.view];
            return;
            
        }
        
       else  if (([dic[@"jiesuan_price"]  length]==0)||([dic[@"price"]  length]==0)) {
         [MBProgressHUD showError:[NSString stringWithFormat:@"组合商品%d售卖价或结算价为空",i+1]toView:self.view];
            return;
            
        }
        
        else if ([dic[@"jiesuan_price"] doubleValue]>[dic[@"price"]  doubleValue]*[_MerchantCate doubleValue]) {
            [MBProgressHUD showError:[NSString stringWithFormat:@"组合商品%d结算价过高",i+1] toView:self.view];
            return ;
        }
        
    }
    
//
//
//    if ([self checkArrName]) {
//      [MBProgressHUD showError:@"" toView:self.view];
//        return;
//    }
//    else if ([self checkNullArrName]==YES) {
//        [MBProgressHUD showError:@"结算价或售卖价为空" toView:self.view];
//        return;
//    }
//   else if ([self checkPriceMerchantCate]==YES) {
//        [MBProgressHUD showError:@"结算价过高" toView:self.view];
//       return;
//    }
//
//    else
//    {
        if (_goods_id.length==0) {
            if (_block)
            {
                _block(_arr);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            AttrNameModle *model=[[AttrNameModle alloc]init];
            model.goods_id=_goods_id;
            model.sta_mid=_sta_mid;
            model.attr=_arr;
             [MBProgressHUD showMessage:nil toView:self.view];
            [model UpdateAttrNameModleSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [MBProgressHUD showSuccess:message toView:self.view];
                if ([code intValue]==1) {
                    if (_block)
                    {
                        _block(_arr);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
                
            } andFailure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
       
  //  }
   
}
//-(BOOL)checkArrName
//{
//    for (NSDictionary *dic in _arr) {
//        if ([dic[@"name"]  length]==0) {
//            return YES;
//
//        }
//    }
//    return NO;
//}
//-(BOOL)checkPriceMerchantCate
//{
//    for (NSDictionary *dic in _arr) {
//        if ([dic[@"jiesuan_price"] doubleValue]>[dic[@"price"]  doubleValue]*[_MerchantCate doubleValue]) {
//            return YES;
//        }
//    }
//    return NO;
//}
//-(BOOL)checkNullArrName
//{
//    for (NSDictionary *dic in _arr) {
//        if (([dic[@"jiesuan_price"]  length]==0)||([dic[@"price"]  length]==0)) {
//            return YES;
//
//        }
//    }
//    return NO;
//}
-(void)delectArrNameWithAttr_id:(NSString *)attr_id
{
   
    AttrNameModle *model=[[AttrNameModle alloc]init];
    model.goods_id=_goods_id;
    model.sta_mid=_sta_mid;
    model.attr_id=attr_id;
     [MBProgressHUD showMessage:nil toView:self.view];
    [model DeleteAttrNameModleSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showSuccess:message toView:self.view];
        if ([code intValue]==1) {
               [self getData];
        }
      
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}


@end

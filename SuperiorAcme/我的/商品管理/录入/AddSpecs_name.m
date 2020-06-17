//
//  AddSpecs_name.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/15.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddSpecs_name.h"
#import "AddSpecs_nameTittleCell.h"
#import "AddSpecs_nameCell.h"
#import "AddSpecs_nameContentCell.h"
#import "AddAttr_nameFootCell.h"
#import "Specs_nameModel.h"
@interface AddSpecs_name ()<UITextFieldDelegate,AddSpecs_nameCellDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *dic;
 
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation AddSpecs_name


-(id)initWithBlock:(AddSpecs_nameFinishBlock)ablock
{
    if (self=[super init]) {
        
        _block=[ablock copy];
    }
    return self;
}

-(id)initWithModiyBlock:(ModiySpecs_nameFinishBlock)ablock
{
    if (self=[super init]) {
        
        _ModiyBlock=[ablock copy];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"AddSpecs_nameTittleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddSpecs_nameTittleCell"];
    
    [_mTable registerNib:[UINib nibWithNibName:@"AddSpecs_nameCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddSpecs_nameCell"];
    
    [_mTable registerNib:[UINib nibWithNibName:@"AddSpecs_nameContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddSpecs_nameContentCell"];
    
     [_mTable registerNib:[UINib nibWithNibName:@"AddAttr_nameFootCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddAttr_nameFootCell"];
    dic=@{@"b_id":@"",@"name":@""};
   if (_arr==nil) {
        _arr=[NSMutableArray array];

   }
    self.title=@"添加属性";
}

-(void)AddAtt_name
{
    [_arr addObject:dic];
 
    [_mTable reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  4;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2) {
        return _arr.count;
    }
    else
    {
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        AddSpecs_nameTittleCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"AddSpecs_nameTittleCell" forIndexPath:indexPath];
        cell.tittleTf.text=_tittle;
        cell.tittleTf.tag=10000;
        cell.tittleTf.delegate=self;
        return cell;
    }
  else  if (indexPath.section==1) {
        AddSpecs_nameCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"AddSpecs_nameCell" forIndexPath:indexPath];
        return cell;
    }
  else  if (indexPath.section==2) {
      AddSpecs_nameContentCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"AddSpecs_nameContentCell" forIndexPath:indexPath];
      [cell reloadData:_arr[indexPath.row]];
      cell.delgate=self;
      cell.index=indexPath.row;
      
        return cell;
    }
    else
    {
        AddAttr_nameFootCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"AddAttr_nameFootCell" forIndexPath:indexPath];
        [ cell.AddBtn addTarget:self action:@selector(AddAtt_name) forControlEvents:UIControlEventTouchUpInside];
        [cell.AddBtn setTitle:@"+ 添加标签" forState:UIControlStateNormal];
        return cell;
    }
    
    
    
}

-(void)AddSpecs_nameCell:(NSDictionary *)dict index:(NSInteger)index
{
    
    [_arr replaceObjectAtIndex:index withObject:dict];
 
    [_mTable reloadData];
}
-(void)deleSpecs_nameIndex:(NSInteger)index
{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除此标签" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *dic= _arr[index];
        if ([dic[@"bid"] length]!=0) {
            Specs_nameModel *model=[[Specs_nameModel alloc]init];
            model.b_id=dic[@"bid"];
            model.sta_mid=_sta_mid;
             [MBProgressHUD showMessage:nil toView:self.view];
            [model DeleteSpecs_nameBidModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
                   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                if ([code intValue]==1) {
                    [_arr removeObjectAtIndex:index];
                    [_mTable reloadData];
                    
                }
//                else
//                {
//                    [MBProgressHUD showError:message toView:self.view];
//
//                }
            } andFailure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
        else
        {
            [_arr removeObjectAtIndex:index];
            [_mTable reloadData];
        }
        
      
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (IBAction)savePress:(id)sender {
    
    if (_tittle.length==0) {
        [MBProgressHUD showError:@"请输入属性名称" toView:self.view];
    }
   else if ([[self deletNullData] count]==0) {
        [MBProgressHUD showError:@"请至少输入一种属性标签" toView:self.view];
    }
    else
    {
        if (_pid.length==0) {
            _pid=@"";
        }
        NSArray *dataArr=[self deletNullData];
        if (_goods_id.length!=0) {
             NSDictionary *dict=@{@"pid":_pid,@"title":_tittle,@"break_down":[self ArrToJSONString:dataArr]};
            Specs_nameModel *model=[[Specs_nameModel alloc]init];
            model.goods_id=_goods_id;
            model.goods_property=dict;
             [MBProgressHUD showMessage:nil toView:self.view];
            [model UpdateSpecs_nameModleSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                if ([code intValue]==1) {
                      [MBProgressHUD showSuccess:message toView:self.view];
                    if ([_type isEqualToString:@"1"]) {
                        if (_block) {
                            _block(dict);
                        }
                    }
                    else
                    {
                        [self deletShuxing:dict index:_index];
                       
                    }
                   
                    [self.navigationController popViewControllerAnimated:YES];
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
        
        else{
            NSDictionary *dict=@{@"pid":_pid,@"title":_tittle,@"break_down":dataArr};
            if ([_type isEqualToString:@"1"]) {
                if (_block) {
                    _block(dict);
                }
               
            }
            else
            {
                if (_ModiyBlock) {
                    _ModiyBlock(dict,_index);
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

-(NSArray *)deletNullData
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:_arr];
    [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *name = (NSDictionary*)obj;
        if([name[@"name"] length]==0){
            [array removeObject:obj];
        }
    }];

    return  array;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if ( textField.tag==10000) {
        _tittle=textField.text;
    }
    [_mTable reloadData];
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    return YES;
    
}

- (NSString *)ArrToJSONString:(NSArray  *)arr
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                       options:kNilOptions
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}
-(void)deletShuxing:(NSDictionary *)dic index:(NSInteger) index
{
    Specs_nameModel *model=[Specs_nameModel alloc];
    model.p_id=dic[@"pid"];
 
    [model DeleteSpecs_nameModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
      //  [MBProgressHUD showSuccess:message toView:self.view];
        if ([code intValue]==1) {
            if (_ModiyBlock) {
                _ModiyBlock(dic,index);
            }
        }
        else
        {
             [MBProgressHUD showSuccess:message toView:self.view];
        }
    
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
    
}
@end

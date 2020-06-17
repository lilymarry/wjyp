//
//  Specs_nameDetail.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/20.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "Specs_nameDetail.h"
#import "Specs_nameDetailCell.h"
#import "Specs_nameModel.h"
#import "AddAttr_nameFootCell.h"
#import "AddSpecs_name.h"


@interface Specs_nameDetail ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation Specs_nameDetail

-(id)initWithBlock:(Specs_nameDetailFinishBlock)ablock
{
    if (self=[super init]) {
        
        _block=[ablock copy];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"Specs_nameDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Specs_nameDetailCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"AddAttr_nameFootCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddAttr_nameFootCell"];
    
    if (_goods_id.length!=0) {
        [self getData];
    }
      self.title=@"属性";
}
-(void)getData
{
    [MBProgressHUD showMessage:nil toView:self.view];

    Specs_nameModel *model=[[Specs_nameModel alloc]init];
    model.goods_id=_goods_id;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    [model Specs_nameModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, NSArray * _Nonnull data) {
        if ([code intValue]==1) {
            _arr=[NSMutableArray arrayWithArray:data];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 99;
    }
    else
    {
        return 44;
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
        Specs_nameDetailCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"Specs_nameDetailCell" forIndexPath:indexPath];
        NSDictionary *dic=_arr[indexPath.row];
        if (_goods_id.length!=0) {
            cell.tittleLab.text=dic[@"prop_title"];
            cell.subTittleLab.text=dic[@"taste_name"];
        }
        else
        {
            cell.tittleLab.text=dic[@"title"];
            cell.subTittleLab.text=[self lineSubTittle:dic];
        }
        
        cell.deleBtn.tag=indexPath.row;
        cell.modyBtn.tag=indexPath.row;
        [cell.deleBtn addTarget:self action:@selector(deletPress:) forControlEvents:UIControlEventTouchUpInside];
        [cell.modyBtn addTarget:self action:@selector(modyPress:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else
    {
        AddAttr_nameFootCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"AddAttr_nameFootCell" forIndexPath:indexPath];
        [ cell.AddBtn addTarget:self action:@selector(AddAtt_name) forControlEvents:UIControlEventTouchUpInside];
        [cell.AddBtn setTitle:@"+ 添加属性" forState:UIControlStateNormal];
        return cell;
    }
    
    
}
-(void)AddAtt_name
{
    AddSpecs_name  *to=[[AddSpecs_name alloc]initWithBlock:^(NSDictionary *dict)
                        {
                            if (_goods_id.length!=0) {
                                [self getData];
                            }
                            else
                            {
                                [_arr addObject:dict];
                                [_mTable reloadData];
                            }
                        }];
    to.goods_id=_goods_id;
     to.type=@"1";
    to.sta_mid=_sta_mid;
    [self.navigationController pushViewController:to animated:YES];
    
}
- (IBAction)savePress:(id)sender {
    if (_block)
    {
        _block(_arr);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)deletPress:(UIButton *)but
{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除此属性" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (_goods_id.length==0) {
            [_arr removeObjectAtIndex:but.tag];
        }
        else{
            
            NSDictionary *dic=_arr[but.tag];
            
            [self deletShuxing:dic[@"p_id"]];
        }
        [_mTable reloadData];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
-(void)modyPress:(UIButton *)but
{
    NSDictionary *dic=_arr[but.tag];
    
    AddSpecs_name  *to=[[AddSpecs_name alloc]initWithModiyBlock:^(NSDictionary *dict,NSInteger index)
                        {
                            if (_goods_id.length!=0) {
                                [self getData];
                            }
                            else
                            {
                                [_arr replaceObjectAtIndex:index withObject:dict];
                                [_mTable reloadData];
                            }
                        }];
    
    if (_goods_id.length!=0) {
        to.goods_id=_goods_id;
        to.pid=dic[@"p_id"];
        to.tittle=dic[@"prop_title"];
        
        NSMutableArray *data=[NSMutableArray array];
        for (int i=0; i< [dic[@"taste"] count];i++) {
            NSDictionary *dict1=dic[@"taste"][i];
            NSDictionary *dict=@{@"bid":dict1[@"id"],@"name":dict1[@"title"]};
            [data addObject:dict];
        }
        to.sta_mid=_sta_mid;
        to.arr=[NSMutableArray arrayWithArray:data];
    }
    else
    {
        to.tittle=dic[@"title"];
        to.index=but.tag;
        to.arr=[NSMutableArray arrayWithArray:dic[@"break_down"]];
    }
    
    to.type=@"2";
    [self.navigationController pushViewController:to animated:YES];
    
}
-(void)deletShuxing:(NSString *)pid
{
    Specs_nameModel *model=[Specs_nameModel alloc];
    model.p_id=pid;
    [MBProgressHUD showMessage:nil toView:self.view];
    [model DeleteSpecs_nameModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
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
-(NSString *)lineSubTittle:(NSDictionary *)dic
{
    NSMutableString *str=[NSMutableString string];
    NSArray *arr=dic[@"break_down"];
    for (int i=0; i<arr.count; i++) {
        [str appendString:arr[i][@"name"]];
        if (i!=arr.count-1) {
            [str appendString:@"/"];
        }
    }
    return str;
    
    
}

@end

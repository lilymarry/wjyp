//
//  AddGoodListViewController.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/13.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddGoodListViewController.h"
#import "Goods_infoModel.h"
#import "AddGoodList_headCell.h"
#import "AddGoodList_Cell.h"
#import "GoodsManagerItemList.h"
#import "AddAttr_name.h"
#import "AddSpecs_name.h"
#import "SPhotoVC.h"
#import "SelectLabView.h"
#import "SetDateViewController.h"
#import "SetWeekViewController.h"
#import "AddAppStageGoodS.h"
#import "Specs_nameDetail.h"
#import "GetGoodsSale.h"
#import "GetMerchantCate.h"
#import "CommonHelp.h"
@interface AddGoodListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    NSString *sup_type;////商品类型 1外卖 2堂食 3全部
    NSString *name;//商品名称
    NSString *cate_name;//分类名称
    NSString *cate_id;
    
    NSString *shop_price;//外卖价格
    NSString *shop_jiesuan_price;//外卖结算价
    NSString *church_shop_price;//堂食价格
    NSString *church_jiesuan_shop_price;//堂食结算价格
    
    NSString *boxware;////餐盒数量
    NSString *attr_name;////规格
    
   AddGoodList_headCell * headCell;
  
    
    NSString *specs_name;
    UIImagePickerController * _imagePickerPhoto;
    UIImagePickerController * _imagePickerCamera;
    
    UIImage *image;
    NSString *lab;//特色标签
    
    NSString *waimaiTime;//外卖时间选择
    NSString *tangshiTime;//堂食时间选择
    
    NSString * isWamaiType;
    NSString * isTangshiType;
    
    NSArray* Attr_nameArr;
    NSArray* Specs_nameArr;
    
    NSArray *  week_priceArr;
    NSArray * church_week_priceArr;
    
    NSDictionary * time_priceDic;
    NSDictionary * church_time_priceDic;
    
    NSString * desc;
    
    NSString * limit;
    NSString *reason;
    NSString * status;
    
    NSString *sellNum;
    NSString *MerchantCate;//结算比例
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIView *butView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *butViewHHH;


@end

@implementation AddGoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _mTable.rowHeight = UITableViewAutomaticDimension;
    _mTable.estimatedRowHeight = 100;
    
    [_mTable registerNib:[UINib nibWithNibName:@"AddGoodList_headCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddGoodList_headCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"AddGoodList_Cell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddGoodList_Cell"];
    cate_name=@"选择分类";
    waimaiTime=@"不限时间";
    tangshiTime=@"不限时间";
    lab=@"";
    if (_goods_id.length!=0) {
        [self getData];
    }
    else
    {
        sellNum=@"0";
    }
    
    if ([_type  isEqualToString:@"3"]) {
        _butViewHHH.constant=0;
        _butView.hidden=YES;
    }
    
    if ([_type  isEqualToString:@"1"]) {
        self.title=@"录入";
    }
    else{
        self.title=@"商品详情";
        
    }
    //结算比例
     [MBProgressHUD showMessage:nil toView:self.view];
      GetMerchantCate  *cata=[[GetMerchantCate alloc]init];
    cata.sta_mid=_sta_mid;
    [cata GetMerchantCateSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==1) {
            MerchantCate=data;
        }
        else{
            [MBProgressHUD showSuccess:message toView:self.view];
        }
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

-(void)getData
{
    [MBProgressHUD showMessage:nil toView:self.view];
    Goods_infoModel *model=[[Goods_infoModel alloc]init];
    model.goods_id=_goods_id;
    [model Goods_infoModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            
            
            Goods_infoModel *model=(Goods_infoModel *)data;
            sup_type=model.data.sup_type;
            name=model.data.name;
            cate_name= model.data.cate_name;
            shop_price=model.data.shop_price;
            shop_jiesuan_price=model.data.shop_jiesuan_price;
            church_shop_price=model.data.church_shop_price;
            church_jiesuan_shop_price=model.data.church_jiesuan_shop_price;
            boxware=model.data.boxware;
            attr_name=model.data.attr_name;
            cate_id=model.data.cate_id;
           
            reason=model.data.examine_desc;
            status=model.data.status;
            limit=model.data.limit;
            if ([limit isEqualToString:@"0"]) {
                limit=@"不限";
            }
            
            if ([model.data.goods_pic count]>0) {
                
                Goods_infoModel *subModel =model.data.goods_pic[0];
                
                image=[self changePicUrl:subModel.path];
            }
            if ([model.data.week_price count]>0) {
                isWamaiType=@"2";
                week_priceArr=[self changWeekData:model.data.week_price];
                waimaiTime =@"自定义";
            }
            
            if ([model.data.church_week_price count]>0) {
                isTangshiType=@"2";
                church_week_priceArr=[self changWeekData:model.data.church_week_price];
                
                tangshiTime =@"自定义";
            }
            
            
            if (model.data.time_price!=nil ) {
                
                isWamaiType=@"1";
                
                time_priceDic=[self changDateData:model.data.time_price];
                waimaiTime =@"自定义";
                
            }
            
            if (model.data.church_time_price!=nil ) {
                
                isTangshiType=@"1";
                
                church_time_priceDic  =[self changDateData:model.data.church_time_price];
                tangshiTime =@"自定义";
                
            }
            
            specs_name=model.data.specs_name;
            
            
            
            desc=model.data.desc;
            
            if ([model.data.label isEqualToString:@"0"]) {
                lab=@"";
            }
            else  if ([model.data.label isEqualToString:@"1"]) {
                lab=@"招牌";
            }
            else  if ([model.data.label isEqualToString:@"2"]) {
                lab=@"推荐";
            }
            else  {
                lab=@"链店";
            }
            
            
            [_mTable reloadData];

        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        
    }];
    
     [MBProgressHUD showMessage:nil toView:self.view];
    GetGoodsSale *sale=[[GetGoodsSale alloc]init];
    sale.sta_mid=_sta_mid;
    sale.goods_id=_goods_id;
    [sale GetGoodsSaleSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==1) {
          sellNum=[NSString stringWithFormat:@"%@",data];
          //  NSLog(@"ssdsad %@",sellNum);
        }
        else{
            [MBProgressHUD showSuccess:message toView:self.view];
        }
        [_mTable reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
  
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
      return UITableViewAutomaticDimension;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
       headCell = [_mTable dequeueReusableCellWithIdentifier:@"AddGoodList_headCell" forIndexPath:indexPath];
        
        headCell.nameTextField.text=name;
        headCell.cate_nameLab.text=cate_name;
        headCell.shop_priceTextField.text=shop_price;
        headCell.shop_jiesuan_priceTextField.text=shop_jiesuan_price;
        headCell.church_shop_priceTextField.text=church_shop_price;
        headCell.church_jiesuan_shop_priceTextField.text=church_jiesuan_shop_price;
        headCell.boxwareTextField.text=boxware;
        
        headCell.attr_nameLab.text=attr_name;
        headCell.limitTf.text=limit;
        
        if (limit.length==0||[limit isEqualToString:@"不限"]||[limit isEqualToString:@"0"]) {
            headCell.numViewHHH.constant=0;
            headCell.numView.hidden=YES;
            headCell.sellNumView.hidden=YES;
            headCell.sellNumViewHHH.constant=0;
        }
        else
        {
            headCell.numViewHHH.constant=50;
            headCell.numView.hidden=NO;
            headCell.sellNumView.hidden=NO;
            headCell.sellNumViewHHH.constant=50;
      }
        headCell.sellNumTextFeild.text=sellNum;
        headCell.sellNumTextFeild.delegate=self;
        headCell.sellNumTextFeild.enabled=NO;
        
        headCell.numTextFeild.text=[NSString stringWithFormat:@"%d",[limit intValue]-[sellNum intValue]];
        if ([sup_type isEqualToString:@"1"]) {
            headCell.waimaiBtn.selected=YES;
            headCell.tangshiBtn.selected=NO;
            headCell.allBtn.selected=NO;
            
            headCell.church_jiesuan_shop_priceTextFieldView.hidden=YES;
            headCell.church_jiesuan_shop_priceTextFieldHHH.constant=0;
            headCell.church_shop_priceTextFieldView.hidden=YES;
            headCell.church_shop_priceTextFieldHHH.constant=0;
            
            headCell.shop_priceTextFieldView.hidden=NO;
            headCell.shop_priceTextFieldHHH.constant=50;
            headCell.shop_jiesuan_priceTextFieldView.hidden=NO;
            headCell.shop_jiesuan_priceTextFieldHHH.constant=50;
            
            headCell.boxwareView.hidden=NO;
            headCell.boxwareViewHHH.constant=50;
            
            
            
        }
        else if ([sup_type isEqualToString:@"2"])
        {
            headCell.waimaiBtn.selected=NO;
            headCell.tangshiBtn.selected=YES;
            headCell.allBtn.selected=NO;
            
            headCell.church_jiesuan_shop_priceTextFieldView.hidden=NO;
            headCell.church_jiesuan_shop_priceTextFieldHHH.constant=50;
            headCell.church_shop_priceTextFieldView.hidden=NO;
            headCell.church_shop_priceTextFieldHHH.constant=50;
            
            headCell.shop_priceTextFieldView.hidden=YES;
            headCell.shop_priceTextFieldHHH.constant=0;
            headCell.shop_jiesuan_priceTextFieldView.hidden=YES;
            headCell.shop_jiesuan_priceTextFieldHHH.constant=0;
            headCell.boxwareView.hidden=YES;
            headCell.boxwareViewHHH.constant=0;
            
        }
        else if ([sup_type isEqualToString:@"3"])
        {
            headCell.waimaiBtn.selected=NO;
            headCell.tangshiBtn.selected=NO;
            headCell.allBtn.selected=YES;
            headCell.church_jiesuan_shop_priceTextFieldView.hidden=NO;
            headCell.church_jiesuan_shop_priceTextFieldHHH.constant=50;
            headCell.church_shop_priceTextFieldView.hidden=NO;
            headCell.church_shop_priceTextFieldHHH.constant=50;
            
            headCell.shop_priceTextFieldView.hidden=NO;
            headCell.shop_priceTextFieldHHH.constant=50;
            headCell.shop_jiesuan_priceTextFieldView.hidden=NO;
            headCell.shop_jiesuan_priceTextFieldHHH.constant=50;
            headCell.boxwareView.hidden=NO;
            headCell.boxwareViewHHH.constant=50;
        }
        else
        {
            headCell.waimaiBtn.selected=NO;
            headCell.tangshiBtn.selected=NO;
            headCell.allBtn.selected=NO;
            headCell.church_jiesuan_shop_priceTextFieldView.hidden=YES;
            headCell.church_jiesuan_shop_priceTextFieldHHH.constant=0;
            headCell.church_shop_priceTextFieldView.hidden=YES;
            headCell.church_shop_priceTextFieldHHH.constant=0;
            
            headCell.shop_priceTextFieldView.hidden=YES;
            headCell.shop_priceTextFieldHHH.constant=0;
            headCell.shop_jiesuan_priceTextFieldView.hidden=YES;
            headCell.shop_jiesuan_priceTextFieldHHH.constant=0;
            headCell.boxwareView.hidden=YES;
            headCell.boxwareViewHHH.constant=0;
        }
        headCell.waimaiBtn.tag=1;
        headCell.tangshiBtn.tag=2;
        headCell.allBtn.tag=3;
        [headCell.waimaiBtn addTarget:self action:@selector(selectGoodLeiXing:) forControlEvents:UIControlEventTouchUpInside];
        [headCell.tangshiBtn addTarget:self action:@selector(selectGoodLeiXing:) forControlEvents:UIControlEventTouchUpInside];
        [headCell.allBtn addTarget:self action:@selector(selectGoodLeiXing:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [headCell.attr_nameBtn addTarget:self action:@selector(selectAttrName) forControlEvents:UIControlEventTouchUpInside];
        
        [headCell.cate_nameBtn addTarget:self action:@selector(selectCate_name) forControlEvents:UIControlEventTouchUpInside];
        
        headCell.nameTextField.delegate=self;
        headCell.shop_priceTextField.delegate=self;
        headCell.shop_jiesuan_priceTextField.delegate=self;
        headCell.church_shop_priceTextField.delegate=self;
        headCell.church_jiesuan_shop_priceTextField.delegate=self;
        headCell.boxwareTextField.delegate=self;
        headCell.limitTf.delegate=self;
        return headCell;
    }
    else
    {
      AddGoodList_Cell*   cell = [_mTable dequeueReusableCellWithIdentifier:@"AddGoodList_Cell" forIndexPath:indexPath];
        [cell.specs_nameBtn addTarget:self action:@selector(selectSpecs_name) forControlEvents:UIControlEventTouchUpInside];
        [cell.imaBtn addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        cell.imag_imageView.image=image;
        
        cell.specs_nameLab.text=specs_name;
        cell.labBtn.tag=1000;
        [cell.labBtn addTarget:self action:@selector(selectLabWithTag:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.labLab.text=lab;
        
        cell.waimaiTimeBtn.tag=1001;
        [cell.waimaiTimeBtn addTarget:self action:@selector(selectLabWithTag:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.tangshiTimeBtn.tag=1002;
        [cell.tangshiTimeBtn addTarget:self action:@selector(selectLabWithTag:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.waimaiTimeLab.text= waimaiTime;
        cell.tangshiTimeLab.text=tangshiTime;
        
        cell.date1Btn.tag=1003;
        [cell.date1Btn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.date2Btn.tag=1004;
        [cell.date2Btn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.week1Btn.tag=1005;
        [cell.week1Btn addTarget:self action:@selector(selectWeek:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.week2Btn.tag=1006;
        [cell.week2Btn addTarget:self action:@selector(selectWeek:) forControlEvents:UIControlEventTouchUpInside];
        if (desc.length==0) {
            cell.descriTxView.text=@"简单对商品进行描述";
            [cell.descriTxView setTextColor:[UIColor colorWithRed:111/255.0 green:113/255.0 blue:121/255.0 alpha:1]];
        }
        else
        {
              cell.descriTxView.text=desc;
              [cell.descriTxView setTextColor:[UIColor blackColor]];
        }
        cell.descriTxView.delegate=self;
        if ([status isEqualToString:@"3"]&&![_type isEqualToString:@"1"]) {
            cell.reasonViewHHH.constant=100;
            cell.reasonView.hidden=NO;
            cell.reasonLab.text=reason;
        }
        else
        {
            cell.reasonViewHHH.constant=0;
            cell.reasonView.hidden=YES;
            
        }
        
        if ([sup_type isEqualToString:@"1"]) {
            cell.waimaiViewHHH.constant=50;
            cell.waimaiTimeView.hidden=NO;
            cell.tangshiViewHHH.constant=0;
            cell.tangshiTimeView.hidden=YES;
            
            
        }
        else if ([sup_type isEqualToString:@"2"])
        {
            cell.waimaiViewHHH.constant=0;
            cell.waimaiTimeView.hidden=YES;
            cell.tangshiViewHHH.constant=50;
            cell.tangshiTimeView.hidden=NO;
            
        }
        else if ([sup_type isEqualToString:@"3"])
        {
            cell.waimaiViewHHH.constant=50;
            cell.waimaiTimeView.hidden=NO;
            cell.tangshiViewHHH.constant=50;
            cell.tangshiTimeView.hidden=NO;
            
        }
        else
        {
            
            cell.waimaiViewHHH.constant=0;
            cell.waimaiTimeView.hidden=YES;
            cell.tangshiViewHHH.constant=0;
            cell.tangshiTimeView.hidden=YES;
            
        }
        
        if ([waimaiTime isEqualToString:@"自定义"])
        {
            cell.data1ViewHHH.constant=50;
            cell.data1View.hidden=NO;
            cell.week1ViewHHH.constant=50;
            cell.week1View.hidden=NO;
            
            
        }
        else
        {
            cell.data1ViewHHH.constant=0;
            cell.data1View.hidden=YES;
            cell.week1ViewHHH.constant=0;
            cell.week1View.hidden=YES;
            
        }
        
        if ([tangshiTime isEqualToString:@"自定义"]) {
            cell.data2ViewHHH.constant=50;
            cell.date2View.hidden=NO;
            cell.week2ViewHHH.constant=50;
            cell.week2View.hidden=NO;
            
        }
        else{
            cell.data2ViewHHH.constant=0;
            cell.date2View.hidden=YES;
            cell.week2ViewHHH.constant=0;
            cell.week2View.hidden=YES;
            
        }
        if ([isWamaiType isEqualToString:@"1"]) {
            cell.data1View.backgroundColor=[UIColor groupTableViewBackgroundColor];
            cell.week1View.backgroundColor=[UIColor clearColor];
            
            
        }
        else if ([isWamaiType isEqualToString:@"2"]) {
            
            cell.data1View.backgroundColor=[UIColor clearColor];
            cell.week1View.backgroundColor=[UIColor groupTableViewBackgroundColor];
        }
        else
        {
            cell.data1View.backgroundColor=[UIColor clearColor];
            cell.week1View.backgroundColor=[UIColor clearColor];
        }
        
        if ([isTangshiType isEqualToString:@"1"]) {

            cell.date2View.backgroundColor=[UIColor groupTableViewBackgroundColor];
            cell.week2View.backgroundColor=[UIColor clearColor];
        }
        else if ([isTangshiType isEqualToString:@"2"])
        {
            cell.date2View.backgroundColor=[UIColor clearColor];
            cell.week2View.backgroundColor=[UIColor groupTableViewBackgroundColor];
        }
        else{
            cell.date2View.backgroundColor=[UIColor clearColor];
            cell.week2View.backgroundColor=[UIColor clearColor];
        }
        
        return cell;
    }
     
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    switch (textField.tag) {
//        case 99:
//            sellNum = textField.text;
//
//            if ([sellNum intValue]>[limit intValue]) {
//                [MBProgressHUD showError:@"已售数量应小于总限额" toView:self.view];
//                return NO;
//            }
//            break;
        case 100:
            name = textField.text;
            break;
        case 101:
            shop_price = textField.text;
            break;
            
        case 102:
            shop_jiesuan_price = textField.text;
            break;
        case 103:
            church_shop_price = textField.text;
            break;
        case 104:
            church_jiesuan_shop_price = textField.text;
            break;
        case 105:
            boxware = textField.text;
            break;
        case 106:
            limit = textField.text;

            if ([sellNum intValue]>[limit intValue]) {
                [MBProgressHUD showError:@"总限额应大于已售数量" toView:self.view];
                return NO;
            }
            break;
            
            
        default:
            break;
    }
    
   [_mTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    //??   [_mTable reloadData]; 失效
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    desc=textView.text;
   [_mTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    return YES;
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"简单对商品进行描述"]) {
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
#pragma mark 分类
-(void)selectCate_name
{
    GoodsManagerItemList  *to=[[GoodsManagerItemList alloc]initWithBlock:^(NSString *nam,NSString *uids)
                               {
                                   cate_name=nam;
                                   cate_id=uids;
                                   
                                   [_mTable reloadData];
                               }];
    to.type=@"3";
    to.sta_mid=_sta_mid;
    [self.navigationController pushViewController:to animated:YES];
    
    
}
#pragma mark 多规格
-(void)selectAttrName
{
    AddAttr_name  *to=[[AddAttr_name alloc]initWithBlock:^(NSArray *arr)
                       {
                           
                           NSMutableString *str=[NSMutableString string];
                           for (int i=0;i<arr.count;i++) {
                               [str appendString:arr[i][@"name"]];
                               if (i<arr.count-1) {
                                   [str appendString:@"/"];
                               }
                           }
                           if (_goods_id.length==0) {
                               Attr_nameArr=arr;
                           }
                           
                           attr_name=str;
                           [_mTable reloadData];
                       }];
    to.goods_id=_goods_id;
    to.sta_mid=_sta_mid;
    if (_goods_id.length==0) {
        to.arr=[NSMutableArray arrayWithArray:Attr_nameArr];
    }
    to.MerchantCate=MerchantCate;
    [self.navigationController pushViewController:to animated:YES];
}
#pragma mark 属性
-(void)selectSpecs_name
{
    Specs_nameDetail *detail=[[Specs_nameDetail alloc]initWithBlock:^(NSArray *arr)
                              {
                                  NSMutableString *str=[NSMutableString string];
                                  for (int i=0;i<arr.count;i++) {
                                      if (_goods_id.length==0) {
                                          [str appendString:arr[i][@"title"]];
                                      }
                                      else{
                                          [str appendString:arr[i][@"prop_title"]];
                                      }
                                      
                                      if (i<arr.count-1) {
                                          [str appendString:@"/"];
                                      }
                                  }
                                  Specs_nameArr=nil;
                                  if (_goods_id.length==0) {
                                      Specs_nameArr=arr;
                                  }
                                  specs_name=str;
                                  [_mTable reloadData];
                                  
                              }];
    
    
    detail.goods_id=_goods_id;
    if (_goods_id.length==0) {
        detail.arr=[NSMutableArray arrayWithArray:Specs_nameArr];
    }
    detail.sta_mid=_sta_mid;
    [self.navigationController pushViewController:detail animated:YES];
    
    
}
-(void)selectGoodLeiXing:(UIButton *)but
{
    if (but.selected) {
        return;
    }
    else{
        but.selected=YES;
        
        waimaiTime=@"不限时间";
        tangshiTime=@"不限时间";
        isWamaiType=@"";
        isTangshiType=@"";
        time_priceDic=nil;
        week_priceArr=nil;
        church_time_priceDic=nil;
        church_week_priceArr=nil;
        
        for (UIButton *button in headCell.headView.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                button.selected=NO;
            }
            
        }
        if (but.tag==1) {
            sup_type=@"1";
            
        }
        else if (but.tag==2) {
            sup_type=@"2";
            
        }
        else
        {
            sup_type=@"3";
            
        }
        [_mTable reloadData];
    }
    
}
-(void)selectImage
{
    /*
     *修复设置头像是,弹出选择头像选项后,背景色中有白条的问题
     */
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, NAVIGATION_BAR_HEIGHT)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view addSubview:view];
    
    SPhotoVC * phone = [[SPhotoVC alloc] init];
    phone.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:phone animated:YES completion:nil];
    
    //默认返回
    phone.SPhotoVC = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
    
    //选择图片
    phone.SPhotoVC_Choicek = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        
        //打开相册
        _imagePickerPhoto = [[UIImagePickerController alloc] init];
        _imagePickerPhoto.delegate = self;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            _imagePickerPhoto.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            _imagePickerPhoto.allowsEditing = YES;
            [self presentViewController:_imagePickerPhoto animated:YES completion:nil];
        }
    };
    
    //拍照
    phone.SPhotoVC_Photo = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        
        //相机
        _imagePickerCamera = [[UIImagePickerController alloc] init];
        _imagePickerCamera.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            _imagePickerCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
            CGAffineTransform cameraTransform = CGAffineTransformMakeScale(1.25, 1.25);
            _imagePickerCamera.cameraViewTransform = cameraTransform;
            
            _imagePickerCamera.allowsEditing = YES;
            [self presentViewController:_imagePickerCamera animated:YES completion:nil];
        }
    };
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker == _imagePickerPhoto) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            NSString * sourceType = [info objectForKey:UIImagePickerControllerMediaType];
            if ([sourceType isEqualToString:(NSString *)kUTTypeImage]) {
                
                UIImage * imagePhoto = info[UIImagePickerControllerEditedImage];
                UIImage * scaleImage = [self scaleToSize:imagePhoto size:CGSizeMake(320, 320)];
                [self chooseImage:scaleImage];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }
    } else {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            //设置只可拍照
            _imagePickerCamera.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
            NSString * sourceType = [info objectForKey:UIImagePickerControllerMediaType];
            
            if ([sourceType isEqualToString:(NSString *)kUTTypeImage]) {
                
                UIImage * imageCamera = info[UIImagePickerControllerEditedImage];
                
                SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
                UIImageWriteToSavedPhotosAlbum(imageCamera, self,selectorToCall, nil);
                UIImage * scaleImage = [self scaleToSize:imageCamera size:CGSizeMake(320, 320)];
                [self chooseImage:scaleImage];
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
            
        }
        
        
    }
}

- (void)chooseImage:(UIImage *)cImage
{
    image = cImage;
    [_mTable reloadData];
}

//压缩图片为指定大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}
- (void)imageWasSavedSuccessfully:(UIImage *)cameraImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo
{
    
    if (paramError == nil){
        
        NSLog(@"保存相册成功");
        
    } else {
        
        NSLog(@"保存相册时发生错误");
        NSLog(@"Error = %@", paramError);
    }
}
-(void)selectLabWithTag:(UIButton *)but
{
    SelectLabView * header = [[SelectLabView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    if ( but.tag==1000) {
       NSArray *  arr=[NSArray arrayWithObjects:@"招牌",@"推荐",@"链店",@"取消" ,nil];
        header.selectStr=lab;
        [header getData:arr flag:@"1"];
      
    }
    else if ( but.tag==1001) {
        NSArray *  arr=[NSArray arrayWithObjects:@"不限时间",@"自定义",@"取消",nil];
         header.selectStr=waimaiTime;
        [header getData:arr flag:@"2"];
       
    }
    else if ( but.tag==1002) {
        NSArray *  arr=[NSArray arrayWithObjects:@"不限时间",@"自定义",@"取消",nil];
        header.selectStr=tangshiTime;
        [header getData:arr flag:@"3"];
    }
   
    
    
    header.topBtnBlock = ^(NSString * type,NSString *flag,NSInteger index) {
        
        if ([flag isEqualToString:@"1"]) {
            lab=type;
            if ([type isEqualToString:@"取消"]) {
                lab=@"";
            }
        }
        else  if ([flag isEqualToString:@"2"]) {
            waimaiTime=type;
            time_priceDic=nil;
            week_priceArr=nil;
            if ([type isEqualToString:@"取消"]) {
                waimaiTime=@"不限时间";
            }
        }
        else  if ([flag isEqualToString:@"3"]) {
            tangshiTime=type;
            church_time_priceDic=nil;
            church_week_priceArr=nil;
            if ([type isEqualToString:@"取消"]) {
                tangshiTime=@"不限时间";
            }
        }
        else{
        }
        [_mTable reloadData];
        
    };
    
    [self.view.window addSubview:header];
    
}
-(void)selectDate:(UIButton *)but
{
    SetDateViewController  *to=[[SetDateViewController alloc]initWithBlock:^(NSDictionary *dic ,NSString *type)
                                {
                                    if ([type isEqualToString:@"1"]) {
                                        isWamaiType=@"1";
                                        
                                        time_priceDic=dic;
                                        
                                    }
                                    else
                                    {
                                        isTangshiType=@"1";
                                        church_time_priceDic=dic;
                                        
                                    }
                                    
                                    [_mTable reloadData];
                                }];
    
    
    
    if ( but.tag==1003) {
        to.type=@"1";
        to.startTime=time_priceDic[@"start_time"];
        to.endTime=time_priceDic[@"end_time"];
        to.price=time_priceDic[@"price"];
        to.jieSuanPrice=time_priceDic[@"jiesuan_price"];
    }
    else  {
        to.type=@"2";
        to.startTime=church_time_priceDic[@"start_time"];
        to.endTime=church_time_priceDic[@"end_time"];
        to.price=church_time_priceDic[@"price"];
        to.jieSuanPrice=church_time_priceDic[@"jiesuan_price"];
    }
    
    to.MerchantCate=MerchantCate;
    [self.navigationController pushViewController:to animated:YES];
}
-(void)selectWeek:(UIButton *)but
{
    SetWeekViewController  *to=[[SetWeekViewController alloc]initWithBlock:^(NSArray *arr ,NSString *type)
                                {
                                    if ([type isEqualToString:@"1"]) {
                                        isWamaiType=@"2";
                                        
                                        week_priceArr=arr;
                                    }
                                    else
                                    {
                                        
                                        isTangshiType=@"2";
                                        church_week_priceArr=arr;
                                    }
                                    
                                    [_mTable reloadData];
                                }];
    
    
    
    if ( but.tag==1005) {
        to.type=@"1";
        to.arr=[NSMutableArray arrayWithArray:week_priceArr];
    }
    else  {
        to.type=@"2";
        to.arr=[NSMutableArray arrayWithArray:church_week_priceArr];
    }
    to.MerchantCate=MerchantCate;
    [self.navigationController pushViewController:to animated:YES];
}

- (IBAction)savePress:(id)sender
{
    UIButton  *but=(UIButton *)sender;
    if (but.tag==4001) {
        [self saveType:@"1"];
        
    }
    else{
        [self saveType:@"2"];
        
    }
    
    
}
-(void)saveType:(NSString *)type
{
    AddAppStageGoodS *add=[[AddAppStageGoodS alloc]init];
    add.sta_mid=_sta_mid;
    if (sup_type.length==0) {
        [MBProgressHUD showError:@"请选择商品类型" toView:self.view];
        return;
    }
    else{
        add.sup_type=sup_type;
    }
    
    if (name.length==0) {
        [MBProgressHUD showError:@"请输入商品名称" toView:self.view];
        return;
    }
    else{
        add.name=name;
    }
    
    if([cate_name isEqualToString:@"选择分类"])
    {
        [MBProgressHUD showError:@"请选择商品分类" toView:self.view];
        return;
    }
    else{
        add.cate_id=cate_id;
    }
    
    if (!image) {
        [MBProgressHUD showError:@"请上传商品图片" toView:self.view];
        return;
    }
    else
    {
        add.ImagesAndNames=[NSArray arrayWithObject:image];
    }
    
    
    if ([sup_type isEqualToString:@"1"]) {
        
        if (shop_price.length==0) {
            [MBProgressHUD showError:@"请输入外卖售卖价" toView:self.view];
            return;
        }
        else{
            add.shop_price=shop_price;
        }
        if (shop_jiesuan_price.length==0) {
            [MBProgressHUD showError:@"请输入外卖结算价" toView:self.view];
            return;
        }
        else{
            add.shop_jiesuan_price=shop_jiesuan_price;
        }
        
        if ([shop_jiesuan_price doubleValue]>([shop_price  doubleValue]*[MerchantCate doubleValue])) {
              [MBProgressHUD showError:@"外卖结算价过高" toView:self.view];
            return ;
            
        }
        
    }
    else if ([sup_type isEqualToString:@"2"])
    {
        if (church_shop_price.length==0) {
            [MBProgressHUD showError:@"请输入堂食售卖价" toView:self.view];
            return;
        }
        else{
            add.church_shop_price=church_shop_price;
        }
        if (church_jiesuan_shop_price.length==0) {
            [MBProgressHUD showError:@"请输入堂食结算价" toView:self.view];
            return;
        }
        else{
            add.church_jiesuan_shop_price=church_jiesuan_shop_price;
        }
        if ([church_jiesuan_shop_price doubleValue]>([church_shop_price  doubleValue]*[MerchantCate doubleValue])) {
            [MBProgressHUD showError:@"堂食结算价过高" toView:self.view];
            return ;
            
        }
    }
    else
    {
        if (shop_price.length==0) {
            [MBProgressHUD showError:@"请输入外卖售卖价" toView:self.view];
            return;
        }
        else{
            add.shop_price=shop_price;
        }
        if (shop_jiesuan_price.length==0) {
            [MBProgressHUD showError:@"请输入外卖结算价" toView:self.view];
            return;
        }
        else{
            add.shop_jiesuan_price=shop_jiesuan_price;
        }
        
        if (church_shop_price.length==0) {
            [MBProgressHUD showError:@"请输入堂食售卖价" toView:self.view];
            return;
        }
        else{
            add.church_shop_price=church_shop_price;
        }
        if (church_jiesuan_shop_price.length==0) {
            [MBProgressHUD showError:@"请输入堂食结算价" toView:self.view];
            return;
        }
        else{
            add.church_jiesuan_shop_price=church_jiesuan_shop_price;
        }
        if ([shop_jiesuan_price doubleValue]>([shop_price  doubleValue]*[MerchantCate doubleValue])) {
            [MBProgressHUD showError:@"外卖结算价过高" toView:self.view];
            return ;
            
        }
        
    }
    
    add.goods_attr=Attr_nameArr;
    
    add.goods_property=Specs_nameArr;
    add.boxware=boxware;
    
    if ([lab isEqualToString:@"招牌"]) {
        add.label=@"1";
        
    }
    else if ([lab isEqualToString:@"推荐"])
    {
        add.label=@"2";
    }
    else if ([lab isEqualToString:@"链店"])
    {
        add.label=@"3";
    }
    else
    {
        add.label=@"0";
    }
    
    if ([isWamaiType isEqualToString:@"1"]) {
        
        NSString  *start_time=[self timeSwitchTimestamp: time_priceDic[@"start_time"] andFormatter:@"YYYY-MM-dd "];
        NSString  *end_time=[self timeSwitchTimestamp: time_priceDic[@"end_time"] andFormatter:@"YYYY-MM-dd "];
        
        NSDictionary *dic=@{@"start_time": start_time,@"end_time":end_time,@"price":time_priceDic[@"price"],@"jiesuan_price":time_priceDic[@"jiesuan_price"]};
        add.time_price=dic;
    }
    else if ([isWamaiType isEqualToString:@"2"]) {
        add.week_price=week_priceArr;
    }
    else
    {
        
    }
    
    if ([isTangshiType isEqualToString:@"1"]) {
        
        NSString  *start_time=[self timeSwitchTimestamp: church_time_priceDic[@"start_time"] andFormatter:@"YYYY-MM-dd"];
        NSString  *end_time=[self timeSwitchTimestamp: church_time_priceDic[@"end_time"] andFormatter:@"YYYY-MM-dd"];
        
        NSDictionary *dic=@{@"start_time": start_time,@"end_time":end_time,@"price":church_time_priceDic[@"price"],@"jiesuan_price":church_time_priceDic[@"jiesuan_price"]};
        add.church_time_price=dic;
    }
    else if ([isTangshiType isEqualToString:@"2"])
    {
        add.church_week_price=church_week_priceArr;
    }
    else{
        
    }
    
    add.desc=desc;
    add.goods_id=_goods_id;
    
  
    if (limit.length>0&&![limit isEqualToString:@"不限"])
    {
        if ([sellNum intValue]>[limit intValue]) {
            [MBProgressHUD showError:@"已售数量应小于总限额" toView:self.view];
            return ;
        }
    }
    if ([limit isEqualToString:@"不限"]|| [limit isEqualToString:@"0"]) {
        add.limit=@"0";
    }
    else
    {
      add.limit=limit;
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [add AddAppStageGoodSSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      //  [MBProgressHUD showSuccess:message toView:self.view];
        if ([code intValue]==1) {
            if ([type isEqualToString:@"1"]) {
                [self.delgate refrechGoodListView];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                cate_name=@"选择分类";
                waimaiTime=@"不限时间";
                tangshiTime=@"不限时间";
                lab=@"";
                sup_type=@"";
                name=@"";
                cate_id=nil;
                image=nil;
                shop_price=nil;
                shop_jiesuan_price=nil;
                church_shop_price=nil;
                church_jiesuan_shop_price=nil;
                Attr_nameArr=nil;
                Specs_nameArr=nil;
                boxware=nil;
                time_priceDic=nil;
                week_priceArr=nil;
                church_time_priceDic=nil;
                church_week_priceArr=nil;
                desc=nil;
                _goods_id=nil;
                limit=nil;
                sellNum=@"0";
                specs_name=nil;
                attr_name=nil;
                status=nil;
                [_mTable reloadData];
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
#pragma mark - 将某个时间转化成 时间戳
-(NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format
{    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format];
    //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    //NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    NSString *str =[NSString stringWithFormat:@"%ld",(long)timeSp];
    return str;
    
}
-(UIImage *)changePicUrl:(NSString *)url
{
    if (url.length>0) {
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image=[UIImage imageWithData:data];
        return image;
    }
    return nil;
}
-(NSArray *)changWeekData:(NSArray *)arr
{
    NSMutableArray *data=[NSMutableArray array];
    for (int i=0; i<arr.count; i++) {
        Goods_infoModel *model =arr[i];
        NSDictionary *dic=@{@"price":model.price,@"jiesuan_price":model.jiesuan_price};
        [data addObject:dic];
    }
    return data;
    
}
-(NSDictionary *)changDateData:(Goods_infoModel *)model
{
    NSString *startTime=[CommonHelp timeWithTimeIntervalString:model.start_time andFormatter:@"YYYY-MM-dd"];
    NSString *endTime=[CommonHelp timeWithTimeIntervalString:model.end_time andFormatter:@"YYYY-MM-dd"];
    
    NSDictionary *dict=@{@"start_time":startTime,@"end_time":endTime,@"price":model.price,@"jiesuan_price":model.jiesuan_price};
    return dict;
    
}
@end

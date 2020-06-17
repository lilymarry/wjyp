//
//  AddGoodManagerItem.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/25.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddGoodManagerItem.h"
#import "AddGoodSetItemNameCell.h"
#import "AddGoodSetSortCell.h"
#import "AddGoodIntroduceCell.h"
#import "AddGoodManagerEdit_cateModel.h"
@interface AddGoodManagerItem ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    NSString *name;
    NSString *sort;
    NSString *decri;
    
    AddGoodSetItemNameCell * nameCell;
    AddGoodSetSortCell * sortCell;
    AddGoodIntroduceCell * introduceCell;
    
}
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@end

@implementation AddGoodManagerItem

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    // Do any additional setup after loading the view from its nib.
      _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddGoodSetItemNameCell class]) bundle:nil] forCellReuseIdentifier:@"AddGoodSetItemNameCell"];
    [_mTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddGoodSetSortCell class]) bundle:nil] forCellReuseIdentifier:@"AddGoodSetSortCell"];
    [_mTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddGoodIntroduceCell class]) bundle:nil] forCellReuseIdentifier:@"AddGoodIntroduceCell"];
    
    if([_type isEqualToString:@"2"])
    {
        name=_model.name;
        sort=_model.sort;
        decri=_model.desc;
        self.title=@"修改分类";
        
    }
    else{
     self.title=@"添加分类";
    }
    
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = nil;
  //  NSArray * tempArr = @[@"分类名称",@"显示顺序",@"简短描述"];
    switch (indexPath.row) {
        case 0:
        {
            nameCell = [tableView dequeueReusableCellWithIdentifier:@"AddGoodSetItemNameCell" forIndexPath:indexPath];
            nameCell.setNameTxf.text=name;
            nameCell.setNameTxf.delegate=self;
            cell = nameCell;
        }
            break;
        case 1:
        {
           sortCell = [tableView dequeueReusableCellWithIdentifier:@"AddGoodSetSortCell"];
            sortCell.setSortTxf.text=sort;
            sortCell.setSortTxf.delegate=self;
             cell = sortCell;
        }
            break;
        case 2:
        {
            introduceCell = [tableView dequeueReusableCellWithIdentifier:@"AddGoodIntroduceCell"];
            if (decri.length==0) {
                introduceCell.descTxt.text=@"请输入简短分类描述";
                [introduceCell.descTxt setTextColor:[UIColor colorWithRed:111/255.0 green:113/255.0 blue:121/255.0 alpha:1]];
            }
            else
            {
                   introduceCell.descTxt.text=decri;
                   [introduceCell.descTxt setTextColor:[UIColor blackColor]];
            }
            introduceCell.descTxt.delegate=self;
            cell = introduceCell;
        }
            break;

            
        default:
            break;
    }
    
    
    return cell;
}

#pragma mark - =========================== UITableViewDelegate =============================
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 44;
            break;
        case 1:
            return 44;
            break;
        case 2:
            return 178;
            break;
     
        default:
            return 0;
            break;
    }
}
- (IBAction)savePress:(id)sender {
   
  
    AddGoodManagerEdit_cateModel *model=[[AddGoodManagerEdit_cateModel  alloc]init];
    if ([_type isEqualToString:@"2"]) {
          model.id=_model.id;
    }
    if(nameCell.setNameTxf.text.length==0)
    {
           [MBProgressHUD showSuccess:@"请填写分类名称" toView:self.view];
        return;
    }
    else
    {
          model.name= nameCell.setNameTxf.text;
    }
    if ([introduceCell.descTxt.text isEqualToString:@"请输入简短分类描述"]) {
        introduceCell.descTxt.text=@"";
    }
    model.sort=sortCell.setSortTxf.text;
    model.desc=introduceCell.descTxt.text;
 
    model.sta_mid=_sta_mid;
    [MBProgressHUD showMessage:nil toView:self.view];
    [model AddGoodManagerEdit_cateModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==1) {
            [MBProgressHUD showSuccess:@"操作成功" toView:self.view];
            if (_delgate!=nil &&[_delgate respondsToSelector:@selector(refrechtView)]) {
                [self.delgate refrechtView];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    return YES;
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    
    return YES;
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入简短分类描述"]) {
        textView.text=@"";
    }
    
}
@end

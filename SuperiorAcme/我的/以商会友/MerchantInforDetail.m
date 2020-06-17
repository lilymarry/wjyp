//
//  AddBFrientDetail.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "MerchantInforDetail.h"
#import "BfriendcateList.h"
#import "GetBfriendModel.h"
#import "AddBFrientList.h"
@interface MerchantInforDetail ()<UITextViewDelegate,UITextFieldDelegate>
{
    NSString *cateid;
    NSString *cata_name;
}
@property (strong, nonatomic) IBOutlet UIImageView *headIma;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UITextField *beiZhuTf;
@property (strong, nonatomic) IBOutlet UITextView *descrTx;
@property (strong, nonatomic) IBOutlet UILabel *fenzuLab;

@end

@implementation MerchantInforDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.headIma.layer.cornerRadius = self.headIma.bounds.size.width * 0.5;
    self.headIma.layer.masksToBounds = YES;
    
    [self.headIma sd_setImageWithURL:[NSURL URLWithString:_headIcon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    self.nameLab.text=_nickname;
    
    self.title=@"加好友";
    _beiZhuTf.delegate=self;
    _descrTx.delegate=self;
    
    
}
- (IBAction)selectFenZu:(id)sender {
    BfriendcateList *list =[[BfriendcateList alloc]init];
    list.sta_mid=_sta_mid;
    list.type=@"1";
    
    list.getCateIdBlock = ^(NSString * _Nonnull cate_id,NSString *cata_name) {
        cateid=cate_id;
        _fenzuLab.text=cata_name;
    };
    [self.navigationController pushViewController:list animated:YES];
    
    
    
}

- (IBAction)savePress:(id)sender {
    GetBfriendModel *model=[[GetBfriendModel alloc]init];
    model.type=@"1";
    model.sta_mid=_sta_mid;
    model.cate_id=cateid;
    if ([_descrTx.text isEqualToString:@"想对商友说点什么~"]) {
        _descrTx.text=@"";
    }
    
    model.vinfo=_descrTx.text;
    model.nickname=_nickname;
    model.bid=_bid;
    model.mid=_mid;
    [MBProgressHUD showMessage:nil toView:self.view];
    [model GetBfriendModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:message toView:self.view];
        if ([code intValue]==1) {
            BOOL isExit=NO;
            for(UIViewController *temp in self.navigationController.viewControllers) {
                if([temp isKindOfClass:[AddBFrientList class]]){
                    isExit=YES;
                    [self.navigationController popToViewController:temp animated:YES];
                    break;
                }
                
            }
            if(isExit==NO)
            {
                AddBFrientList *list=[[AddBFrientList alloc]init];
                list.sta_mid=_sta_mid;
                [self.navigationController pushViewController:list animated:YES];
                
            }
        }
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    if ([textView.text isEqualToString:@"想对商友说点什么~"]) {
        textView.text=@"";
    }
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (textView.text.length==0) {
        textView.text=@"想对商友说点什么~";
    }
    return YES;
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

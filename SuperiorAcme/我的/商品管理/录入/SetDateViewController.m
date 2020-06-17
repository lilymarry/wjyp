//
//  SetDateViewController.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "SetDateViewController.h"
#import "ChooseDateView.h"

@interface SetDateViewController ()<ChooseDateViewDelegate,UITextFieldDelegate>
{
    UIView *bgView ; //遮罩层
    ChooseDateView * header1;
    ChooseDateView * header2;
}
@property (strong, nonatomic) IBOutlet UILabel *startTimeLab;

@property (strong, nonatomic) IBOutlet UILabel *endTimeLab;

@property (strong, nonatomic) IBOutlet UITextField *priceTf;

@property (strong, nonatomic) IBOutlet UITextField *jieSuanPriceTf;


@end

@implementation SetDateViewController
-(id)initWithBlock:(SetDateFinishBlock)ablock
{
    if (self=[super init]) {
        
        _block=[ablock copy];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _startTimeLab.text=_startTime;
    _endTimeLab.text=_endTime;
    _priceTf.text=_price;
    _jieSuanPriceTf.text=_jieSuanPrice;
    
    
    self.title=@"日期范围";

}
- (IBAction)startTimePress:(id)sender {
     [self showThebgview];
    [header1 removeFromSuperview];
    [header2 removeFromSuperview];
    header1 = [[ChooseDateView alloc] initWithFrame:CGRectMake(0, Screen_height-230, Screen_width, 230)];
    header1.type=@"1";
    header1.delgate=self;
   [self.view.window addSubview:header1];
}
- (IBAction)endTimePress:(id)sender {
    [self showThebgview];
    [header1 removeFromSuperview];
    [header2 removeFromSuperview];
    header2 = [[ChooseDateView alloc] initWithFrame:CGRectMake(0, Screen_height-230, Screen_width, 230)];
    header2.type=@"2";
    header2.delgate=self;
    [self.view.window addSubview:header2];
}
- (IBAction)subPress:(id)sender {
   
    if (_startTimeLab.text.length==0) {
        [MBProgressHUD showError:@"请选择开始时间" toView:self.view];
        return;
    }
   else if (_endTimeLab.text.length==0) {
        [MBProgressHUD showError:@"请选择结束时间" toView:self.view];
        return;
    }
   else if (_priceTf.text.length==0||_jieSuanPriceTf.text.length==0) {
       [MBProgressHUD showError:@"请输入售卖价与结算价" toView:self.view];
       return;
   }

   else if ([self compareOneDay:[self stringFromDate:[NSDate date]] withAnotherDay:_startTimeLab.text]==1) {
       [MBProgressHUD showError:@"开始日期应早于当天日期" toView:self.view];
       return;
   }
   else if ([self compareOneDay:_startTimeLab.text withAnotherDay:_endTimeLab.text]!=-1) {
       [MBProgressHUD showError:@"开始日期应晚于结束日期" toView:self.view];
       return;
   }
   else if ([_jieSuanPriceTf.text doubleValue]>([_priceTf.text  doubleValue]*[_MerchantCate doubleValue])) {
        [MBProgressHUD showError:@"日期结算价过高" toView:self.view];
        return ;
        
    }
    NSDictionary *dic=@{@"start_time":_startTimeLab.text,@"end_time":_endTimeLab.text,@"price":_priceTf.text,@"jiesuan_price":_jieSuanPriceTf.text};
    if (_block)
    {
        _block(dic,_type);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
  
}
-(void)chooseDateView:(NSString *)data type:(NSString *)type
{
    if ([type isEqualToString:@"1"])
    {
        _startTimeLab.text=data;
    }
    else{
        _endTimeLab.text=data;
    }
    [header2 removeFromSuperview];
    [header1 removeFromSuperview];
    [self hidThebgview];
    
}
//加载背景蒙板
-(void)showThebgview{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    bgView.backgroundColor=[UIColor colorWithRed:60.0/255 green:60.0/255 blue:60.0/255 alpha:1];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheView:)];
    tapGesture.numberOfTapsRequired=1;
    [bgView addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0.8;
    }completion:^(BOOL finished){
        
    } ];
}
//撤销背景蒙板
-(void)hidThebgview{

    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}
//销毁查询菜单view
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    [header2 removeFromSuperview];
    [header1 removeFromSuperview];
}
-(void)removeDateView
{
    [self hidThebgview];
    [header2 removeFromSuperview];
    [header1 removeFromSuperview];
}

-(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
       NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
     NSLog(@"两者时间是同一个时间");
    return 0;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    return YES;
    
}
- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
@end

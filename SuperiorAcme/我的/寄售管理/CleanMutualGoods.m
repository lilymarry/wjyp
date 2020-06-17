//
//  CleanMutualGoods.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/8.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "CleanMutualGoods.h"
#import "CleanMutualNumModel.h"
#import "ProfitDetail.h"
#import "HelpCenter.h"
#import "ManagerMutualGoods.h"
#import "CleanMutualState.h"
@interface CleanMutualGoods ()
@property (strong, nonatomic) IBOutlet UILabel *incomeLab;
@property (strong, nonatomic) IBOutlet UILabel *levelLab;
@property (strong, nonatomic) IBOutlet UILabel *can_sale_numLab;
@property (strong, nonatomic) IBOutlet UILabel *ready_numLab;
@property (strong, nonatomic) IBOutlet UILabel *saling_numLab;

@end

@implementation CleanMutualGoods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showModel];
    self.title=@"寄售管理";
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置系统状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    
}

- (void)showModel {
    CleanMutualNumModel * center = [[CleanMutualNumModel alloc] init];
   [MBProgressHUD showMessage:nil toView:self.view];
    [center CleanMutualNumModelSuccess:^(NSString *code, NSString *message, id data) {
     
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            CleanMutualNumModel * center = (CleanMutualNumModel *)data;
            
            _incomeLab.text=center.data.income;
            _levelLab.text=center.data.level;
            
            
            _can_sale_numLab.text=[NSString stringWithFormat:@"%@",center.data.can_sale_num];
            _saling_numLab.text=center.data.saling_num;
            _ready_numLab.text=[NSString stringWithFormat:@"%@",center.data.ready_num];
            
            int i =  [center.data.level intValue];
            switch (i) {
                case 1:
                {
                  
                      _levelLab.text=@"初级";
                }
                    break;
                case 2:
                {
                   
                    _levelLab.text=@"中级";
                }
                    break;
                case 3:
                {
        
                   _levelLab.text=@"高级";
                }
                    break;
                case 4:
                {
         
                   _levelLab.text=@"高级+";
                }
                    break;
                default:
                    break;
            }
            
            
           
        } else {
            [MBProgressHUD showError:message toView:self.view];
          
            }
       
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)ProfitDetailPress:(id)sender {
    ProfitDetail *detail=[[ProfitDetail alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
- (IBAction)helpPress:(id)sender {
    HelpCenter *center=[[HelpCenter alloc]init];
    UIButton *but=(UIButton *)sender;
    center.type=[NSString stringWithFormat:@"%d",(int)but.tag];
    [self.navigationController pushViewController:center animated:YES];
}
- (IBAction)managerPress:(id)sender {
    ManagerMutualGoods *goods=[[ManagerMutualGoods alloc]init];
      [self.navigationController pushViewController:goods animated:YES];
    
}
- (IBAction)statePress:(id)sender {
     UIButton *but=(UIButton *)sender;
    NSString *str=[NSString stringWithFormat:@"%d",(int)but.tag];
        CleanMutualState *state=[[CleanMutualState alloc]init];
        state.clean_order_status=str;
        [self.navigationController pushViewController:state animated:YES];
}




@end

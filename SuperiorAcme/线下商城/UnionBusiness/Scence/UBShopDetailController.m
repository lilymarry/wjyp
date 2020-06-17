//
//  UBShopDetailController.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBShopDetailController.h"
#import "SEvaAll.h"
#import "SPayForMerchantController.h"
#import "AShare.h"


@interface UBShopDetailController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong ,nonatomic) UIButton *rightBtn_sub;
@property (nonatomic, strong) UBShopDetailModel *shopDetailModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnViewHHH;
@property (weak, nonatomic) IBOutlet UIButton *jieZhangbtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabHH;


@end

@implementation UBShopDetailController

+ (instancetype)instanceWithMerchant_id:(NSString *)merchant_id{
    return [[UBShopDetailController alloc] initWithMerchant_id:merchant_id];
}

-(instancetype)initWithMerchant_id:(NSString *)merchant_id{
    if (self = [super init]) {
        self.merchant_id = merchant_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configuration];
}

- (void)configuration{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableHelper = [UBShopDetailTableHelper instanceWithMerchant_id:self.merchant_id
                                                              tableView:self.tableView];
    
    MJWeakSelf;
    [self.tableHelper setVCGenerator:^UIViewController *(id params) { //全部评价
        SEvaAll *evaVC = [SEvaAll new];
        evaVC.merchant_id = weakSelf.merchant_id;
        evaVC.overType = @"线下商铺";
        [weakSelf.navigationController pushViewController:evaVC animated:YES];
        return evaVC;
    }];
    
    [self createNav];
    
    [MBProgressHUD showMessage:@"" toView:self.view];
    [self.tableHelper fetchDataWihtPara:nil
                      completionHandler:^(UBShopDetailModel *shopDetailModel) {
                          [MBProgressHUD hideHUDForView:self.tableHelper.tableView animated:YES];
                          weakSelf.shopDetailModel = shopDetailModel;
                          weakSelf.title = shopDetailModel.merchant_name;
                          weakSelf.rightBtn_sub.selected = shopDetailModel.is_collect;
                        //隐藏我要结账
                          if (shopDetailModel.user_id<=0||shopDetailModel.show_type==2) {
                              _btnViewHHH.constant=0;
                              _jieZhangbtn.hidden=YES;
                               _tabHH.constant=-5;
                          }
                          else
                          {
                              _btnViewHHH.constant=53;
                              _jieZhangbtn.hidden=NO;
                            
                          }
                      }];
}
- (IBAction)iWantPayAction:(UIButton *)sender {
    SPayForMerchantController *spayMerchantVC = [SPayForMerchantController new];
    spayMerchantVC.merchant_id = self.merchant_id;
    [self.navigationController pushViewController:spayMerchantVC animated:YES];
    
}

- (void)createNav{
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(-3, 13, 10, 0);
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake( 0,-15,-23, 0);
    
    [rightBtn setImage:[UIImage imageNamed:@"详情分享"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn_sub.frame = CGRectMake(0, 0, 50, 50);
    UIBarButtonItem * rightBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn_sub];
    _rightBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(-3, 20, 10, 0);
    _rightBtn_sub.titleEdgeInsets = UIEdgeInsetsMake( 0,-10,-21, 0);
    [_rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
    [_rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateSelected];
    [_rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
    _rightBtn_sub.titleLabel.font = [UIFont systemFontOfSize:12];
    [_rightBtn_sub setTitleColor:WordColor forState:UIControlStateNormal];
    [_rightBtn_sub addTarget:self action:@selector(rightBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem,rightBtnItem_sub];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)lefthBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtn_subClick{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:@"5" forKey:@"type"];
    [para setValue:self.merchant_id forKey:@"id_val"];
    self.rightBtn_sub.userInteractionEnabled = NO;
    if(!self.rightBtn_sub.selected){
        [HttpManager postWithUrl:SUserCollectAddCollect_Url
                   andParameters:para
                      andSuccess:^(id Json) {
                          self.rightBtn_sub.userInteractionEnabled = YES;
                          if (SWNOTEmptyDictionary(Json)) {
                              if([Json[@"code"] isEqualToString:@"1"]){
                                  [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
                                  self.rightBtn_sub.selected = YES;
                              }else{
                                  [MBProgressHUD showSuccess:Json[@"message"] toView:self.view];
                              }
                          }
                          
                      } andFail:^(NSError *error) {
                          self.rightBtn_sub.userInteractionEnabled = YES;
                      }];
    }else{
        
        [HttpManager postWithUrl:SUserCollectDelOneCollect_Url
                   andParameters:para
                      andSuccess:^(id Json) {
                          self.rightBtn_sub.userInteractionEnabled = YES;
                          if (SWNOTEmptyDictionary(Json)) {
                              if([Json[@"code"] isEqualToString:@"1"]){
                                  [MBProgressHUD showSuccess:@"取消成功" toView:self.view];
                                  self.rightBtn_sub.selected = NO;
                              }else{
                                  [MBProgressHUD showSuccess:Json[@"message"] toView:self.view];
                              }
                          }
                          
                      } andFail:^(NSError *error) {
                          self.rightBtn_sub.userInteractionEnabled = YES;
                      }];
        
    }
}

- (void)rightBtnClick{
    AShare * shareVC = [[AShare alloc] init];
      shareVC.thisUrl = _shopDetailModel.share_url;
    shareVC.thisImage = _shopDetailModel.logo;
    shareVC.thisTitle = _shopDetailModel.merchant_name;
    shareVC.thisContent = _shopDetailModel.merchant_desc;
    shareVC.thisType = @"2";
    shareVC.id_val = _shopDetailModel.merchant_id;
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:shareVC animated:YES completion:nil];
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

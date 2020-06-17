//
//  UBSearchController.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/31.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBSearchController.h"
#import "CommodityMerchant.h"
#import "SSearch_nav.h"
#import "UBNearByShopCell.h"
#import "UBSearchTableHelper.h"
#import "UBShopDetailController.h"
#import "SlineDetailWebController.h"
@interface UBSearchController ()<UITextFieldDelegate>
{
    SSearch_nav *_search;
}

@property (nonatomic, strong) UBSearchTableHelper *searchTableHelper;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@end

@implementation UBSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    self.searchTableHelper = [UBSearchTableHelper instanceWithKeyWord:self.keyWord
                                                            tableView:self.searchTableView];
    [self.searchTableHelper fetchData];
    MJWeakSelf;
    self.searchTableHelper.didSelectRowBlock = ^(SOffLineNearbyStoreListModel *model) {
        
        if ([model.goods_num integerValue] >0 ) {
  
            [weakSelf WebDetailClickWithSid:model.s_id];
     
            
        }
        else
        {
            UBShopDetailController *shopDetailVC = [UBShopDetailController instanceWithMerchant_id:model.merchant_id];
            [weakSelf.navigationController pushViewController:shopDetailVC animated:YES];
        }
        
    
    };
}
- (void)WebDetailClickWithSid:(NSString *)sid {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
        };
        return;
    }
    else
    {  
        NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
        if (invite_code.length==0) {
            invite_code=@"";
        }
        
        NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/offlineShop/os_type/1", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        
        NSString *urlStr=nil;
        
        if (invite_code.length>0) {
            urlStr =[NSString stringWithFormat:@"%@/merchant_id/%@/invite_code/%@.html",detail_Base_url,sid,invite_code];
        }
        else
        {
            urlStr =[NSString stringWithFormat:@"%@/merchant_id/%@.html",detail_Base_url,sid];
        }
        
        
        SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
        conter.urlStr=urlStr;
        conter.fag=@"3";
        conter.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController pushViewController:conter animated:YES];
    }
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    
    [rightBtn setImage:[UIImage imageNamed:@"红色搜索"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem];
    
    _search = [[SSearch_nav alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    _search.layer.masksToBounds = YES;
    _search.layer.cornerRadius = 3;
    self.navigationItem.titleView = _search;
//    [_search.choiceTypeBtn addTarget:self action:@selector(choiceTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _search.isHiddenBtnImgV = YES;
    _search.searchTF.text = _keyWord;
    _search.searchTF.delegate = self;
   
}

- (void)lefthBtnClick {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
//    [MBProgressHUD showSuccess:@"开发中..." toView:self.view];
    [_search.searchTF resignFirstResponder];
    self.searchTableHelper.keyword = _search.searchTF.text;
    [self.searchTableHelper fetchData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

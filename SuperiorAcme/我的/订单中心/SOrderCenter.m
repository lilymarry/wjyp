//
//  SOrderCenter.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#define WUJIESHANGDIAN @"积分商店"

#import "SOrderCenter.h"
#import "SOrderCenter_list.h"
#import "SOrderCenter_list_Auction.h"
#import "SMemberOrder.h"
#import "SOrderCenterCell.h"
#import "SlineDetailWebController.h"
@interface SOrderCenter () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * arr;
    NSArray * brr;
}
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;
@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;
@property (strong, nonatomic) IBOutlet UIButton *sexBtn;
@property (strong, nonatomic) IBOutlet UIButton *sevenBtn;
@property (strong, nonatomic) IBOutlet UIButton *eightBtn;
@property (strong, nonatomic) IBOutlet UIButton *nineBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SOrderCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    //线上商城
    [_oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //线下商铺
    [_twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //无界商店
    [_threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //拼团
    [_fourBtn addTarget:self action:@selector(fourBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //无界预购
    [_fiveBtn addTarget:self action:@selector(fiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //竞拍汇
    [_sexBtn addTarget:self action:@selector(sexBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //积分抽奖
    [_sevenBtn addTarget:self action:@selector(sevenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //汽车购
    [_eightBtn addTarget:self action:@selector(eightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //房产购
    [_nineBtn addTarget:self action:@selector(nineBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
    mFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    mFlowLayout.itemSize = CGSizeMake(ScreenW/3, ScreenW/4);//设置单元格的宽和高
    mFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//各分区上下左右空白区域大小
    [_mCollect setCollectionViewLayout:mFlowLayout];
    //隐藏滚轴
    _mCollect.showsVerticalScrollIndicator = NO;
    //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SOrderCenterCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOrderCenterCell"];
    
    if ([_activity_status integerValue] == 0) {
        [HttpManager checkTheUpdate:@"1342931428" responseResult:^(NSString * c1, NSString *c2, BOOL c3) {
            
            if ([self isNO:c1] == NO) {
                arr = @[@"订单中心线上商城",@"订单充"];
                brr = @[@"线上商城",@"线上充值"];
                [_mCollect reloadData];
                
            } else {
                arr = @[@"订单中心线上商城",@"订单中心拼团",@"订单会员卡",@"订单充"];
                brr = @[@"线上商城",@"拼单购",@"会员卡",@"线上充值"];
                [_mCollect reloadData];
            }
        }];
        
    } else {
        if ([Url_header isEqualToString:@"api"]) {
            arr = @[@"订单中心线上商城",@"订单中心线下商铺",@"无界商店",@"订单中心拼团",@"订单会员卡",@"订单充",@"399",@"赠品专区",@"首页集碎片"];
            brr = @[@"线上商城",@"线下店铺",WUJIESHANGDIAN,@"拼单购",@"会员卡",@"线上充值",@"399专区",@"赠品专区",@"集碎片"];
        }
        else
        {
            arr = @[@"订单中心线上商城",@"订单中心线下商铺",@"无界商店",@"订单中心拼团",@"首页无界预购",@"首页竞拍汇",@"首页一元夺宝",@"orderCenter_qcg",@"首页房产购",@"订单会员卡",@"订单充",@"399",@"赠品专区",@"首页集碎片"];
            brr = @[@"线上商城",@"线下店铺",WUJIESHANGDIAN,@"拼单购",@"无界预购",@"比价购",@"积分抽奖",@"汽车购",@"房产购",@"会员卡",@"线上充值",@"399专区",@"赠品专区",@"集碎片"];
        }
        
//        arr = @[@"订单中心线上商城",@"订单中心线下商铺",@"订单中心线下商铺",@"无界商店",@"订单中心拼团",@"首页无界预购",@"首页竞拍汇",@"首页一元夺宝",@"orderCenter_qcg",@"首页房产购",@"订单会员卡",@"订单充",@"订单中心线上商城"];
//        brr = @[@"线上商城",@"线下店铺",@"堂食订单",WUJIESHANGDIAN,@"拼单购",@"无界预购",@"比价购",@"积分抽奖",@"汽车购",@"房产购",@"会员卡",@"线上充值",@"2980专区"];

        
        
//    arr = @[@"订单中心线上商城",@"订单中心线下商铺",@"无界商店",@"订单中心拼团",@"首页无界预购",@"首页竞拍汇",@"首页一元夺宝",@"orderCenter_qcg",@"首页房产购",@"订单会员卡",@"订单充"];
//    brr = @[@"线上商城",@"线下店铺",WUJIESHANGDIAN,@"拼单购",@"无界预购",@"比价购",@"积分抽奖",@"汽车购",@"房产购",@"会员卡",@"线上充值"];
        [_mCollect reloadData];
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"订单中心";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
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
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 线上商城
- (void)oneBtnClick {
    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
    list.type = @"1";
    list.coming = YES;
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - 线下商铺
- (void)twoBtnClick {
    
}
#pragma mark - 无界商店
- (void)threeBtnClick {
    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
    list.type = @"7";
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - 拼团
- (void)fourBtnClick {
    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
    list.type = @"2";
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - 无界预购
- (void)fiveBtnClick {
    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
    list.type = @"3";
    list.coming = YES;
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark  - 竞拍汇
- (void)sexBtnClick {
    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
    list.type = @"4";
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - 积分抽奖
- (void)sevenBtnClick {
    SOrderCenter_list_Auction * auction = [[SOrderCenter_list_Auction alloc] init];
    auction.type = YES;
    [self.navigationController pushViewController:auction animated:YES];
}
#pragma mark - 汽车购
- (void)eightBtnClick {
    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
    list.type = @"5";
    list.coming = YES;
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - 房产购
- (void)nineBtnClick {
    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
    list.type = @"6";
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - 会员卡
- (IBAction)tenBtn:(UIButton *)sender {
    SMemberOrder * list = [[SMemberOrder alloc] init];
    list.type = @"会员卡";
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - 充值
- (IBAction)elevenBtn:(UIButton *)sender {
    SMemberOrder * list = [[SMemberOrder alloc] init];
    list.type = @"充值";
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - 判断版本号
- (BOOL)isNO:(NSString *)c1 {
    // app版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *localVerson = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    //将版本号按照.切割后存入数组中
    NSArray *localArray = [localVerson componentsSeparatedByString:@"."];
    NSMutableArray * localArray_sub = [[NSMutableArray alloc] init];
    [localArray_sub addObjectsFromArray:localArray];
    NSArray *appArray = [c1 componentsSeparatedByString:@"."];
    NSMutableArray * appArray_sub = [[NSMutableArray alloc] init];
    [appArray_sub addObjectsFromArray:appArray];
    
    NSInteger num = 0;//循环次数
    if (localArray_sub.count > appArray_sub.count) {
        num = localArray_sub.count;
        for (int i = 0; i < localArray_sub.count - appArray_sub.count; i++) {
            [appArray_sub addObject:@"0"];
        }
    }
    if (localArray_sub.count < appArray_sub.count) {
        num = appArray_sub.count;
        for (int i = 0; i < appArray_sub.count - localArray_sub.count; i++) {
            [localArray_sub addObject:@"0"];
        }
    }
    if (localArray_sub.count == appArray_sub.count) {
        num = localArray_sub.count;
    }
    if (localArray_sub == appArray_sub) {
        return NO;
    }
    for(int i = 0; i < num; i++){//以最短的数组长度为遍历次数,防止数组越界
        //取出每个部分的字符串值,比较数值大小
        if([localArray_sub[i] integerValue] > [appArray_sub[i] integerValue]) {
            //从前往后比较数字大小,一旦分出大小,跳出循环
            return NO;
        }
    }
    return YES;
}
#pragma mark 返回值决定UICollectionView分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arr.count;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOrderCenterCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOrderCenterCell" forIndexPath:indexPath];
    mCell.thisImage.image = [UIImage imageNamed:arr[indexPath.row]];
    mCell.thisTitle.text = brr[indexPath.row];
    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //        brr = @[@"线上商城",@"线下商铺",@"无界商店",@"拼单购",@"无界预购",@"比价购",@"积分抽奖",@"汽车购",@"房产购",@"会员卡",@"线上充值"];

    if ([brr[indexPath.row] isEqualToString:@"线上商城"]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"1";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
        
    } else if ([brr[indexPath.row] isEqualToString:@"线下店铺"]) {
     //   if ([Url_header isEqualToString:@"test2"]) {
            
            NSString *    urlStr =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/os_orderlist/status/9/p/1.html", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
            SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
            conter.fag=@"15";
            conter.urlStr=urlStr;
          [self.navigationController pushViewController:conter animated:YES];
           
            
   //     }
//        else
//        {
//        SMemberOrder * list = [[SMemberOrder alloc] init];
//        list.type = @"线下店铺";
//        [self.navigationController pushViewController:list animated:YES];
//        }
        
    } else if ([brr[indexPath.row] isEqualToString:WUJIESHANGDIAN]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"7";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
        
    } else if ([brr[indexPath.row] isEqualToString:@"拼单购"]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"2";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
        
    } else if ([brr[indexPath.row] isEqualToString:@"无界预购"]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"3";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
        
    } else if ([brr[indexPath.row] isEqualToString:@"比价购"]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"4";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
        
    } else if ([brr[indexPath.row] isEqualToString:@"积分抽奖"]) {
        SOrderCenter_list_Auction * auction = [[SOrderCenter_list_Auction alloc] init];
        auction.type = YES;
        [self.navigationController pushViewController:auction animated:YES];
        
    } else if ([brr[indexPath.row] isEqualToString:@"汽车购"]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"5";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
        
    } else if ([brr[indexPath.row] isEqualToString:@"房产购"]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"6";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
        
    } else if ([brr[indexPath.row] isEqualToString:@"会员卡"]) {
        SMemberOrder * list = [[SMemberOrder alloc] init];
        list.type = @"会员卡";
        [self.navigationController pushViewController:list animated:YES];
        
    } else if ([brr[indexPath.row] isEqualToString:@"线上充值"]) {
        SMemberOrder * list = [[SMemberOrder alloc] init];
        list.type = @"充值";
        [self.navigationController pushViewController:list animated:YES];
        
    }
    else if ([brr[indexPath.row] isEqualToString:@"堂食订单"]) {
     //   SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
     //   conter.fag=@"4";
      // [self presentViewController:conter animated:YES completion:nil];

    }
    else if ([brr[indexPath.row] isEqualToString:@"2980专区"]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"1";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
    }
    else if ([brr[indexPath.row] isEqualToString:@"赠品专区"]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"15";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
    }
    else if ([brr[indexPath.row] isEqualToString:@"399专区"]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"12";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
    }
    else if ([brr[indexPath.row] isEqualToString:@"集碎片"]) {
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"16";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
    }
}
@end

//
//  SCarefreeMember.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SCarefreeMember.h"
#import "SCarefreeMemberCell.h"
#import "SCarefreeMember_top.h"
#import "SNBannerView.h"
#import "SEBPay.h"
#import "SCM_Infor.h"//大礼包详情
#import "SAWebPageController.h"
#import "SAAPIHelper.h"
#import "SGoodsInfor_first.h"

@interface SCarefreeMember () <SNBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property (nonatomic, strong) SAAPIHelper *apiHelper;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation SCarefreeMember

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    [_mCollect registerNib:[UINib nibWithNibName:@"SCarefreeMemberCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SCarefreeMemberCell"];
    
    SCarefreeMember_top * top = [[SCarefreeMember_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*912 + 130 + 10)];
    [_mCollect addSubview:top];
    SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*912) delegate:self model:_bannerArr URLAttributeName:@"url" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor colorWithRed:250/255.0 green:199/255.0 blue:22/255.0 alpha:1.0] pageTintColor:[UIColor colorWithRed:250/255.0 green:199/255.0 blue:22/255.0 alpha:0.5]];
    [top.bannerView addSubview:banner];
    
    //无忧会员卡支付
    [top.submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if ([_is_get integerValue] == 0) {
        top.is_get.text = @"立即开通";
    } else {
        top.is_get.text = @"已开通";
    }
    
    if ([_sale_status isEqualToString:@"1"]) {
        top.submitBtnView.hidden = YES;
        top.groView.backgroundColor = [UIColor whiteColor];
    }
    
    top.frame = CGRectMake(0, 0, ScreenW, ScreenW/1242*912 + 130 + 10 - 50);
    if ([_score_status integerValue] == 0) {
        top.is_get.text = @"您已拥有了更高级别会员卡,此级别不可以申请";
        top.is_get.textColor = WordColor;
        top.submitBtnView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    } else if ([_score_status integerValue] == 1) {
        top.is_get.text = @"续费";
    } else if ([_score_status integerValue] == 2) {
        top.is_get.text = @"立即开通";
    } else if ([_score_status integerValue] == 4) {
        top.is_get.text = @"永久有效";
        top.is_get.textColor = WordColor;
        top.submitBtnView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else if ([_score_status integerValue] == 5){
        top.is_get.text = @"免费续约";
    }
    
    if ([_score_status integerValue] == 5){
        top.thisMoney.text = @"领取延期一年优享会员";
    }else{
       top.thisMoney.text = [NSString stringWithFormat:@"会员年费￥%@/年",_thisMoney];
    }
    //暂时隐藏大礼包内容
   top.thisTitleView.hidden = YES;
  //  if ([Url_header isEqualToString:@"test"]||[Url_header isEqualToString:@"dev"]) {
        self.apiHelper = [SAAPIHelper new];
        [self requestDataFromServer];
        
        //暂时隐藏大礼包内容
        top.thisTitleView.hidden = NO;
        MJWeakSelf;
        _mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestDataFromServer];
        }];
        
        _mCollect.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf lodeMore_requestDataFromServer];
        }];
   // }
   
}

#pragma mark - 获取2980商品列表
-(void)requestDataFromServer{
    [MBProgressHUD showMessage:@"" toView:self.view];
    MJWeakSelf;
    [self.apiHelper refrshGoods_twoNineEightZero_completion:^(BOOL isSuccess, NSString *message, id result) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         [weakSelf.mCollect.mj_header endRefreshing];
        if (isSuccess) {
            [weakSelf.datas removeAllObjects];
            [weakSelf.mCollect.mj_footer resetNoMoreData];
            [weakSelf reloadTableWithData:result];
        }else{
            [MBProgressHUD showSuccess:message toView:weakSelf.view];
        }
    }];
}

-(void)lodeMore_requestDataFromServer{
    [MBProgressHUD showMessage:@"" toView:self.view];
    MJWeakSelf;
    [weakSelf.apiHelper loadMoreGoods_twoNineEightZero_completion:^(BOOL isSuccess, NSString *message, id result) {
       [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.mCollect.mj_footer endRefreshing];
        if (isSuccess) {
            [weakSelf reloadTableWithData:result];
        }else{
            [MBProgressHUD showSuccess:message toView:weakSelf.view];
            [weakSelf.mCollect.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    
}

- (void)reloadTableWithData:(id)data{
    [self.datas addObjectsFromArray:data];
    [_mCollect reloadData];
}

#pragma mark - 无忧会员卡支付
- (void)submitBtnClick {
    if ([_score_status integerValue] == 0 || [_score_status integerValue] == 4) {
        return;
    }else if (_score_status.integerValue == 5){
        [self dealWithScoreStatues];
        return;
    }
    SEBPay * pay = [[SEBPay alloc] init];
    pay.type = @"2";
    pay.rank_id = _rank_id;
    pay.rank_name = _rank_name;
    pay.money = _thisMoney;
    pay.grade = _grade;
    pay.member_coding = _member_coding;
    [self.navigationController pushViewController:pay animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = _rank_name;
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(ScreenW/1242*912 + 130 + 10, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW/3, (ScreenW/3-10) + 110);
    
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SCarefreeMemberCell *mCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SCarefreeMemberCell" forIndexPath:indexPath];
    [mCell fullDataWithModel:self.datas[indexPath.row]];
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    /* 不要删 */
//        SCM_Infor * infor = [[SCM_Infor alloc] init];
//        [self.navigationController pushViewController:infor animated:YES];
    
    SGoodsGoodsList *model = self.datas[indexPath.row];
    SGoodsInfor_first *goodsInfoVC = [SGoodsInfor_first new];
    goodsInfoVC.overType = NULL;
    goodsInfoVC.goods_id = model.goods_id;
    [self.navigationController pushViewController:goodsInfoVC animated:YES];
    
}

-(void)dealWithScoreStatues{
    [MBProgressHUD showMessage:@"" toView:self.view];
    [HttpManager getWithUrl:@"User/delayProcessing"
              andParameters:@{}
                 andSuccess:^(id Json) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     if (SWNOTEmptyDictionary(Json)) {
                         [MBProgressHUD showSuccess:Json[@"message"] toView:self.view];
                         if ([Json[@"code"] isEqualToString:@"1"]) {
                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 [self.navigationController popToRootViewControllerAnimated:YES];
                             });
                         }
                     }
                 }
                    andFail:^(NSError *error) {
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
                    }];
}

-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end

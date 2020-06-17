//
//  SgiftList.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/22.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftList.h"
#import "SgiftListCell.h"
#import "SgiftListModel.h"
#import "SgiftListTopReusableView1.h"
//#import "SlineDetailWebController.h"
@interface SgiftList ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SgiftListTopReusableViewDelegate>
{
    NSString *shop_id;
}
@property (assign,nonatomic) NSInteger page;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectViewFlowLayout;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * dataArr1;

@end
static NSString * SgiftListCellID = @"SgiftListCellID";
@implementation SgiftList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title=@"赠品专区";
    self.dataArr =[NSMutableArray array];
    self.page=1;
    self.dataArr1 =[NSMutableArray array];

   
     [_collectView registerNib:[UINib nibWithNibName:@"SgiftListTopReusableView1" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SgiftListTopReusableView1"];
    
    [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([SgiftListCell class]) bundle:nil] forCellWithReuseIdentifier:SgiftListCellID];
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self rightBtnClick];
}
-(void)lefthBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
       [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
}
- (void)rightBtnClick {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
           [self refreshAndLoadMoreMethod];
        };
        return;
    }
    else
    {
         [self refreshAndLoadMoreMethod];
    }
    
}
- (void)refreshAndLoadMoreMethod{
    _collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    [_collectView.mj_header beginRefreshing];
    
    _collectView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getData];
    }];
    
}
-(void)getData
{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    SgiftListModel *model=[[SgiftListModel alloc] init];
    
   
    model.p=[NSString stringWithFormat:@"%d",(int)self.page];
   
    [model SgiftListSuccess:^(id result) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *str=[NSString stringWithFormat:@"%d",(int)[result[@"code"] integerValue]];
        
        if ([str isEqualToString:@"200"]) {
            if (_page==1) {
                [self.dataArr removeAllObjects];
                [self.dataArr1 removeAllObjects];
            }
            NSDictionary *da = result[@"data"];
            NSArray *data=da[@"gift_goods_list"];
            shop_id=da[@"shop_id"];
            for (int i = 0; i<data.count; i++)
            {
                SgiftListModel *model=[[SgiftListModel alloc]init];
                [model setValuesForKeysWithDictionary:data[i]];
               
                [_dataArr addObject:model];
                
            }
             NSArray *dat=da[@"distribution_list"];
            for (int i = 0; i<dat.count; i++)
            {
                SgiftListModel *model=[[SgiftListModel alloc]init];
                [model setValuesForKeysWithDictionary:dat[i]];
                
                [_dataArr1 addObject:model];
                
            }
        }
        else
        {
            [MBProgressHUD showError:result[@"message"] toView:self.view];
        }
        [_collectView reloadData];
        [_collectView.mj_footer endRefreshing];
        [_collectView.mj_header endRefreshing];
        
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
        [_collectView.mj_footer endRefreshing];
        [_collectView.mj_header endRefreshing];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
   
    SgiftListCell * openShopCell = [collectionView dequeueReusableCellWithReuseIdentifier:SgiftListCellID forIndexPath:indexPath];
     SgiftListModel *model=self.dataArr[indexPath.item];
    [openShopCell.googImag sd_setImageWithURL:[NSURL URLWithString:model.goods_img]
                                    placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    openShopCell.goodName.text=model.goods_name;
  //  openShopCell.goodsNums.text=[NSString stringWithFormat:@"原价¥%@|已售%@件",model.shop_price,model.exchange_num];
    openShopCell.lab_use_voucher.text=[NSString stringWithFormat:@"赠品券价¥%@",model.use_voucher];
    [openShopCell.country_logo sd_setImageWithURL:[NSURL URLWithString:model.country_logo]
                             placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    
    return openShopCell;
}
#pragma mark - =========================== CollectionView的delegate回调 =============================
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SgiftListModel *model=self.dataArr[indexPath.item];
    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
    info.gift_goods_id = model.gift_goods_id;
    info.overType = @"赠品专区";
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];

}

#pragma mark - =========================== CollectionView的item的布局 =============================
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    
        CGFloat itemWidth = (self.view.bounds.size.width - self.collectViewFlowLayout.minimumInteritemSpacing - 12) * 0.5;//此处的12为collectionView距离两边的内边距
            return CGSizeMake(itemWidth, 260);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
            return UIEdgeInsetsMake(3, 6, 3, 6);


}
//隐藏开店商品
/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SgiftListTopReusableView1 * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SgiftListTopReusableView1" forIndexPath:indexPath];
        header.dataArr= self.dataArr1;
        header.delegate=self;
        reusableview = header;
    }// header;
    return reusableview;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{

    CGSize size = {ScreenW,359};
    return size;
}
-(void)selectBtnClick:(SgiftListModel *)model
{
    NSString * goodid=model.goods_id;

    NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Distribution/DistributionShop/shop/", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];

    NSString *urlStr =[NSString stringWithFormat:@"%@/g_id/%@/shop_id/%@.html",detail_Base_url,goodid,shop_id];
    SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
    conter.fag=@"7";
    conter.urlStr=urlStr;
    [self presentViewController:conter animated:YES completion:nil];
}
*/

@end

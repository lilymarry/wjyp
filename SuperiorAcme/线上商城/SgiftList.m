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
@interface SgiftList ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (assign,nonatomic) NSInteger page;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectViewFlowLayout;
@property (nonatomic, strong) NSMutableArray * dataArr;
@end
static NSString * SgiftListCellID = @"SgiftListCellID";
@implementation SgiftList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArr =[NSMutableArray array];
    self.page=1;
       [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([SgiftListCell class]) bundle:nil] forCellWithReuseIdentifier:SgiftListCellID];
    [self refreshAndLoadMoreMethod];
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
            }
            NSDictionary *da = result[@"data"];
            NSArray *data=da[@"gift_goods_list"];
            for (int i = 0; i<data.count; i++)
            {
                SgiftListModel *model=[[SgiftListModel alloc]init];
                [model setValuesForKeysWithDictionary:data[i]];
               
                [_dataArr addObject:model];
                
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
    openShopCell.goodsPrice.text=model.shop_price;
    openShopCell.goodsNums.text=model.exchange_num;
    openShopCell.lab_use_voucher.text=model.use_voucher;
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
            return CGSizeMake(itemWidth, 229);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
            return UIEdgeInsetsMake(3, 6, 3, 6);
       
  
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

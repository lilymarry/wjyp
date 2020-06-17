//
//  SGoodManagementController.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/8.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SGoodManagementController.h"
#import "SItemView.h"
#import "SCommonGoodManagementCell.h"
#import "SOpenShopGoodManagementCell.h"
#import "SGoodManagementModel.h"
#import "SharePopViewController.h"
#import "ReLayoutSubViewButton.h"
#import "AShare.h"
///管理的商品类型(普通商品 / 开店商品)
typedef NS_ENUM(NSUInteger, GoodType) {
    kGoodTypeCommon = 0,
    kGoodTypeOpenShop,
};

@interface SGoodManagementController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *GoodStatusItemView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GoodStatusItemViewHeightCons;
@property (weak, nonatomic) IBOutlet UICollectionView *goodManagementCollect;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *goodManagementFlowLayout;
@property (weak, nonatomic) IBOutlet UIButton *batchManagementBtn;//批量管理按钮

@property (weak, nonatomic) IBOutlet UIView *bottomContainView;
@property (weak, nonatomic) IBOutlet ReLayoutSubViewButton *selectAllGoodBtn;
@property (weak, nonatomic) IBOutlet ReLayoutSubViewButton *ShelfOrLowerGoodBtn;//上架或者下架商品
@property (weak, nonatomic) IBOutlet ReLayoutSubViewButton *deleteGoodBtn;
@property (weak, nonatomic) IBOutlet UIView *noDataTipView;

@property (nonatomic, assign) GoodType ManagementGoodType;
@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, assign) BOOL isSelling;

@property (assign,nonatomic) NSInteger page;

@property (strong,nonatomic) NSString *  type;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *butHH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botmHH;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (weak, nonatomic) IBOutlet UIView *line0;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;

@end

static NSString * CommonGoodManagementCellID = @"CommonGoodManagementCellID";
static NSString * OpenShopGoodManagementCellID = @"OpenShopGoodManagementCellID";

@implementation SGoodManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr =[NSMutableArray array];
    self.page=1;
    _type=@"0";
    
   self.isSelling = YES;
   
    [self CreatNavBar:@[@"普通商品", @"开店商品"] andIsHaveRightBtn:YES andRightBtnOption:@{@"title":@"完成"} andDefaultHiddenForRightBtn:YES];
   [self initializeSubViewProperty];
    
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}
-(void)getData
{
    [self hiddButton:self.navigationItem.rightBarButtonItem.customView];
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    SGoodManagementModel *model=[[SGoodManagementModel alloc] init];
  
    model.shop_id = _shopid;
    model.id = @"";
    model.p=[NSString stringWithFormat:@"%d",(int)self.page];
    model.type=_type;
    [model putOnLineaGoodsMethod:^(id result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       // NSLog(@"SSSS%@",result);
        NSString *str=[NSString stringWithFormat:@"%d",(int)[result[@"code"] integerValue]];
        
        if ([str isEqualToString:@"200"]) {
            if (_page==1) {
                [self.dataArr removeAllObjects];
           }
           
            NSArray *data = result[@"data"];
            for (int i = 0; i<data.count; i++)
            {
                SGoodManagementModel *model=[[SGoodManagementModel alloc]init];
                [model setValuesForKeysWithDictionary:data[i]];
                model.isSelect=NO;
                [_dataArr addObject:model];
                
            }
      
            
            [self.segment setTitle:[NSString stringWithFormat:@"出售中(%@)",result[@"num_arr"][@"normal"]] forSegmentAtIndex:0];
              [self.segment setTitle:[NSString stringWithFormat:@"已下架(%@)",result[@"num_arr"][@"down"]] forSegmentAtIndex:1];
              [self.segment setTitle:[NSString stringWithFormat:@"已售罄(%@)",result[@"num_arr"][@"out"]] forSegmentAtIndex:2];

            
        }
        else
        {
               [MBProgressHUD showError:result[@"message"] toView:self.view];
        }

        if (_dataArr.count==0) {
            _noDataTipView.hidden=NO;
            _goodManagementCollect.hidden=YES;
        }
        else
        {
             _noDataTipView.hidden=YES;
             _goodManagementCollect.hidden=NO;
        }
        [_goodManagementCollect reloadData];
        [_goodManagementCollect.mj_footer endRefreshing];
        [_goodManagementCollect.mj_header endRefreshing];
            
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
        [_goodManagementCollect.mj_footer endRefreshing];
        [_goodManagementCollect.mj_header endRefreshing];
    }];
    
}

- (void)refreshAndLoadMoreMethod{
    _goodManagementCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    [_goodManagementCollect.mj_header beginRefreshing];
    
    _goodManagementCollect.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getData];
    }];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

//初始化子控件的相关属性
-(void)initializeSubViewProperty{
    _segment.tintColor = [UIColor clearColor];
    //定义选中状态的样式selected，类型为字典
    NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                               NSForegroundColorAttributeName:[UIColor colorWithRed:204/255.0 green:28/255.0 blue:23/255.0 alpha:1]};
    //定义未选中状态下的样式normal，类型为字典
    NSDictionary *normal = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                             NSForegroundColorAttributeName:[UIColor blackColor]};
   // ,NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleThick|NSUnderlineByWord]
    /*
     NSFontAttributeName -> 系统宏定义的特殊键，用来给格式字典中的字体赋值
     NSForegroundColorAttributeName -> 系统宏定义的特殊键，用来给格式字典中的字体颜色赋值
     */
    
    //通过setTitleTextAttributes: forState: 方法来给test控件设置文字内容的格式
    [_segment setTitleTextAttributes:normal forState:UIControlStateNormal];
    [_segment setTitleTextAttributes:selected forState:UIControlStateSelected];
    
    //设置test初始状态下的选中下标
    _segment.selectedSegmentIndex = 0;
    
    _line0.hidden=NO;
    _line1.hidden=YES;
    _line2.hidden=YES;
    
    [_goodManagementCollect registerNib:[UINib nibWithNibName:NSStringFromClass([SCommonGoodManagementCell class]) bundle:nil] forCellWithReuseIdentifier:CommonGoodManagementCellID];
    [_goodManagementCollect registerNib:[UINib nibWithNibName:NSStringFromClass([SOpenShopGoodManagementCell class]) bundle:nil] forCellWithReuseIdentifier:OpenShopGoodManagementCellID];
    _goodManagementCollect.allowsSelection = NO;//默认collectionView的item是不可点击的
    
    [self refreshAndLoadMoreMethod];
}

//UISegmentedControl的方法
-(IBAction)change:(UISegmentedControl *)sender{
     _ShelfOrLowerGoodBtn.hidden=NO;
    if (sender.selectedSegmentIndex == 0) {
        self.isSelling = YES;
        _type=@"0";
        _line0.hidden=NO;
        _line1.hidden=YES;
        _line2.hidden=YES;
        [self   refreshAndLoadMoreMethod];
    }else if (sender.selectedSegmentIndex == 1){
       
        self.isSelling = NO;
        _type=@"1";
        _line0.hidden=YES;
        _line1.hidden=NO;
        _line2.hidden=YES;
        [self   refreshAndLoadMoreMethod];
    }else if (sender.selectedSegmentIndex == 2){
        _type=@"3";
        self.isSelling = YES;
        _line0.hidden=YES;
        _line1.hidden=YES;
        _line2.hidden=NO;
        _ShelfOrLowerGoodBtn.hidden=YES;
        [self   refreshAndLoadMoreMethod];
    }
}
- (void)selectItem:(UISegmentedControl *)sender {
    
    self.ManagementGoodType = sender.selectedSegmentIndex;
    
    if (sender.selectedSegmentIndex == kGoodTypeCommon) {
        
        self.goodManagementCollect.backgroundColor = [UIColor whiteColor];
        self.bottomContainView.hidden = NO;
        self.GoodStatusItemView.hidden = NO;
        self.GoodStatusItemViewHeightCons.constant = 30;
        self.butHH.constant=48;
        self.botmHH.constant=48;
        //恢复默认选中的第一个item
        self.segment.selectedSegmentIndex=0;
        _type=@"0";
        //切换恢复最初的状态
        self.isSelling = YES;
        _line0.hidden=NO;
        _line1.hidden=YES;
        _line2.hidden=YES;
        [self   refreshAndLoadMoreMethod];
        _goodManagementCollect.allowsSelection = NO;
        [_goodManagementCollect reloadData];
        
    }else if (sender.selectedSegmentIndex == kGoodTypeOpenShop){
        _type=@"2";
        self.goodManagementCollect.backgroundColor = [UIColor clearColor];
        self.bottomContainView.hidden = YES;
        self.GoodStatusItemView.hidden = YES;
        self.GoodStatusItemViewHeightCons.constant = 0;
        self.butHH.constant=0;
        self.botmHH.constant=0;
        [self navRightBtn:self.navigationItem.rightBarButtonItem.customView];
        [self   refreshAndLoadMoreMethod];
        _goodManagementCollect.allowsSelection = NO;
        [_goodManagementCollect reloadData];
    }
    
}
-(void)hiddButton:(UIButton *)btn
{
    btn.hidden = YES;
    self.batchManagementBtn.hidden = NO;
    _goodManagementCollect.allowsSelection = NO;//默认collectionView的item是不可点击的
    [self RefreshCollectionViewWithEditStatus:NO];
    
    for (SGoodManagementModel * model in self.dataArr) {
        self.selectAllGoodBtn.selected = NO;
        model.isSelect = NO;
    }
    [_goodManagementCollect reloadData];
    
}
//rightBtn的方法
-(void)navRightBtn:(UIButton *)btn{
    btn.hidden = YES;
    self.batchManagementBtn.hidden = NO;
    _goodManagementCollect.allowsSelection = NO;//默认collectionView的item是不可点击的
    [self RefreshCollectionViewWithEditStatus:NO];
    
    for (SGoodManagementModel * model in self.dataArr) {
        self.selectAllGoodBtn.selected = NO;
        model.isSelect = NO;
    }
    [_goodManagementCollect reloadData];
}

//普通商品时,刷新CollectionView,用于进入和退出编辑状态
-(void)RefreshCollectionViewWithEditStatus:(BOOL)editStatus{
    
    for (SGoodManagementModel * model in self.dataArr) {
        model.isturnEditStatus = editStatus;
    }
  
    [_goodManagementCollect reloadData];
}
//检查商品是否全选中
-(void)CheckAllGoodIsSelect{
    
    for (SGoodManagementModel * model in self.dataArr) {
        if (model.isSelect == NO) {
            self.selectAllGoodBtn.selected = NO;
            return;
        }
    }
    self.selectAllGoodBtn.selected = YES;
}

#pragma mark - =========================== bottomContainView的按钮点击事件 =============================
//批量管理
- (IBAction)ClickbatchManagement:(UIButton *)sender {
    
    if (self.dataArr.count>0) {
        UIButton * editDoneBtn = self.navigationItem.rightBarButtonItem.customView;
        editDoneBtn.hidden = NO;
        sender.hidden = YES;
        
        //根据商品是否是出售中,设置上架或下架商品的状态
        self.ShelfOrLowerGoodBtn.selected = !self.isSelling;
        
        //批量管理时,才允许Collection的item的点击
        _goodManagementCollect.allowsSelection = YES;
        
        [self RefreshCollectionViewWithEditStatus:YES];
    }
    else
    {
           [MBProgressHUD showSuccess:@"此状态无商品" toView:self.view];
    }
 
}
//商品全部选中
- (IBAction)SelectAllGoodClick:(ReLayoutSubViewButton *)sender {
    sender.selected = !sender.selected;
  

    for (SGoodManagementModel * model in self.dataArr) {
        model.isSelect = sender.selected;
    }
    
    [_goodManagementCollect reloadData];
}
//商品上架/下架提示信息
- (IBAction)ShelfOrLowerGoodClick:(ReLayoutSubViewButton *)sender {
    if (!sender.selected) {//当前处于 "正在出售" 的商品
        if ([self selectGoods]) {
            [self AlertOperationTipMessageWithMsg:@"确定要要下架此商品吗?" Withtag:1];
        }
        else
        {
          [MBProgressHUD showSuccess:@"至少选择一个商品" toView:self.view];
        }
        
    }else{//当前处于 "已下架" 的商品
          if ([self selectGoods]) {
        [self AlertOperationTipMessageWithMsg:@"确定要要上架此商品吗?" Withtag:0];
          }
          else
          {
              [MBProgressHUD showSuccess:@"至少选择一个商品" toView:self.view];
          }
    }
}
//删除商品
- (IBAction)deleteGoodClick:(ReLayoutSubViewButton *)sender {
      if ([self selectGoods]) {
        [self AlertOperationTipMessageWithMsg:@"确定要删除此商品吗?" Withtag:9];
      }
      else
      {
          [MBProgressHUD showSuccess:@"至少选择一个商品" toView:self.view];
      }
}
-(BOOL)selectGoods
{
      NSMutableArray *arr=[NSMutableArray array];
    for (int i=0; i<self.dataArr.count; i++) {
        SGoodManagementModel * model=self.dataArr[i];
        if (model.isSelect) {
            [arr addObject:model];
        }
    }
    if (arr.count==0) {
        return NO;
        //
    }
    return YES;
    
}
//商品上架/下架/删除的确认提示信息的弹出
-(void)AlertOperationTipMessageWithMsg:(NSString *)msgString Withtag:(int)tag{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msgString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *str=[NSMutableString string];
        NSMutableArray *arr=[NSMutableArray array];
        
        for (int i=0; i<self.dataArr.count; i++) {
            SGoodManagementModel * model=self.dataArr[i];
            if (model.isSelect) {
                [arr addObject:model];
            }
        }
        for (int i=0; i<arr.count; i++) {
            SGoodManagementModel * model=arr[i];
            if (model.isSelect) {
                [str appendString:model.dsg_id];
               
            }
            if (i<arr.count-1) {
            [str appendString:@","];
            }
        }
        NSString *shop_goods_status=[NSString stringWithFormat:@"%d",tag];
          [self mangerLineaGoods:shop_goods_status andidStr:str commentState:nil];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)mangerLineaGoods:(NSString *)shop_goods_status andidStr:(NSString *)idStr commentState:(NSString *)state
{
    NSString *str=[NSString string];
    if (state.length==0) {
        if ([shop_goods_status intValue]==9) {
            str=@"删除";
        }
        else if ([shop_goods_status intValue]==1)
        {
            str=@"下架";
        }
        else
        {
            str=@"上架";
        }
    }
    else
    {
          str=@"提交";
    }
    
    NSString *titt=  [NSString stringWithFormat:@"%@中....",str];
    [MBProgressHUD showMessage:titt toView:self.view];
    SGoodManagementModel *model=[[SGoodManagementModel alloc] init];
    
    model.shop_goods_status = shop_goods_status;
    model.shop_goods_rec=state;
    
    model.shopidStr = idStr;
    model.shop_id=_shopid;
    [model mangerLineaGoodsMethod:^(id result) {
      //  NSLog(@"AAAA_ %@",result[@"message"]);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *str1=[NSString stringWithFormat:@"%@",result[@"code"]];
        
        if ([str1 isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:result[@"message"] toView:self.view];
             [self refreshAndLoadMoreMethod];
        }
        else
        {
             [MBProgressHUD showSuccess:result[@"message"] toView:self.view];
        }
       
        
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
}
//商品推荐
-(void)alertCommentMessageWithMsg:(NSString *)msgString Withtag:(int)tag modelId:(NSString *)mode_id {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msgString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          NSString *state=[NSString stringWithFormat:@"%d",tag];
        [self mangerLineaGoods:nil andidStr:mode_id commentState:state];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark - =========================== 根据 UISegmentedControl 的selectedSegmentIndex 切换商品管理的布局=============================
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = nil;
    switch (self.ManagementGoodType) {
        case kGoodTypeCommon:
        {
            SCommonGoodManagementCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:CommonGoodManagementCellID forIndexPath:indexPath];
            SGoodManagementModel *model=self.dataArr[indexPath.item];
     
            if (model.isturnEditStatus) {
                commonCell.goodSelectBtn.hidden=NO;

            }else{
                commonCell.goodSelectBtn.hidden=YES;
            }
            
            commonCell.goodSelectBtn.selected = model.isSelect;
            
           [commonCell.goodIconImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]
                                           placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
            commonCell.goodTitleLabel.text=model.goods_name;
            commonCell.goodPriceLabel.text=[NSString stringWithFormat:@"¥%@",model.shop_price];
            commonCell.goodGiveIntegralLabel.text=[NSString stringWithFormat:@"%@积分",model.integral];
           commonCell.goodAviliableCashCouponLabel.text=[NSString stringWithFormat:@"最多可用%@%%代金券",model.ticket_buy_discount];
            
            if ([_type isEqualToString:@"0"]) {
                commonCell.jianBtn.hidden=NO;
                if ([model.shop_goods_rec isEqualToString:@"1"]) {
                     commonCell.jianImagView.hidden=NO;
                    
                }
                else
                {
                   commonCell.jianImagView.hidden=YES;
                }
               
            }
            else
            {
                commonCell.jianBtn.hidden=YES;
                commonCell.jianImagView.hidden=YES;
            }
            cell = commonCell;
            
            //分享普通商品的按钮点击回调
            __weak typeof(self) WeakSelf = self;
            commonCell.shareCommonGood = ^{
                __strong typeof(WeakSelf) StrongSelf = WeakSelf;
                [StrongSelf PopShareView:model withGoodsid:model.dsg_id];
            };
            commonCell.recommendCommonGood = ^{
                if ([model.shop_goods_rec isEqualToString:@"1"]) {
                    [self  alertCommentMessageWithMsg:@"确定要取消推荐吗?" Withtag:0 modelId:model.dsg_id];
                }
                else
                {
                      [self  alertCommentMessageWithMsg:@"确定要推荐该商品吗?" Withtag:1 modelId:model.dsg_id];
                }
               
             
            };
            
        }
            break;
        case kGoodTypeOpenShop:
        {
            SOpenShopGoodManagementCell * openShopCell = [collectionView dequeueReusableCellWithReuseIdentifier:OpenShopGoodManagementCellID forIndexPath:indexPath];
            SGoodManagementModel *model=self.dataArr[indexPath.item];
            //openShopCell.shareOpenShopGood =model ;
            
            [openShopCell.goodIconImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]
                                            placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
            openShopCell.goodTitleLabel.text=model.goods_name;
            openShopCell.goodPriceLabel.text=[NSString stringWithFormat:@"¥%@",model.shop_price];
             [openShopCell.giftBtn setTitle:[NSString stringWithFormat:@"送赠品券%@",model.goods_gift] forState:UIControlStateNormal];
            
            if ([model.active_type isEqualToString:@"0"]) {
                openShopCell.levImagView.image=[UIImage imageNamed:@"fx_icon_chuji"];
                
            }
            else if ([model.active_type isEqualToString:@"1"]) {
                openShopCell.levImagView.image=[UIImage imageNamed:@"fx_icon_zhongji"];
                
            }
            else {
                openShopCell.levImagView.image=[UIImage imageNamed:@"fx_icon_gaoji"];
                
            }
            cell = openShopCell;
            
            //分享开店商品按钮的点击回调
            __weak typeof(self) WeakSelf = self;
            openShopCell.shareOpenShopGood = ^{
                __strong typeof(WeakSelf) StrongSelf = WeakSelf;
                if ([model.is_distribution isEqualToString:@"1"]) {
                     [StrongSelf PopShopShareView:model withMerchantid:model.merchant_id];
                }
                else
                {
                    [StrongSelf PopShareView:model withGoodsid:model.goods_id];
                }
            };
        }
            break;
        default:
            break;
    }
    
    return cell;
}
#pragma mark - =========================== CollectionView的delegate回调 =============================
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SCommonGoodManagementCell * cell = (SCommonGoodManagementCell *)[collectionView cellForItemAtIndexPath:indexPath];
    SGoodManagementModel * model = self.dataArr[indexPath.item];
    model.isSelect = !model.isSelect;
    cell.goodSelectBtn.selected = model.isSelect;
    [self CheckAllGoodIsSelect];
}

#pragma mark - =========================== CollectionView的item的布局 =============================
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.ManagementGoodType) {
        case kGoodTypeCommon:
        {
            return CGSizeMake(self.view.bounds.size.width,113);
        }
            break;
        case kGoodTypeOpenShop:
        {
            CGFloat itemWidth = (self.view.bounds.size.width - self.goodManagementFlowLayout.minimumInteritemSpacing - 12) * 0.5;//此处的12为collectionView距离两边的内边距
            return CGSizeMake(itemWidth, 262);
        }
            break;
        default:
            return CGSizeZero;
            break;
    }
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    switch (self.ManagementGoodType) {
        case kGoodTypeCommon:
        {
            return UIEdgeInsetsMake(1, 0, 0, 0);
        }
            break;
        case kGoodTypeOpenShop:
        {
            return UIEdgeInsetsMake(3, 6, 3, 6);
        }
            break;
        default:
            return UIEdgeInsetsZero;
            break;
    }
}

#pragma mark - =========================== 弹出分享界面 =============================
-(void)PopShareView:(SGoodManagementModel*)model withGoodsid:(NSString *)goodid; {
    /*
    SharePopViewController * shareViewVC = [[SharePopViewController alloc] init];
    shareViewVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    shareViewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareViewVC.mode=model;
    shareViewVC.goods_id=goodid;
    shareViewVC.shopidMing=_shopidMing;
    shareViewVC.fag=@"2";
    shareViewVC.share_type=@"1";
    [self presentViewController:shareViewVC animated:YES completion:nil];
     */
    
    AShare * shareVC = [[AShare alloc] init];
    shareVC.thisImage=model.goods_img;
    shareVC.thisTitle = model.goods_name;
    shareVC.thisContent = model.goods_brief;
    shareVC.thisType=@"1";
    shareVC.id_val=goodid;
    NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Distribution/DistributionShop/shop", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
    NSString *urlStr=[NSString stringWithFormat:@"%@/g_id/%@/shop_id/%@.html",detail_Base_url, model.goods_id,_shopidMing];
    NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
    if (invite_code.length!=0) {
        urlStr =[NSString stringWithFormat:@"%@/g_id/%@/shop_id/%@/invite_code/%@.html",detail_Base_url, model.goods_id,_shopidMing,invite_code];
    }
    shareVC.thisUrl = urlStr;
    
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:shareVC animated:YES completion:nil];
    shareVC.AShare_back = ^{
        
    };
}
-(void)PopShopShareView:(SGoodManagementModel*)model withMerchantid:(NSString *)merchantid {
    
    AShare * shareVC = [[AShare alloc] init];
    shareVC.thisImage=model.goods_img;
    shareVC.thisTitle = model.goods_name;
    shareVC.thisContent = model.goods_brief;
    shareVC.thisType=@"1";
    shareVC.id_val=merchantid;
  
    NSString *urlStr=[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/offlineShop/merchant_id/%@/goods_id/%@/shop_id/%@.html",[Url_header isEqualToString:@"api"] ? @"www" : Url_header,merchantid,model.goods_id,_shopidMing];
    
    NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
    if (invite_code.length!=0) {
        urlStr=[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/offlineShop/invite_code/%@/merchant_id/%@/goods_id/%@/shop_id/%@.html",[Url_header isEqualToString:@"api"] ? @"www" : Url_header, invite_code,merchantid,model.goods_id,_shopidMing];
    }
    
    
    shareVC.thisUrl = urlStr;
    
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:shareVC animated:YES completion:nil];
    shareVC.AShare_back = ^{
        
    };
}
@end


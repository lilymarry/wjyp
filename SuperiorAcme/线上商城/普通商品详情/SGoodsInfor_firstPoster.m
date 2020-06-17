//
//  SGoodsInfor_firstPoster.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/31.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SGoodsInfor_firstPoster.h"
//#import "SGoodsInforPosterTop.h"
#import "SGoodsInfor_firstPosterTopCell.h"
#import "SGoodsInfoPosterModel.h"
#import "SGoodsInforPosterPlay.h"
#import "SGoodsInfor_firstPosterTopView.h"
@interface SGoodsInfor_firstPoster ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSIndexPath *selectPath;
    UIView *bgView ; //遮罩
    NSIndexPath *selectIndexPath;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *goods_nameLab;
@property (weak, nonatomic) IBOutlet UILabel *goods_briefLab;
@property (weak, nonatomic) IBOutlet UILabel *shop_priceLab;
@property (weak, nonatomic) IBOutlet UILabel *sell_numLab;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectViewFlowLayout;
@property (strong, nonatomic)   SGoodsInforPosterPlay *choseview;;


@end

@implementation SGoodsInfor_firstPoster

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
    
    self.title=@"推广素材制作";
    
   
    //设置默认初值
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_mCollect selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    if ([_mCollect.delegate respondsToSelector:@selector(collectionView: didSelectItemAtIndexPath:)]) {
        [_mCollect.delegate collectionView:_mCollect didSelectItemAtIndexPath:indexPath];
    }
    
  

}
- (void)createUI {

    [_mCollect registerNib:[UINib nibWithNibName:@"SGoodsInfor_firstPosterTopView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SGoodsInfor_firstPosterTopView"];
    
    //Cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SGoodsInfor_firstPosterTopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SGoodsInfor_firstPosterTopCell"];
    
}
-(void)viewWillAppear:(BOOL)animated
{
 //     adjustsScrollViewInsets_NO(_mCollect, self);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (_overType==NULL) {
        return _goodsInfor.data.goods_banner.count;
       
    }
    if ([_overType isEqualToString:@"限量购"]) {
         return _LimitBuyInfo.data.goods_banner.count;
        
    }
    if ([_overType isEqualToString:@"拼单购"]) {
         return _GroupBuyInfo.data.goods_banner.count;
      
    }
    if ([_overType isEqualToString:@"无界预购"])
    {
         return _preBuyPreBuyInfo.data.goods_banner.count;
        
    }
    if ([_overType isEqualToString:@"无界商店"])
    {
         return _integralBuyIntegralBuyInfo.data.goods_banner.count;
        
        
    }
    
    if  ([_overType isEqualToString:@"赠品专区"])
    {
          return _sgiftDetailModel.data.goods_banner.count;
      
    }
    return 0;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SGoodsInfor_firstPosterTopCell * openShopCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SGoodsInfor_firstPosterTopCell" forIndexPath:indexPath];
    
    
    if (_overType==NULL) {
        SGoodsGoodsInfo *info  = _goodsInfor.data.goods_banner[indexPath.item];
        
        [openShopCell.imaView sd_setImageWithURL:[NSURL URLWithString:info.path]
                                placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        
        if (info.RBtn_BOOL == NO) {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        } else {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
        }
        
    }
    if ([_overType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo *info  = _LimitBuyInfo.data.goods_banner[indexPath.item];
        
        [openShopCell.imaView sd_setImageWithURL:[NSURL URLWithString:info.path]
                                placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        
        if (info.RBtn_BOOL == NO) {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        } else {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
        }
      
        
    }
    if ([_overType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo *info  = _GroupBuyInfo.data.goods_banner[indexPath.item];
        
        [openShopCell.imaView sd_setImageWithURL:[NSURL URLWithString:info.path]
                                placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        
        if (info.RBtn_BOOL == NO) {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        } else {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
        }
        
      
        
    }
    if ([_overType isEqualToString:@"无界预购"])
    {
       
        SPreBuyPreBuyInfo *info  = _preBuyPreBuyInfo.data.goods_banner[indexPath.item];
        
        [openShopCell.imaView sd_setImageWithURL:[NSURL URLWithString:info.path]
                                placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        
        if (info.RBtn_BOOL == NO) {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        } else {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
        }
    }
    if ([_overType isEqualToString:@"无界商店"])
    {
        SIntegralBuyIntegralBuyInfo *info  = _integralBuyIntegralBuyInfo.data.goods_banner[indexPath.item];
        
        [openShopCell.imaView sd_setImageWithURL:[NSURL URLWithString:info.path]
                                placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        
        if (info.RBtn_BOOL == NO) {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        } else {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
        }
     
        
        
    }
    
    if  ([_overType isEqualToString:@"赠品专区"])
    {
      
        SgiftDetailModel *info  = _sgiftDetailModel.data.goods_banner[indexPath.item];
        
        [openShopCell.imaView sd_setImageWithURL:[NSURL URLWithString:info.path]
                                placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        
        if (info.RBtn_BOOL == NO) {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        } else {
            [openShopCell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
        }
        
    }

    return openShopCell;
}
#pragma mark - =========================== CollectionView的delegate回调 =============================
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

     SGoodsInfor_firstPosterTopCell * cell = (SGoodsInfor_firstPosterTopCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (_overType==NULL) {
        
        SGoodsGoodsInfo * info = _goodsInfor.data.goods_banner[indexPath.item];
        info.RBtn_BOOL=YES;
        [cell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
        
    }
    if ([_overType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo *info  = _LimitBuyInfo.data.goods_banner[indexPath.item];
        info.RBtn_BOOL=YES;
        [cell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
        
     
        
    }
    if ([_overType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo *info  = _GroupBuyInfo.data.goods_banner[indexPath.item];
        info.RBtn_BOOL=YES;
        [cell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
        
    }
    if ([_overType isEqualToString:@"无界预购"])
    {
        
        SPreBuyPreBuyInfo *info  = _preBuyPreBuyInfo.data.goods_banner[indexPath.item];
        
        info.RBtn_BOOL=YES;
        [cell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
    }
    if ([_overType isEqualToString:@"无界商店"])
    {
        SIntegralBuyIntegralBuyInfo *info  = _integralBuyIntegralBuyInfo.data.goods_banner[indexPath.item];
        
        info.RBtn_BOOL=YES;
        [cell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
        
    }
    
    if  ([_overType isEqualToString:@"赠品专区"])
    {
        
        SgiftDetailModel *info  = _sgiftDetailModel.data.goods_banner[indexPath.item];
        
        info.RBtn_BOOL=YES;
        [cell.flagView setImage:[UIImage imageNamed:@"海报选中"]];
    }

    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SGoodsInfor_firstPosterTopCell * cell = (SGoodsInfor_firstPosterTopCell *)[collectionView cellForItemAtIndexPath:indexPath];
   
    if (_overType==NULL) {
        
        SGoodsGoodsInfo * info = _goodsInfor.data.goods_banner[indexPath.item];
        [cell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        info.RBtn_BOOL=NO;
        
    }
    if ([_overType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo *info  = _LimitBuyInfo.data.goods_banner[indexPath.item];
        [cell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        info.RBtn_BOOL=NO;
        
        
        
    }
    if ([_overType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo *info  = _GroupBuyInfo.data.goods_banner[indexPath.item];
        [cell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        info.RBtn_BOOL=NO;
        
    }
    if ([_overType isEqualToString:@"无界预购"])
    {
        
        SPreBuyPreBuyInfo *info  = _preBuyPreBuyInfo.data.goods_banner[indexPath.item];
        
        [cell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        info.RBtn_BOOL=NO;
    }
    if ([_overType isEqualToString:@"无界商店"])
    {
        SIntegralBuyIntegralBuyInfo *info  = _integralBuyIntegralBuyInfo.data.goods_banner[indexPath.item];
        [cell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        info.RBtn_BOOL=NO;
        
    }
    
    if  ([_overType isEqualToString:@"赠品专区"])
    {
        
        SgiftDetailModel *info  = _sgiftDetailModel.data.goods_banner[indexPath.item];
        
        [cell.flagView setImage:[UIImage imageNamed:@"海报未选中"]];
        info.RBtn_BOOL=NO;
    }

    
    
}
#pragma mark - =========================== CollectionView的item的布局 =============================
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat ItemW = (ScreenW- _collectViewFlowLayout.minimumInteritemSpacing * 2) / 3;
    CGFloat ItemH = ItemW;
    return CGSizeMake(ItemW, ItemH);
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
      SGoodsInfor_firstPosterTopView   * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SGoodsInfor_firstPosterTopView" forIndexPath:indexPath];
        
        if (_overType==NULL) {
            header.goods_nameLab.text=_goodsInfor.data.goodsInfo.goods_name;
            header.goods_briefLab.text=_goodsInfor.data.goodsInfo.goods_brief;
                header.shop_priceLab.text=[NSString stringWithFormat:@"【在售价】¥%@",_goodsInfor.data.goodsInfo.shop_price];
                 header.sell_numLab.text=[NSString stringWithFormat:@"【已售】%@件",_goodsInfor.data.goodsInfo.sell_num];
        }
        if ([_overType isEqualToString:@"限量购"]) {
            header.goods_nameLab.text=_LimitBuyInfo.data.goodsInfo.goods_name;
            header.goods_briefLab.text=_LimitBuyInfo.data.goodsInfo.goods_brief;
            header.shop_priceLab.text=[NSString stringWithFormat:@"【在售价】¥%@",_LimitBuyInfo.data.goodsInfo.shop_price];
            header.sell_numLab.text=[NSString stringWithFormat:@"【已售】%@件",_LimitBuyInfo.data.goodsInfo.sell_num];
        }
        if ([_overType isEqualToString:@"拼单购"]) {
            header.goods_nameLab.text=_GroupBuyInfo.data.goodsInfo.goods_name;
            header.goods_briefLab.text=_GroupBuyInfo.data.goodsInfo.goods_brief;
            header.shop_priceLab.text=[NSString stringWithFormat:@"【在售价】¥%@",_GroupBuyInfo.data.goodsInfo.shop_price];
            header.sell_numLab.text=[NSString stringWithFormat:@"【已售】%@件",_GroupBuyInfo.data.goodsInfo.sell_num];
        }
        if ([_overType isEqualToString:@"无界预购"])
        {
            
            header.goods_nameLab.text=_preBuyPreBuyInfo.data.goodsInfo.goods_name;
            header.goods_briefLab.text=_preBuyPreBuyInfo.data.goodsInfo.goods_brief;
            header.shop_priceLab.text=[NSString stringWithFormat:@"【在售价】¥%@",_preBuyPreBuyInfo.data.goodsInfo.shop_price];
            header.sell_numLab.text=[NSString stringWithFormat:@"【已售】%@件",_preBuyPreBuyInfo.data.goodsInfo.sell_num];
        }
        if ([_overType isEqualToString:@"无界商店"])
        {
            header.goods_nameLab.text=_integralBuyIntegralBuyInfo.data.goodsInfo.goods_name;
            header.goods_briefLab.text=_integralBuyIntegralBuyInfo.data.goodsInfo.goods_brief;
            header.shop_priceLab.text=[NSString stringWithFormat:@"【在售价】¥%@",_integralBuyIntegralBuyInfo.data.goodsInfo.shop_price];
            header.sell_numLab.text=[NSString stringWithFormat:@"【已售】%@件",_integralBuyIntegralBuyInfo.data.goodsInfo.sell_num];
            
        }
        
        if  ([_overType isEqualToString:@"赠品专区"])
        {
            header.goods_nameLab.text=_sgiftDetailModel.data.goodsInfo.goods_name;
            header.goods_briefLab.text=_sgiftDetailModel.data.goodsInfo.goods_brief;
            header.shop_priceLab.text=[NSString stringWithFormat:@"【在售价】¥%@",_sgiftDetailModel.data.goodsInfo.shop_price];
            header.sell_numLab.text=[NSString stringWithFormat:@"【已售】%@件",_sgiftDetailModel.data.goodsInfo.sell_num];
        }

        
        reusableview = header;
        
    }// header;
    return reusableview;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    CGSize size = {414,416};
    return size;
}
-(NSString *)selectGoods
{
    if (_overType==NULL) {
        
        for (int i=0; i<_goodsInfor.data.goods_banner.count; i++) {
            SGoodsGoodsInfo * model=_goodsInfor.data.goods_banner[i];
            if (model.RBtn_BOOL) {
                return model.path;
            }
        }
        
    }
    if ([_overType isEqualToString:@"限量购"]) {
   
        
        for (int i=0; i<_LimitBuyInfo.data.goods_banner.count; i++) {
            SLimitBuyLimitBuyInfo * model=_LimitBuyInfo.data.goods_banner[i];
            if (model.RBtn_BOOL) {
                return model.path;
            }
        }
        
        
        
    }
    if ([_overType isEqualToString:@"拼单购"]) {
   
        for (int i=0; i<_GroupBuyInfo.data.goods_banner.count; i++) {
            SGoodsGoodsInfo * model=_GroupBuyInfo.data.goods_banner[i];
            if (model.RBtn_BOOL) {
                return model.path;
            }
        }
        
        
    }
    if ([_overType isEqualToString:@"无界预购"])
    {
        for (int i=0; i<_preBuyPreBuyInfo.data.goods_banner.count; i++) {
            SPreBuyPreBuyInfo * model=_preBuyPreBuyInfo.data.goods_banner[i];
            if (model.RBtn_BOOL) {
                return model.path;
            }
        }
        
    }
    if ([_overType isEqualToString:@"无界商店"])
    {
        for (int i=0; i<_integralBuyIntegralBuyInfo.data.goods_banner.count; i++) {
            SIntegralBuyIntegralBuyInfo * model=_integralBuyIntegralBuyInfo.data.goods_banner[i];
            if (model.RBtn_BOOL) {
                return model.path;
            }
        }
    }
    
    if  ([_overType isEqualToString:@"赠品专区"])
    {
        for (int i=0; i<_sgiftDetailModel.data.goods_banner.count; i++) {
            SgiftDetailModel * model=_sgiftDetailModel.data.goods_banner[i];
            if (model.RBtn_BOOL) {
                return model.path;
            }
        }
 
    }
    
    return nil;
    
}
- (IBAction)btnPress:(id)sender {
    
    SGoodsInfoPosterModel *model=[[SGoodsInfoPosterModel alloc]init];
    NSString *str=[self selectGoods];
    if (str.length==0) {
        [MBProgressHUD showSuccess:@"选择一个图片" toView:self.view];
        return;
    }
    else
    {
        model.goods_img=str;
    }
    NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
    if (invite_code.length!=0) {
        model.invite_code=invite_code;
    }
    if (_overType==NULL) {
        
        model.id=_goodsInfor.data.goodsInfo.goods_id;
        model.goods_name=_goodsInfor.data.goodsInfo.goods_name;
        model.integral=_goodsInfor.data.goodsInfo.integral;
        model.discount=_goodsInfor.data.goodsInfo.ticket_buy_discount;
        model.shop_price=_goodsInfor.data.goodsInfo.shop_price;
        model.market_price=_goodsInfor.data.goodsInfo.market_price;
        model.shop_id=@"";
        if ([_is_active_5 isEqualToString:@"5"]) {
              model.type=@"11";
              model.is_active_5=_is_active_5;
        }
        else
        {
            model.type=@"1";
        }
        
    }
    if ([_overType isEqualToString:@"限量购"]) {
    }
    if ([_overType isEqualToString:@"拼单购"]) {
      
        model.id=_goodid;
        model.goods_name=_GroupBuyInfo.data.goodsInfo.goods_name;
        model.integral=_GroupBuyInfo.data.goodsInfo.integral;
        model.discount=_GroupBuyInfo.data.goodsInfo.ticket_buy_discount;
        model.shop_price=_GroupBuyInfo.data.goodsInfo.shop_price;
        model.market_price=_GroupBuyInfo.data.goodsInfo.market_price;
        model.shop_id=@"";
        
        if ([_type isEqualToString:@"21"]) {
              model.type=@"21";
        }
        else if ([_type isEqualToString:@"22"])
        {
            model.type=@"22";
        }
        else
        {
            model.type=@"2";
        }
        
    }
    if ([_overType isEqualToString:@"无界预购"])
    {
    }
    if ([_overType isEqualToString:@"无界商店"])
    {
        model.type=@"3";
        
        model.id=_goodid;
        model.goods_name=_integralBuyIntegralBuyInfo.data.goodsInfo.goods_name;
        model.integral=_integralBuyIntegralBuyInfo.data.goodsInfo.integral;
        model.discount=_integralBuyIntegralBuyInfo.data.goodsInfo.ticket_buy_discount;
        model.shop_price=_integralBuyIntegralBuyInfo.data.goodsInfo.shop_price;
        model.market_price=_integralBuyIntegralBuyInfo.data.goodsInfo.market_price;
        model.shop_id=@"";
    }
    
    if  ([_overType isEqualToString:@"赠品专区"])
    {
        model.type=@"5";
        model.id=_sgiftDetailModel.data.goodsInfo.gift_goods_id;
        model.goods_name=_sgiftDetailModel.data.goodsInfo.goods_name;
        model.integral=_sgiftDetailModel.data.goodsInfo.integral;
        model.discount=_sgiftDetailModel.data.goodsInfo.ticket_buy_discount;
        model.shop_price=_sgiftDetailModel.data.goodsInfo.shop_price;
        model.market_price=_sgiftDetailModel.data.goodsInfo.market_price;
        model.shop_id=@"";
        
    }
    
      [MBProgressHUD showMessage:@"生成中" toView:self.view];
    [model sGoodsGoodsInfoSuccess:^(NSString *code, NSString *message, id data) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSDictionary * model = (NSDictionary *)data;
        if ([code intValue]==1) {
            NSDictionary *arr=    model[@"data"];
               [self showThebgview];
            _choseview =[[SGoodsInforPosterPlay alloc] initWithFrame:CGRectMake(40,100, Screen_width-80, Screen_height-200)];
           // imag=arr[@"img"];
            _choseview.img=arr[@"img"];
            [_choseview reloadView];
           [self.view.window addSubview:_choseview];

        }
        else
        {
           [MBProgressHUD showError:@"生成有误" toView:self.view];
        }

    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
//加载背景蒙板
-(void)showThebgview{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    bgView.backgroundColor=[UIColor colorWithRed:60.0/255 green:60.0/255 blue:60.0/255 alpha:1];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(Screen_width/2-50, Screen_height-100, 100, 100);
    [button setImage:[UIImage imageNamed:@"白色关闭"] forState:UIControlStateNormal];
  //  [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [button setTintColor:[UIColor whiteColor]];
    [bgView addSubview:button];
    
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
-(void)cancel{
  [self hidThebgview];
  [_choseview removeFromSuperview];

}
//-(void)longPressView:(UILongPressGestureRecognizer *)longPressGest{
//
//    NSLog(@"%ld",longPressGest.state);
//    if (longPressGest.state==UIGestureRecognizerStateBegan) {
//
//        NSLog(@"长按手势开启");
//    } else {
//        NSLog(@"长按手势结束");
//         NSData *dateImg = [NSData dataWithContentsOfURL:[NSURL URLWithString:imag]];
//        UIImage *mag=[UIImage imageWithData:dateImg];
//        UIImageWriteToSavedPhotosAlbum(mag, self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
//    }
//
//}
//- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
//    [MBProgressHUD showSuccess:@"已成功保存到相册!" toView:[UIApplication sharedApplication].delegate.window];
//}
@end

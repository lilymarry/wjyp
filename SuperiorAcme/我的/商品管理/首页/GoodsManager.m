//
//  GoodsManager.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/22.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "GoodsManager.h"
#import "GoodsManager_leftCell.h"
#import "GoodsManager_rightCell.h"
#import "OsManageListModel.h"
#import "OsManageCateListModel.h"
#import "GoodsManager_headCell.h"
#import "GoodsManagerItemList.h"
#import "OsManageCateMoveModel.h"
#import "AddGoodListViewController.h"
#import "AddAppStageGoodS.h"
#import "SlineDetailWebController.h"
@interface GoodsManager ()
<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,refrechtViewDelegate,AddGoodListViewDelegate>
{
   
    NSString * cate_id;//顶级分类id
    NSArray * arr;
    NSString *cate_name;
    BOOL isPiLiang;
    BOOL allSelect;
    NSString *type;//选择状态
    
    NSString * slineStr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;

@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic)  NSArray *brr;


@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;



@property (strong, nonatomic) IBOutlet UIButton *piliangBtn;
@property (strong, nonatomic) IBOutlet UIView *view4;
@property (strong, nonatomic) IBOutlet UIButton *view4_btn;


@property (strong, nonatomic) IBOutlet UIButton *fenleiBtn;
@property (strong, nonatomic) IBOutlet UIButton *startOrStopBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *startOrStopBtnHHH;

@property (strong, nonatomic) IBOutlet UIView *noDataView;

@end

@implementation GoodsManager

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商品管理";
    
    [self createUI];
    _brr=[NSArray array];
    
    isPiLiang =NO;
    allSelect=NO;
 
    OsManageListModel *model=[[OsManageListModel alloc]init];
    model.type=@"1";
    model.sta_mid=_sta_mid;
      [MBProgressHUD showMessage:nil toView:self.view];
    [model OsManageListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data, NSString * _Nonnull nums) {
          [MBProgressHUD hideHUDForView:self.view animated:YES];
         OsManageListModel *model=(OsManageListModel *)data;
         arr = model.data;
        if (arr.count>0) {
            OsManageListModel * list = arr[0];
            cate_id=list.id;
            cate_name=list.name;
            [self  showModel];
        }
        [_mTable reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
    [_view4_btn addTarget:self action:@selector(view4BtnPress) forControlEvents:UIControlEventTouchUpInside];

    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(handleSingleFingerEvent:)];
    [_backView addGestureRecognizer:singleFingerOne];
    _backView.hidden=YES;
    

}
-(void)getSetUrl
{
    AddAppStageGoodS *model1=[[AddAppStageGoodS alloc]init];
    model1.sta_mid=_sta_mid;
    
    [model1 AddAfterAppStageGoodSSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, NSDictionary * _Nonnull dic) {
        
        if ([dic[@"status"] intValue]==0) {
            
            slineStr=dic[@"url"];
        }
        else
        {
            slineStr=@"";
        }
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    _view3.hidden=YES;
    isPiLiang=NO;
    _backView.hidden=YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    _view3.hidden=YES;
     _backView.hidden=YES;
    isPiLiang=NO;
    [self getSetUrl];
}
- (void)showModel {
    OsManageCateListModel * index = [[OsManageCateListModel alloc] init];
    index.cate_id = cate_id;
    index.sta_mid=_sta_mid;
    [MBProgressHUD showMessage:nil toView:self.view];
    [index OsManageCateListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            OsManageCateListModel * list = (OsManageCateListModel *)data;
            _brr = list.data.cate_goods_list;
            if (_brr.count==0) {
                _noDataView.hidden=NO;
                _mCollect.hidden=YES;
            }
            else {
                _noDataView.hidden=YES;
                _mCollect.hidden=NO;
            }
            [_mCollect reloadData];
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
       
       
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (void)createUI {
    [_mTable registerNib:[UINib nibWithNibName:@"GoodsManager_leftCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GoodsManager_leftCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mTable.showsVerticalScrollIndicator = NO;
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
    _mCollect.collectionViewLayout = mFlowLayout;
    [_mCollect registerNib:[UINib nibWithNibName:@"GoodsManager_rightCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"GoodsManager_rightCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"GoodsManager_headCell" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodsManager_headCell"];

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsManager_leftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsManager_leftCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    OsManageListModel * list = arr[indexPath.row];
    cell.nameLab.text = list.name;
    if ([cate_id isEqualToString:list.id]) {
    cell.contentView.backgroundColor = [UIColor whiteColor];
        } else {
           cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OsManageListModel * list = arr[indexPath.row];
 
    cate_id = list.id;
    cate_name=list.name;
 
    [_mTable reloadData];
     [self showModel];
  
    _view4.hidden=YES;
    _view3.hidden=YES;
    _view2.hidden=NO;
    _view1.hidden=YES;
     _backView.hidden=YES;
    isPiLiang=NO;
    allSelect=NO;
    [self RefreshCollectionViewWithEditStatus:NO];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _brr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW - 90, 82);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        GoodsManager_headCell * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodsManager_headCell" forIndexPath:indexPath];

       header.nameLab.text = cate_name;
        if (allSelect==YES) {
            header.allBtn.hidden=NO;
        }
        else
        {
          header.allBtn.hidden=YES;
        }
        [header.allBtn addTarget:self action:@selector(allPress:) forControlEvents:UIControlEventTouchUpInside];
        reusableview = header;

    }
   
    return reusableview;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {ScreenW - 90,50};
    return size;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsManager_rightCell * cell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"GoodsManager_rightCell" forIndexPath:indexPath];
    
    OsManageCateListModel * list =_brr[indexPath. row];

    [cell.goodIma sd_setImageWithURL:[NSURL URLWithString:list.goods_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.nameLab.text = list.name;
   
   if([list.sup_type isEqualToString:@"1"]) {
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@/份",list.shop_price]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,list.shop_price.length+1)];
       
        cell.priceLab.attributedText = AttributedStr;
    }
    else if([list.sup_type isEqualToString:@"2"]) {
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"               ¥%@/份",list.church_shop_price]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(15,list.church_shop_price.length+1)];
        
        cell.priceLab.attributedText = AttributedStr;
    }
    else {
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@/份 %@/份 ",list.shop_price,list.church_shop_price]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,list.shop_price.length+1)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(list.shop_price.length+3,list.church_shop_price.length+1)];
        
        cell.priceLab.attributedText = AttributedStr;
    }
  
    
    if ([cate_name isEqualToString:@"待递交"]||[cate_name isEqualToString:@"待审核"]||[cate_name isEqualToString:@"审核失败"]) {
        cell.cNameLab.hidden=NO;
        cell.cNameLab.text=[NSString stringWithFormat:@"(%@)",list.c_name];
        cell.qishouLab.hidden=YES;
        cell.guigeLab.text=nil;
        
        
    }
    else
    {
         cell.cNameLab.hidden=YES;
        cell.qishouLab.hidden=NO;
        if ([list.is_sale intValue]==1) {
            cell.qishouLab.text=@"已启售";
          
            cell.qishouLab.backgroundColor=[UIColor colorWithRed:246/255.0 green:75/255.0 blue:16/255.0 alpha:1];
          
        }
        else{
            cell.qishouLab.text=@"已停售";
           
             cell.qishouLab.backgroundColor=[UIColor lightGrayColor];
           
        }
        if ([list.attr_count intValue]==0) {
             cell.guigeLab.text=nil;
        }
        else
        {
            cell.guigeLab.text=@" 已设规格 ";
        }
    }
    
    if (list.isturnEditStatus) {
        cell.selectbtn.hidden=NO;
        cell.jiantouIma.hidden=YES;
        
    }else{
         cell.selectbtn.hidden=YES;
         cell.jiantouIma.hidden=NO;
    }
    
    if([list.label_int isEqualToString:@"1"]) {
        cell.labLab.text=@"招牌";
        cell.labLab.backgroundColor=[UIColor colorWithRed:215/255.0 green:75/255.0 blue:66/255.0 alpha:1];
    }
    else if([list.label_int isEqualToString:@"2"]) {
        cell.labLab.text=@"推荐";
        cell.labLab.backgroundColor=[UIColor colorWithRed:243/255.0 green:121/255.0 blue:48/255.0 alpha:1];
    }
    else if([list.label_int isEqualToString:@"0"]) {
        if ([self exchangTime:list.create_time]<=72) {
            cell.labLab.text=@"新品";
            cell.labLab.backgroundColor=[UIColor colorWithRed:141/255.0 green:202/255.0 blue:44/255.0 alpha:1];
        }
        else
        {
            cell.labLab.text=@"";
            cell.labLab.backgroundColor=[UIColor clearColor];
        }
        
    }
    else if([list.label_int isEqualToString:@"3"]) {
        cell.labLab.text=@"链店";
        cell.labLab.backgroundColor=[UIColor colorWithRed:172/255.0 green:121/255.0 blue:177/255.0 alpha:1];
    }
    else
    {
        cell.labLab.text=@"";
        cell.labLab.backgroundColor=[UIColor clearColor];
    }
    if (list.isSelect) {
        [ cell.selectbtn setImage:[UIImage imageNamed:@"选中"]];
    }
    else
    {
        [ cell.selectbtn setImage:[UIImage imageNamed:@"未选中"]];
    }
  
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsManager_rightCell * cell = (GoodsManager_rightCell *)[collectionView cellForItemAtIndexPath:indexPath];
    OsManageCateListModel * model =_brr[indexPath. row];
    if (model.isturnEditStatus) {
        model.isSelect = !model.isSelect;
      //  cell.selectbtn.selected = model.isSelect;
        if (model.isSelect) {
            [ cell.selectbtn setImage:[UIImage imageNamed:@"选中"]];
        }
        else
        {
            [ cell.selectbtn setImage:[UIImage imageNamed:@"未选中"]];
        }
    }
    else
    {
        if ([cate_name isEqualToString:@"待递交"]||[cate_name isEqualToString:@"审核失败"]) {
            AddGoodListViewController *add=[[AddGoodListViewController alloc]init];
            add.goods_id=model.goods_id;
            add.sta_mid=_sta_mid;
            add.type=@"2";
            add.delgate=self;
            [self.navigationController pushViewController:add animated:YES];
        }
       else if ([cate_name isEqualToString:@"待审核"]) {
        }
        else
        {
            if ([model.is_sale intValue]==1) {
                AddGoodListViewController *add=[[AddGoodListViewController alloc]init];
                add.goods_id=model.goods_id;
                add.sta_mid=_sta_mid;
                add.type=@"3";
                add.delgate=self;
                [self.navigationController pushViewController:add animated:YES];
                
            }
            else{
                AddGoodListViewController *add=[[AddGoodListViewController alloc]init];
                add.goods_id=model.goods_id;
                add.sta_mid=_sta_mid;
                add.type=@"2";
                add.delgate=self;
                [self.navigationController pushViewController:add animated:YES];
                
            }
            
        }
       
    }
  
    
}
//普通商品时,刷新CollectionView,用于进入和退出编辑状态
-(void)RefreshCollectionViewWithEditStatus:(BOOL)editStatus{
    
    for (OsManageCateListModel * model in _brr) {
        model.isturnEditStatus = editStatus;
    }
    
    [_mCollect reloadData];
}
#pragma mark 批量弹窗
- (IBAction)piliangPress:(id)sender {
    
    if ([cate_name isEqualToString:@"待审核"]) {
     [MBProgressHUD showError:@"该组不支持批量操作" toView:self.view];
    }
    else {
        isPiLiang=!isPiLiang;
        
        if (isPiLiang) {
            _view3.hidden=NO;
            _backView.hidden=NO;
            if ([cate_name isEqualToString:@"待递交"]||[cate_name isEqualToString:@"审核失败"]) {
                _startOrStopBtn.hidden=YES;
                _startOrStopBtnHHH.constant=0;
            }
            else{
                _startOrStopBtn.hidden=NO;
                _startOrStopBtnHHH.constant=65;
            }
            
            if ([cate_name isEqualToString:@"待递交"]) {
                [_fenleiBtn setTitle:@"递交" forState:UIControlStateNormal];
                [_fenleiBtn setImage:[UIImage imageNamed:@"递交"] forState:UIControlStateNormal];
                type=@"3";
            }
           else if ([cate_name isEqualToString:@"审核失败"]) {
                [_fenleiBtn setTitle:@"重新递交" forState:UIControlStateNormal];
                [_fenleiBtn setImage:[UIImage imageNamed:@"递交"] forState:UIControlStateNormal];
                 type=@"4";
            }
           else{
               [_fenleiBtn setTitle:@"分类" forState:UIControlStateNormal];
                [_fenleiBtn setImage:[UIImage imageNamed:@"分类管理白"] forState:UIControlStateNormal];
               type=@"1";
           }
        
          
        }
        else
        {
            _view3.hidden=YES;
             type=@"";
             _backView.hidden=YES;
        }
       
    }

    
}
#pragma mark 批量弹窗 分类
- (IBAction)fenleiInPingLiangViewPress:(id)sender
{
   
    _view4.hidden=NO;
    _view3.hidden=YES;
    _view2.hidden=YES;
    _view1.hidden=YES;
     _backView.hidden=YES;
    if ([type isEqualToString:@"1"]) {
          [_view4_btn setTitle:@"移动到" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"3"]||[type isEqualToString:@"4"])
    {
         [_view4_btn setTitle:@"递交" forState:UIControlStateNormal];
    }
 
    allSelect=YES;
   // _mCollect.allowsSelection = YES;
    [self RefreshCollectionViewWithEditStatus:YES];
}
#pragma mark 批量弹窗 停售/启售
- (IBAction)startOrStopInPingLiangViewPress:(id)sender
{
  
    _view4.hidden=YES;
    _view3.hidden=YES;
    _view2.hidden=YES;
    _view1.hidden=NO;
     allSelect=YES;
     _backView.hidden=YES;
  //  _mCollect.allowsSelection = YES;
    [self RefreshCollectionViewWithEditStatus:YES];
    
}
#pragma mark 批量弹窗 删除
- (IBAction)deletePress:(id)sender {
    
    type=@"2";
    _view4.hidden=NO;
    _view3.hidden=YES;
     _backView.hidden=YES;
    _view2.hidden=YES;
    _view1.hidden=YES;
    [_view4_btn setTitle:@"删除" forState:UIControlStateNormal];
     allSelect=YES;
   // _mCollect.allowsSelection = YES;
    [self RefreshCollectionViewWithEditStatus:YES];
}


#pragma mark  停售
- (IBAction)stopPress:(id)sender {
 
    if ([self selectGoods].count>0) {
     
      [self AlertOperationTipMessageWithMsg:@"确定要停售商品？" Withtag:@"停售" goodsArr:[self selectGoods]];
       
        
    }
    else
    {
        [MBProgressHUD showError:@"至少选择一个商品" toView:self.view];
    }
    
}
#pragma mark  启售
- (IBAction)startPress:(id)sender {
    if (slineStr.length!=0) {
        SlineDetailWebController  *sline=[[SlineDetailWebController alloc]init];
        sline.fag=@"16";
        sline.urlStr=slineStr;
        [self.navigationController pushViewController:sline animated:YES];
    }
    else
    {
        if ([self selectGoods].count>0) {
            [self AlertOperationTipMessageWithMsg:@"确定要启售商品？" Withtag:@"启售" goodsArr:[self selectGoods]];
        }
        else
        {
            [MBProgressHUD showError:@"至少选择一个商品" toView:self.view];
        }
    }
   
    
}
#pragma mark 分类管理
- (IBAction)fenleiManagerPress:(id)sender {
    GoodsManagerItemList *list=[[GoodsManagerItemList alloc]init];
    list.sta_mid=_sta_mid;

    list.type=@"2";
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark 录入
- (IBAction)luruGoodsPress:(id)sender {
    
    if (slineStr.length!=0) {
        SlineDetailWebController  *sline=[[SlineDetailWebController alloc]init];
        sline.fag=@"16";
        sline.urlStr=slineStr;
        [self.navigationController pushViewController:sline animated:YES];
    }
    else
    {
        AddGoodListViewController *add=[[AddGoodListViewController alloc]init];
        add.sta_mid=_sta_mid;
        add.type=@"1";
        add.delgate=self;
        [self.navigationController pushViewController:add animated:YES];
    }
   
    
}
-(void)allPress:(UIButton *)sender
{
    for (OsManageCateListModel * model in _brr) {
        model.isSelect = YES;
    }
    
    [_mCollect reloadData];
    
}

-(void)view4BtnPress
{
  
    if ([self selectGoods].count>0) {
        if ([type isEqualToString:@"1"]) {
            GoodsManagerItemList *list=[[GoodsManagerItemList alloc]init];
            list.sta_mid=_sta_mid;
            list.goods_idArr=[NSArray arrayWithArray:[self selectGoods]];
            list.delgate=self;
            list.type=@"1";
            [self.navigationController pushViewController:list animated:YES];
        }
      else  if ([type isEqualToString:@"3"]||[type isEqualToString:@"4"]) {
         [self AlertOperationTipMessageWithMsg:@"确定要递交？" Withtag:@"递交" goodsArr:[self selectGoods]];
        }
      else
        {
            [self AlertOperationTipMessageWithMsg:@"确定要删除？" Withtag:@"删除" goodsArr:[self selectGoods]];
        }
       
    }
    else
    {
         [MBProgressHUD showError:@"至少选择一个商品" toView:self.view];
    }
    
   
    
}

-(NSArray *)selectGoods
{
    NSMutableArray *arr=[NSMutableArray array];
    for (int i=0; i<_brr.count; i++) {
        OsManageCateListModel * model=_brr[i];
        if (model.isSelect) {
            NSDictionary *dic=@{@"id":model.goods_id};
            [arr addObject:dic];
        }
    }
    return arr;
    
}
-(void)refrechtView:(NSString *)itemId name:(nonnull NSString *)name
{
    cate_id = itemId;
    cate_name=name;
    
    [_mTable reloadData];
    [self showModel];
    
    _view4.hidden=YES;
    _view3.hidden=YES;
     _backView.hidden=YES;
    _view2.hidden=NO;
    _view1.hidden=YES;
    
    isPiLiang=NO;
    allSelect=NO;
   // _mCollect.allowsSelection = NO;
    [self RefreshCollectionViewWithEditStatus:NO];
}
-(void)AlertOperationTipMessageWithMsg:(NSString *)msgString Withtag:(NSString *)tag goodsArr:(NSArray *)arr {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msgString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     
        [self deleteOrStopBeginGoods:arr andTag:tag];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)deleteOrStopBeginGoods:(NSArray *)arr andTag:(NSString *)tag
{
    OsManageCateMoveModel *model=[[OsManageCateMoveModel alloc]init];
    model.goods_id=arr;
    if ([tag isEqualToString:@"删除"]) {
        model.type=@"2";
    }
    if ([tag isEqualToString:@"启售"]) {
         model.type=@"3";
         model.is_sale=@"1";
    }
    if ([tag isEqualToString:@"停售"]) {
        model.type=@"3";
        model.is_sale=@"0";
    }
    if ([tag isEqualToString:@"递交"]) {
        model.type=@"4";
       
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [model OsManageCateMoveModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==1) {
            [MBProgressHUD showSuccess:@"操作成功" toView:self.view];
            [_mTable reloadData];
            [self showModel];
            _view4.hidden=YES;
            _view3.hidden=YES;
             _backView.hidden=YES;
            _view2.hidden=NO;
            _view1.hidden=YES;
            
            isPiLiang=NO;
            allSelect=NO;
           // _mCollect.allowsSelection = NO;
            [self RefreshCollectionViewWithEditStatus:NO];
        }

        else
        {
            [MBProgressHUD showSuccess:message toView:self.view];
        }
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];

    }];
    
}
-(void)refrechGoodListView
{
    cate_id = @"0";
    cate_name=@"待递交";
    
    [_mTable reloadData];
    [self showModel];
    
    _view4.hidden=YES;
    _view3.hidden=YES;
     _backView.hidden=YES;
    _view2.hidden=NO;
    _view1.hidden=YES;
    
    isPiLiang=NO;
    allSelect=NO;
    // _mCollect.allowsSelection = NO;
    [self RefreshCollectionViewWithEditStatus:NO];
}
-(NSInteger)exchangTime:(NSString *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //然后创建日期对象
    NSDate *date1 = [dateFormatter dateFromString:time];
    NSDate *date2 = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取两个日期的间隔
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay|NSCalendarUnitHour fromDate:date1 toDate:date2 options:NSCalendarWrapComponents];
    NSInteger hour = (comp.hour + comp.day * 24);
    NSLog(@"sadasd %ld",hour);
    return hour;
}

@end

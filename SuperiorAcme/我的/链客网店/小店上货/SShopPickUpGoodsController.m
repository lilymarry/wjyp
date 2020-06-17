//
//  SShopPickUpGoodsController.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SShopPickUpGoodsController.h"
#import "SItemView.h"
#import "SShopPickUpGoodCell.h"
#import "SShopPickUpModel.h"
#import "SASegementControlView.h"

@interface SShopPickUpGoodsController ()<UITableViewDelegate, UITableViewDataSource,DZMSegmentedControlDelegate,SShopPickUpGoodCellDelegate>
{
    NSIndexPath *_lastSelectIndex;   //记录(滚动条 箭头)点选位置
    NSMutableDictionary *_selectPara;//记录排序点击参数
}
@property (weak, nonatomic) IBOutlet UIView *CategoryView;
@property (weak, nonatomic) IBOutlet UIView *chooseGoodSortContainerView;
@property (weak, nonatomic) IBOutlet UITableView *pickUpTable;
@property (nonatomic, strong) UIButton * previousBtn;
@property (nonatomic, strong) NSArray * TwoCateListArr;
@property (nonatomic, strong) NSMutableArray * GoodsListArr;

@property (nonatomic, strong) SASegementControlView *segementControlView;
@property (nonatomic, strong) NSMutableArray *staticPara; //接口所需排序参数
@property (assign,nonatomic) NSInteger page;

@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;
@end

NSString * PickUpGoodCellID = @"PickUpGoodCellID";

@implementation SShopPickUpGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小店上货";
    _page = 1;
   _lastSelectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_pickUpTable registerNib:[UINib nibWithNibName:NSStringFromClass([SShopPickUpGoodCell class]) bundle:nil] forCellReuseIdentifier:PickUpGoodCellID];
    
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //实现按钮内的文字在左,图片在又的布局
    for (UIButton * btn in self.chooseGoodSortContainerView.subviews) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(btn.imageView.frame.size.width), 0, (btn.imageView.frame.size.width))];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (btn.titleLabel.frame.size.width), 0, -(btn.titleLabel.frame.size.width))];
    }
    
//    [self GetShopPickUpGoodList:nil];
    [self refreshAndLoadMoreMethod];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - =========================== UITableViewDataSource =============================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.GoodsListArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SShopPickUpGoodCell * cell = [tableView dequeueReusableCellWithIdentifier:PickUpGoodCellID forIndexPath:indexPath];
    cell.pickUpModel = self.GoodsListArr[indexPath.row];
    cell.index=indexPath;
    cell.delegate = self;
    return cell;
}

#pragma mark - =========================== UITableViewDelegate =============================
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     SShopPickUpModel *model = self.GoodsListArr[indexPath.item];
    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
    info.goods_id = model.goods_id;
    info.overType = NULL;
    [self.navigationController pushViewController:info animated:YES];
}
- (IBAction)ChooseGoodSort:(UIButton *)sender {

   
    static NSUInteger clickCount = 0;//用于记录当前按钮的点击次数,对点击次数求余,根据余数设置selected状态下的图片的显示
    if (self.previousBtn != sender) {
        self.previousBtn.selected = NO;
        sender.selected = YES;
        self.previousBtn = sender;
        [self.previousBtn setImage:[UIImage imageNamed:@"升序"] forState:UIControlStateSelected];
        clickCount = 0;
    }else{
    
        if (clickCount % 2 == 0) {
            //记录余数,用于向服务器发送需求的排序
            [sender setImage:[UIImage imageNamed:@"升序"] forState:UIControlStateSelected];
        }else{
            //记录余数,用于向服务器发送需求的排序
            [sender setImage:[UIImage imageNamed:@"降序"] forState:UIControlStateSelected];
        }
   }
    clickCount++;
    //将key值 进行存储   2.标记哪个btn 取值
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:self.staticPara[0][@"name"][sender.tag - 10] forKey:@"name"];
    [para setValue:self.staticPara[0][@"flag"][clickCount % 2] forKey:@"flag"];
    //在这里进行数据请求传参数 ...
    [self GetShopPickUpGoodList:para];
    _selectPara = para;
}

- (void)refreshAndLoadMoreMethod{
    @weakify(self);
    _pickUpTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.page = 1;
        [weak_self GetShopPickUpGoodList:nil];
    }];
    [_pickUpTable.mj_header beginRefreshing];
    
    _pickUpTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weak_self.page ++;
        [weak_self GetShopPickUpGoodList:nil];
    }];
}

-(void)GetShopPickUpGoodList:(NSDictionary *)para
{
   [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    @weakify(self);
    SShopPickUpModel *model = [SShopPickUpModel new];
    model.p = _page;
    
    if (!SWNOTEmptyDictionary(para)) {
        para = _selectPara;
    }
    
    if (SWNOTEmptyDictionary(para)) {
        model.name = para[@"name"];
        model.flag = para[@"flag"];
    }
    
    if (_lastSelectIndex) { //刷新加载 调用这块
        SShopPickUpModel *selectModel = weak_self.TwoCateListArr[_lastSelectIndex.item];
        model.cate_id = selectModel.cate_id;
    }
    
    [model GetShopPickUpGoodsListWith:^(NSString *code, NSString *message, id data, NSString *nums) {
      [MBProgressHUD hideHUDForView:self.view animated:NO];
        
        SShopPickUpModel * model =(SShopPickUpModel *)data;
        
        if (SUCCESS_STATE(code)) {
            if (weak_self.page == 1) {
                weak_self.TwoCateListArr = model.top_nav;
                if (SWNOTEmptyArr(weak_self.GoodsListArr)) {
                    [weak_self.GoodsListArr removeAllObjects];
                }
                [self UpdateUI];
            }
            if (SWNOTEmptyArr(model.list)) {
               [weak_self.GoodsListArr addObjectsFromArray:model.list];
            }
           
        }else{
           [MBProgressHUD showSuccess:message toView:self.view];
        }
        
        [self.pickUpTable reloadData];
        [weak_self.pickUpTable.mj_footer endRefreshing];
        [weak_self.pickUpTable.mj_header endRefreshing];
    } andFailure:^(NSError *error) {
      //  [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
        [weak_self.pickUpTable.mj_footer endRefreshing];
        [weak_self.pickUpTable.mj_header endRefreshing];
    }];
}

-(void)UpdateUI{

    if (!_segementControlView) {
        SShopPickUpModel *model = [self.TwoCateListArr firstObject];
        model.isClicked = YES;
        
        SASegementControlView *aView = [[SASegementControlView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, [SASegementControlView barViewHeight]) datas:self.TwoCateListArr];
        [self.CategoryView addSubview:_segementControlView = aView];
        aView.segmentedControl.delegate = self;
        
        [aView otherViewSettingWithSuperView:self.view];
    }
}

#pragma mark -DZMSegmentedControlDelegate

-(void)segmentControl:(DZMSegmentedControl *)segmentedControl
           clickIndex:(NSInteger)index{
    
    self.previousBtn.selected = NO;
    [self.previousBtn setImage:[UIImage imageNamed:@"未排序3"] forState:0];
    _previousBtn = nil;
    _page = 1;
   _selectPara = nil;
    
    SShopPickUpModel *lastModel = self.TwoCateListArr[_lastSelectIndex.row];
    lastModel.isClicked = NO;
    
    SShopPickUpModel *currentModel = self.TwoCateListArr[index];
    currentModel.isClicked = YES;
    
    _lastSelectIndex = [NSIndexPath indexPathForRow:index inSection:0];
    
    [_segementControlView.overView.collectionView selectItemAtIndexPath:_lastSelectIndex animated:NO scrollPosition:UICollectionViewScrollPositionCenteredVertically];
    
    [_segementControlView.overView.collectionView reloadData];
    
        if (index != _lastSelectIndex.item) {
            if (SWNOTEmptyArr(self.GoodsListArr)) {
                [self.GoodsListArr removeAllObjects];
                
            }
       }
    
    //点击全部时 排序归零
   if(index == 0){
        self.previousBtn.selected = NO;
        [self.previousBtn setImage:[UIImage imageNamed:@"未排序3"] forState:0];
        _page = 1;
        _previousBtn = nil;
        _lastSelectIndex = nil;
        _selectPara = nil;
    }
        //在这里进行数据请求传参数 ...
        [self GetShopPickUpGoodList:@{@"cate_id":currentModel.cate_id}];
    
}

#pragma mark - SShopPickUpGoodCellDelegate

- (void)putawayGoodsBtnClick:(SShopPickUpGoodCell *)cell andIndex:(NSIndexPath *)index{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
   NSIndexPath *indexPath = [_pickUpTable indexPathForCell:cell];
    SShopPickUpModel *model = self.GoodsListArr[indexPath.item];
    SShopPickUpModel *paraModel = [SShopPickUpModel new];
    paraModel.shop_id = _shopId;
    paraModel.goods_id = model.goods_id;
    paraModel.is_special=@"0";
    paraModel.shop_goods_status=@"0";
    [paraModel putawayGoodsMethod:^(NSString *code, NSString *message, id data, NSString *nums) {
      [MBProgressHUD hideHUDForView:self.view animated:NO];
     //   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:message toView:self.view];
          //   [self refreshAndLoadMoreMethod];
     //   });
        if (SUCCESS_STATE(code)) {
           [self.GoodsListArr removeObjectAtIndex:index.row];
            [_pickUpTable beginUpdates];
            [_pickUpTable deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
            [_pickUpTable endUpdates];
            [_pickUpTable reloadData];
         
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
    
}

- (NSMutableArray *)GoodsListArr{
    if (!_GoodsListArr) {
        _GoodsListArr = [NSMutableArray array];
    }
    return _GoodsListArr;
}

- (NSMutableArray *)staticPara{
    if (!_staticPara) {
        _staticPara = [NSMutableArray array];
        [_staticPara addObject:@{@"name":@[@"red_return_integral",
                                           @"discount",
                                           @"new_sell_num",
                                           @"shop_price"],
                                 @"flag":@[@"desc",@"asc"]
                                 }];
    }
    return _staticPara;
}

@end

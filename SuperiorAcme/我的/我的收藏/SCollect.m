//
//  SCollect.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCollect.h"
#import "XRWaterfallLayout.h"
#import "SOnlineShopCell.h"
#import "SSearch_contentCell.h"
#import "SCollectBookCell.h"
#import "SGoodsInfor.h"

@interface SCollect () <XRWaterfallLayoutDelegate>
{
    UIView * red_line;
    UIButton * rigthBtn;
    BOOL edit_isno;//NO默认 YES编辑
}
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mCollect_downHHH;
@property (strong, nonatomic) IBOutlet UITableView *twoTable;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *twoTable_downHHH;
@property (strong, nonatomic) IBOutlet UITableView *threeTable;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *threeTable_downHHH;
@property (strong, nonatomic) IBOutlet UIView *downView;
@property (strong, nonatomic) IBOutlet UIButton *deleBtn;
@property (strong, nonatomic) IBOutlet UIButton *allBtn;
@end

@implementation SCollect

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    red_line = [[UIView alloc] initWithFrame:CGRectMake(ScreenW/2 - 35 - 70, 48, 70, 2)];
    [_topView addSubview:red_line];
    red_line.backgroundColor = [UIColor redColor];
    //默认商品
    [_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _mCollect.hidden = NO;
    _twoTable.hidden = YES;
    _threeTable.hidden = YES;
    _downView.hidden = YES;
    //商品
    [_oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //商家
    [_twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //书院
    [_threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    XRWaterfallLayout * waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    [waterfall setColumnSpacing:5 rowSpacing:5 sectionInset:UIEdgeInsetsMake(-5, 0, 5, 0)];
    waterfall.delegate = self;
    _mCollect.collectionViewLayout = waterfall;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    //Cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    
    _twoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_twoTable registerNib:[UINib nibWithNibName:@"SSearch_contentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SSearch_contentCell"];
    
    _threeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_threeTable registerNib:[UINib nibWithNibName:@"SCollectBookCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SCollectBookCell"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"我的收藏";
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
    
    rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    if (edit_isno == NO) {
        [rigthBtn setTitle:@"完成" forState:UIControlStateNormal];
        edit_isno = YES;
        _downView.hidden = NO;
        _mCollect_downHHH.constant = 50;
        _twoTable_downHHH.constant = 50;
        _threeTable_downHHH.constant = 50;
        
    } else {
        [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
        edit_isno = NO;
        _downView.hidden = YES;
        _mCollect_downHHH.constant = 0;
        _twoTable_downHHH.constant = 0;
        _threeTable_downHHH.constant = 0;
        
    }
    [_mCollect reloadData];
    [_twoTable reloadData];
    [_threeTable reloadData];
}

#pragma mark - 商品
- (void)oneBtnClick {
    red_line.frame = CGRectMake(ScreenW/2 - 35 - 70, 48, 70, 2);
    [_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_twoBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [_threeBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    
    _mCollect.hidden = NO;
    _twoTable.hidden = YES;
    _threeTable.hidden = YES;
    
    [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
    edit_isno = NO;
    _downView.hidden = YES;
    _mCollect_downHHH.constant = 0;
    _twoTable_downHHH.constant = 0;
    _threeTable_downHHH.constant = 0;
    [_mCollect reloadData];
    [_twoTable reloadData];
    [_threeTable reloadData];
}
#pragma mark - 商家
- (void)twoBtnClick {
    red_line.frame = CGRectMake(ScreenW/2 - 35, 48, 70, 2);
    [_oneBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [_twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_threeBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];

    _mCollect.hidden = YES;
    _twoTable.hidden = NO;
    _threeTable.hidden = YES;
    
    [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
    edit_isno = NO;
    _downView.hidden = YES;
    _mCollect_downHHH.constant = 0;
    _twoTable_downHHH.constant = 0;
    _threeTable_downHHH.constant = 0;
    [_mCollect reloadData];
    [_twoTable reloadData];
    [_threeTable reloadData];
}
#pragma mark - 书院
- (void)threeBtnClick {
    red_line.frame = CGRectMake(ScreenW/2 + 35, 48, 70, 2);
    [_oneBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [_twoBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [_threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _mCollect.hidden = YES;
    _twoTable.hidden = YES;
    _threeTable.hidden = NO;
    
    [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
    edit_isno = NO;
    _downView.hidden = YES;
    _mCollect_downHHH.constant = 0;
    _twoTable_downHHH.constant = 0;
    _threeTable_downHHH.constant = 0;
    [_mCollect reloadData];
    [_twoTable reloadData];
    [_threeTable reloadData];
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    return ScreenW/2 - 2.5 + 40 + 30 + 30;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
    if (edit_isno == NO) {
        mCell.choiceBtn.hidden = YES;
    } else {
        mCell.choiceBtn.hidden = NO;
    }
    
    mCell.top_oneView.hidden = NO;
    mCell.top_oneView_HHH.constant = 0;//0
    mCell.goodsImage_HHH.constant = 40;//40;
    mCell.top_twoView_HHH.constant = 40;//40;
    mCell.top_twoView.hidden = YES;
    mCell.integral_num.hidden = NO;//已售xx件
    
    mCell.goods_PriceView.hidden = NO;
    mCell.goods_priceHHH.constant = 30;//30
    
    mCell.carView.hidden = YES;
    mCell.carView_HHH.constant = 0;//70
    
    mCell.houseView.hidden = YES;
    mCell.houseView_HHH.constant = 0;//90
    
    mCell.redView.hidden = YES;
    mCell.redView_HHH.constant = 0;//30
    
    mCell.timeView.hidden = YES;
    mCell.timeView_HHH.constant = 0;//30
    mCell.blueView.hidden = YES;
    mCell.blueView_HHH.constant = 0;//30
    
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SGoodsInfor * info = [[SGoodsInfor alloc] init];
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _threeTable) {
        return 1;
    }
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _threeTable) {
        return 7;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _threeTable) {
        return 0.01;
    }
    if (section == 0) {
        return 0.01;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _threeTable) {
        return 100;
    }
    return 230;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _threeTable) {
        SCollectBookCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCollectBookCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (edit_isno == NO) {
            cell.choiceBtn.hidden = YES;
            cell.headerImage_WWW.constant = 10;
            cell.line_WWW.constant = 10;
        } else {
            cell.choiceBtn.hidden = NO;
            cell.headerImage_WWW.constant = 40;
            cell.line_WWW.constant = 40;
        }
        return cell;
    }
    SSearch_contentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SSearch_contentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (edit_isno == NO) {
        cell.choiceBtn.hidden = YES;
    } else {
        cell.choiceBtn.hidden = NO;
    }
    
    return cell;
}
@end

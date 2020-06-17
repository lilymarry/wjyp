//
//  SHouseInfor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/3.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseInfor.h"
#import "SGoodsInfor_nav.h"
#import "SNBannerView.h"
#import "XRWaterfallLayout.h"
#import "SOnlineShopCell_house.h"
#import "SHouseInfor_subInfor.h"
#import "SHouseInforCell.h"
#import "SHouseInfor_top.h"
#import "SHouseBuyHouseInfo.h"

#import "SHouseBuyHouseStyleList.h"
#import "CQPlaceholderView.h"
#import "SHouseInfor_firstCell.h"
#import "SHouseInfor_topNew.h"
#import "SHouseInfor_downNew.h"

#import "SHouse_Map.h"
#import "SHouseBuyCommentList.h"
#import "SEvaAllCell.h"
#import "SOnlineShop_ClassInfoList_more_footerCont.h"

@interface SHouseInfor () <SNBannerViewDelegate,XRWaterfallLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    SGoodsInfor_nav * nav;
    
    NSArray * contentArr;
    
    NSMutableArray * arr;//列表
    NSInteger  page;
    
    CQPlaceholderView * placeholderView;
    
    SHouseInfor_topNew * topNew;
    SHouseInfor_downNew * downNew;
    
    NSString * model_lng;//经度
    NSString * model_lat;//纬度
    NSString * model_houseName;
    
    NSMutableArray * threeArr;
    NSString * model_label_id;
    SHouseInfor_top * top;
}

@property (strong, nonatomic) IBOutlet UITableView *mFirstTable;
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;

@property (strong, nonatomic) IBOutlet UIButton *callBtn;//拨打电话
@property (strong, nonatomic) IBOutlet UILabel *link_phone;
@property (weak, nonatomic) IBOutlet UIButton *moveTopBtn;



@end

@implementation SHouseInfor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
    
    //默认楼盘
    _mCollect.hidden = YES;
    _mTable.hidden = YES;
    _moveTopBtn.hidden = YES;

    //打电话
    [_callBtn addTarget:self action:@selector(callBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    SHouseBuyHouseInfo * infor = [[SHouseBuyHouseInfo alloc] init];
    infor.house_id = _house_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [infor sHouseBuyHouseInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SHouseBuyHouseInfo * infor = (SHouseBuyHouseInfo *)data;
            
            SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
            [topNew.bannerView addSubview:banner];
            
            topNew.house_name.text = infor.data.house_name;
            model_lng = infor.data.lng;
            model_lat = infor.data.lat;
            model_houseName = infor.data.house_name;
            _link_phone.text = infor.data.link_phone;
            
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@-%@/平",infor.data.min_price,infor.data.max_price]];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:WordColor_sub range:NSMakeRange(infor.data.min_price.length + infor.data.max_price.length + 1, 2)];
            topNew.scroll_price.attributedText = AttributedStr;
            
            topNew.thisAddress.text = [NSString stringWithFormat:@"%@%@%@%@",infor.data.province_name,infor.data.city_name,infor.data.area_name,infor.data.address];
            
            
            if (infor.data.comment_new.count == 0) {
                UIView * nowDownView = [[UIView alloc] init];
                _mFirstTable.tableFooterView = nowDownView;
                [downNew removeFromSuperview];
            }
            SHouseBuyHouseInfo * infor_sub = infor.data.comment_new.firstObject;
            NSMutableArray * label_arr = [[NSMutableArray alloc] init];
            for (SHouseBuyCommentList * list_sub in infor_sub.label_arr) {
                [label_arr addObject:list_sub.label];
            }
            CGSize size = [[NSString stringWithFormat:@"%@\n\n标签：%@",infor_sub.content,[label_arr componentsJoinedByString:@"、"]] boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            if (infor_sub.pictures_arr.count == 0) {
                downNew.frame = CGRectMake(0, 0, ScreenW, 85 + size.height + 10);
            } else {
                downNew.frame = CGRectMake(0, 0, ScreenW, 85 + size.height + 10 + 90);

                SOnlineShop_ClassInfoList_more_footerCont * con = [[SOnlineShop_ClassInfoList_more_footerCont alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 60)];
                [downNew.evaImageView addSubview:con];
                [con showModel:infor_sub.pictures_arr andPriceShow:NO andType:@"SHouseBuyHouseInfo"];
            }
            [downNew.head_pic sd_setImageWithURL:[NSURL URLWithString:infor_sub.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            downNew.nickname.text = infor_sub.nickname;
            downNew.thisContent.text = infor_sub.content;
            [downNew.scroll_evaMoreBtn setTitle:[NSString stringWithFormat:@"更多评价(%@)",infor.data.comment_num] forState:UIControlStateNormal];
            [downNew.scroll_evaMoreBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            contentArr = infor.data.house_attr;
            [_mFirstTable reloadData];
            
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
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
    
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    nav = [[SGoodsInfor_nav alloc] initWithFrame:CGRectMake(0, 0, 210, 44)];
    self.navigationItem.titleView = nav;
    nav.twoBtn_WWW.constant = 70;
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    
    //楼盘
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.oneBtn setTitle:@"楼盘" forState:UIControlStateNormal];
    [nav.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //户型
    [nav.twoBtn setTitle:@"户型" forState:UIControlStateNormal];
    [nav.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //点评
    [nav.threeBtn setTitle:@"点评" forState:UIControlStateNormal];
    [nav.threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 楼盘
- (void)oneBtnClick {
    [self scrollViewDidScroll:_mFirstTable];
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    _mCollect.hidden = YES;
    _mTable.hidden = YES;
}
#pragma mark - 户型
- (void)twoBtnClick {
    _moveTopBtn.hidden = YES;
    [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    nav.oneLine.hidden = YES;
    nav.twoLine.hidden = NO;
    nav.threeLine.hidden = YES;
    _mCollect.hidden = NO;
    _mTable.hidden = YES;
    
    page = 1;
    [self initRefresh];
    [self showModel];
}

- (void)initRefresh
{
    __block SHouseInfor * blockSelf = self;
    _mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    _mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    page = 1;
    [self showModel];
}
- (void)showModel {
    SHouseBuyHouseStyleList * list = [[SHouseBuyHouseStyleList alloc] init];
    list.house_id = _house_id;
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sHouseBuyHouseStyleListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SHouseBuyHouseStyleList * list = (SHouseBuyHouseStyleList *)data;
        
        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:list.data];
            [_mCollect.mj_footer resetNoMoreData];
        } else {
            if (list.data.count) {
                
                [arr addObjectsFromArray:list.data];
                [_mCollect.mj_footer endRefreshing];
                
            } else {
                
                [_mCollect.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        [_mCollect.mj_header endRefreshing];
        [_mCollect reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma mark - 点评
- (void)threeBtnClick {
    _moveTopBtn.hidden = YES;
    [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    nav.oneLine.hidden = YES;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = NO;
    _mCollect.hidden = YES;
    _mTable.hidden = NO;
    
    page = 1;
    model_label_id = @"";
    [self initRefresh_three];
    [self showModel_three];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createUI {
    
    XRWaterfallLayout * waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    [waterfall setColumnSpacing:5 rowSpacing:5 sectionInset:UIEdgeInsetsMake(0, 0, 5, 0)];
    waterfall.delegate = self;
    _mCollect.collectionViewLayout = waterfall;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    //Cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell_house" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell_house"];
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mCollect.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mCollect addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    [_mFirstTable registerNib:[UINib nibWithNibName:@"SHouseInfor_firstCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHouseInfor_firstCell"];
    _mFirstTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    topNew = [[SHouseInfor_topNew alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW + 130)];
    _mFirstTable.tableHeaderView = topNew;
    downNew = [[SHouseInfor_downNew alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 120)];
    _mFirstTable.tableFooterView = downNew;
    [topNew.thisAddBtn addTarget:self action:@selector(thisAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_mTable registerNib:[UINib nibWithNibName:@"SEvaAllCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SEvaAllCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    top = [[SHouseInfor_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 300)];
    _mTable.tableHeaderView = top;
    top.SHouseInfor_top_choice = ^(NSString *label_id) {
        model_label_id = label_id;
        page = 1;
        [self showModel_three];
    };
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return arr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    return ScreenW/2 - 2.5 + 40 + 70 + 30 + 40 + 15 + 20;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShopCell_house *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell_house" forIndexPath:indexPath];
    
    SHouseBuyHouseStyleList * list = arr[indexPath.row];
    [mCell.house_style_img sd_setImageWithURL:[NSURL URLWithString:list.house_style_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    mCell.style_name.text = list.style_name;
    mCell.developer.text = list.developer;
    mCell.pre_money.text = [NSString stringWithFormat:@"￥%@",list.pre_money];
    mCell.one_price.text = [NSString stringWithFormat:@"%@元/平",list.one_price];
    mCell.true_pre_money.text = [NSString stringWithFormat:@"可抵￥%@房款",list.true_pre_money];
    mCell.integral.text = list.integral;
    mCell.all_price.text = [NSString stringWithFormat:@"房全价￥%@",list.all_price];
    [mCell.red_pro setProgress:[list.sell_num floatValue]/[list.total floatValue]];
    if ([list.ticket_discount integerValue] == 0) {
        mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
        mCell.top_oneTitle.text = @"不可使用代金券";
    } else {
        mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
        mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_discount];
    }
    if ([list.country_id isEqualToString:@"0"]) {
        mCell.country_logo.hidden = YES;
    } else {
        mCell.country_logo.hidden = NO;
    }
    [mCell.country_logo sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SHouseBuyHouseStyleList * list = arr[indexPath.row];

    SHouseInfor_subInfor * subInfor = [[SHouseInfor_subInfor alloc] init];
    subInfor.style_id = list.style_id;
    [self.navigationController pushViewController:subInfor animated:YES];
}


- (void)initRefresh_three
{
    __block SHouseInfor * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel_three];
        
    }];
    _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel_three];
    }];
}
- (void)showModel_three {
    SHouseBuyCommentList * list = [[SHouseBuyCommentList alloc] init];
    list.house_id = _house_id;
    list.label_id = model_label_id;
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sHouseBuyCommentListSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SHouseBuyCommentList * list = (SHouseBuyCommentList *)data;
        if (page == 1) {
            threeArr = [NSMutableArray arrayWithArray:list.data.comment_list];
            [_mTable.mj_footer resetNoMoreData];
        } else {
            if (list.data.comment_list.count) {
                
                [threeArr addObjectsFromArray:list.data.comment_list];
                [_mTable.mj_footer endRefreshing];
                
            } else {
                
                [_mTable.mj_footer endRefreshingWithNoMoreData];
            }
        }
        for (int i = 0; i < [list.data.composite integerValue]; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 12, 15, 15)];
            [top.starView addSubview:imageView];
            
            imageView.image = [UIImage imageNamed:@"星星黄"];
        }
        top.starView_num.text = [NSString stringWithFormat:@"%zd",[list.data.composite integerValue]];
        top.num_label.text = [NSString stringWithFormat:@"价格%@分 地段%@分 配套%@分 交通%@分 环境%@",list.data.price,list.data.lot,list.data.supporting,list.data.traffic,list.data.environment];
        [top showModel:list.data.label_list andNow:model_label_id andType:@"SHouseBuyCommentList"];
        
        dispatch_async(dispatch_get_main_queue(),^{
            top.mCollect_HHH.constant = top.mCollect.contentSize.height;
            top.frame = CGRectMake(0, 0, ScreenW, 80 + top.mCollect.contentSize.height);
            _mTable.tableHeaderView = top;

        });
        
        [_mTable.mj_header endRefreshing];
        [_mTable reloadData];


    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _mFirstTable) {
        return 1;
    }
    return threeArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _mFirstTable) {
        return contentArr.count;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _mFirstTable) {
        return 0.01;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _mFirstTable) {
        return 40;
    }
    
    SHouseBuyCommentList * list = threeArr[indexPath.section];
    
    NSInteger content_num;
    NSInteger thisContent_num;
    
    NSMutableArray * label_arr = [[NSMutableArray alloc] init];
    for (SHouseBuyCommentList * list_sub in list.label_arr) {
        [label_arr addObject:list_sub.label];
    }
    CGSize size = [[NSString stringWithFormat:@"%@\n\n标签：%@",list.content,[label_arr componentsJoinedByString:@"、"]] boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    content_num = size.height + 10;
    
    if (list.pictures_arr.count == 0) {
        thisContent_num = 0;
    } else {
        thisContent_num = 70;
    }
//    NSLog(@"%zd %zd %zd",indexPath.section,content_num,thisContent_num);
    return 55 + content_num + thisContent_num + 10 + 35;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _mFirstTable) {
        SHouseInfor_firstCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SHouseInfor_firstCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        SHouseBuyHouseInfo * list = contentArr[indexPath.row];
        cell.key.text = [NSString stringWithFormat:@"%@:",list.key];
        cell.value.text = list.value;
        
        return cell;
    }
    SEvaAllCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SEvaAllCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SHouseBuyCommentList * list = threeArr[indexPath.section];
    [cell.head_pic sd_setImageWithURL:[NSURL URLWithString:list.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.nickname.text = list.nickname;
    
    NSMutableArray * label_arr = [[NSMutableArray alloc] init];
    for (SHouseBuyCommentList * list_sub in list.label_arr) {
        [label_arr addObject:list_sub.label];
    }
    cell.content.text = [NSString stringWithFormat:@"%@\n\n标签：%@",list.content,[label_arr componentsJoinedByString:@"、"]];
    cell.create_time.text = list.create_time;
    [cell showModel:list.pictures_arr andType:@"SHouseBuyCommentList"];
    
    CGSize size = [[NSString stringWithFormat:@"%@\n\n标签：%@",list.content,[label_arr componentsJoinedByString:@"、"]] boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    cell.content_HHH.constant = size.height + 10;
    
    if (list.pictures_arr.count == 0) {
        cell.thisContent.hidden = YES;
        cell.thisContent_TopHHH.constant = 0;
        cell.thisContent_HHH.constant = 0;
    } else {
        cell.thisContent.hidden = NO;
        cell.thisContent_TopHHH.constant = 10;
        cell.thisContent_HHH.constant = 60;
    }
    for (UIView * view in cell.starView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < [list.comment_star integerValue]; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
        [cell.starView addSubview:imageView];
        
        imageView.image = [UIImage imageNamed:@"星星黄"];
    }
    return cell;
}
#pragma mark - 打电话
- (void)callBtnClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_link_phone.text]]];
}
#pragma mark - 地图
- (void)thisAddBtnClick {
    SHouse_Map * map = [[SHouse_Map alloc] init];
    map.model_lng = model_lng;
    map.model_lat = model_lat;
    map.model_houseName = model_houseName;
    [self.navigationController pushViewController:map animated:YES];
}
- (IBAction)moveTopBtn:(UIButton *)sender {
    [_mFirstTable setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > ScreenW) {
        _moveTopBtn.hidden = NO;
    } else {
        _moveTopBtn.hidden = YES;
    }
}
@end

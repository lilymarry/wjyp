//
//  SOnlineShop_ClassInfoList_more.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/13.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShop_ClassInfoList_more.h"
#import "SOnlineShop_seachView.h"
#import "SOnlineShop_ClassInfoList_moreCell_left.h"
#import "SOnlineShop_ClassInfoList_moreCell_right.h"
#import "SOnlineShop_ClassInfoList_more_header.h"
#import "SOnlineShop_ClassInfoList_more_footer.h"
#import "SSearch.h"
#import "SSearch_content.h"
#import "SMessage.h"
#import "SOnlineShop_ClassInfoList_more_footerCont.h"

#import "SGoodsCategoryCateIndex.h"
#import "SOnlineShop_ClassInfoList_sub.h"
#import "SIndexIndex.h"

@interface SOnlineShop_ClassInfoList_more () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,EMChatManagerDelegate>
{
    SOnlineShop_seachView * searchView;
    NSString * cate_id;//顶级分类id
    NSArray * arr;
    NSArray * brr;
    UILabel * mess_count;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;

/*
 *添加判断是否允许keyWindow添加mess_count的状态属性
 */
@property (nonatomic, assign) BOOL isAddMess_count;

@end

@implementation SOnlineShop_ClassInfoList_more

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
    
/*
 *修改挑战到分类界面后,滚动到响应的分类
 *分类中的二级分类,滚动到屏幕中间显示
 *在.h文件中,添加两个属性:Top_Cate_ID顶级分类ID和Cate_ID二级分类ID
 */
    if (_Top_Cate_ID == nil) {
        _Top_Cate_ID = @"";
    }
//    cate_id = @"";
    cate_id = _Top_Cate_ID;
    SGoodsCategoryCateIndex * index = [[SGoodsCategoryCateIndex alloc] init];
//    index.cate_id = @"";
    index.cate_id = _Top_Cate_ID;
    
    [index sGoodsCategoryCateIndexSuccess:^(NSString *code, NSString *message, id data) {
        SGoodsCategoryCateIndex * list = (SGoodsCategoryCateIndex *)data;
        arr = list.data.top_cate;
        
        [_mTable reloadData];
        
        if ([_Top_Cate_ID isEqualToString:@""]) {//此处判断,是为了防止顶级分类属性Top_Cate_ID在没有赋值时,创建的indexPath不正常问题
            _Top_Cate_ID = @"1";
        }
        [_mTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_Top_Cate_ID.integerValue - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        SGoodsCategoryCateIndex * TopCateIndex = arr[_Top_Cate_ID.integerValue - 1];
        TopCateIndex.top_cate_isno = YES;
        
        brr = list.data.two_cate;
        
        NSUInteger index = 0;
        for (SGoodsCategoryCateIndex * CateIndex in brr) {
            if ([CateIndex.cate_id isEqualToString:_Cate_ID]) {
                index = [brr indexOfObject:CateIndex];
                break;
            }
        }
        [_mCollect reloadData];
        [_mCollect scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)showModel {
    SGoodsCategoryCateIndex * index = [[SGoodsCategoryCateIndex alloc] init];
    index.cate_id = cate_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [index sGoodsCategoryCateIndexSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SGoodsCategoryCateIndex * list = (SGoodsCategoryCateIndex *)data;
        brr = list.data.two_cate;
        [_mCollect reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     *当当前控制器的视图将要显示的时候,允许keyWindow添加mess_count
     */
    _isAddMess_count = YES;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    adjustsScrollViewInsets_NO(_mCollect, self);
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色
    
    //获取当前未读消息数
    SIndexIndex * list = [[SIndexIndex alloc] init];
    list.lng = @"";
    list.lat = @"";
    [list sIndexIndexSuccess:^(NSString *code, NSString *message, id data) {
        
        [[EMClient sharedClient].chatManager getConversation:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account type:EMConversationTypeChat createIfNotExist:YES];
        [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
        
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSInteger totalUnreadCount = 0;
        for (EMConversation *conversation in conversations) {
            totalUnreadCount += conversation.unreadMessagesCount;
        }
        [mess_count removeFromSuperview];
        
        SIndexIndex * list = (SIndexIndex *)data;
        
        /*//旧代码
        if ([list.data.msg_tip integerValue] != 0 || totalUnreadCount != 0) {
            if (ScreenW > 375) {
                mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 45, STATUS_BAR_HEIGHT, 15, 15)];
            } else {
                mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 35, STATUS_BAR_HEIGHT, 15, 15)];
            }

            mess_count.text = [NSString stringWithFormat:@"%ld",[list.data.msg_tip integerValue] + totalUnreadCount];
            mess_count.font = [UIFont systemFontOfSize:10];
            mess_count.textColor = [UIColor whiteColor];
            mess_count.backgroundColor = [UIColor orangeColor];
            mess_count.textAlignment = NSTextAlignmentCenter;
            mess_count.layer.masksToBounds = YES;
            mess_count.layer.cornerRadius = 7.5;
            [[[UIApplication sharedApplication] keyWindow] addSubview:mess_count];
        }
        */
        
        /*
         *根据"_isAddMess_count"的状态,来判断是否允许keyWindow添加mess_count
         */
        if (_isAddMess_count) {
            if ([list.data.msg_tip integerValue] != 0 || totalUnreadCount != 0) {
                if (ScreenW > 375) {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 45, STATUS_BAR_HEIGHT, 15, 15)];
                } else {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 35, STATUS_BAR_HEIGHT, 15, 15)];
                }
                
                mess_count.text = [NSString stringWithFormat:@"%ld",[list.data.msg_tip integerValue] + totalUnreadCount];
                mess_count.font = [UIFont systemFontOfSize:10];
                mess_count.textColor = [UIColor whiteColor];
                mess_count.backgroundColor = [UIColor orangeColor];
                mess_count.textAlignment = NSTextAlignmentCenter;
                mess_count.layer.masksToBounds = YES;
                mess_count.layer.cornerRadius = 7.5;
                [[[UIApplication sharedApplication] keyWindow] addSubview:mess_count];
            }
        }
        
    } andFailure:^(NSError *error) {
    }];
}
- (void)messagesDidReceive:(NSArray *)aMessages {
    if ([NSStringFromClass([self.navigationController.viewControllers.lastObject class]) isEqualToString:@"SOnlineShop_ClassInfoList_more"]) {
        [self viewDidAppear:YES];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    /*
     *当当前控制器的视图将要"不显示"的时候,不允许keyWindow添加mess_count
     */
    _isAddMess_count = NO;
    
    [self.navigationController.navigationBar lt_reset];
    [mess_count removeFromSuperview];
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
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(-3, 13, 10, 0);
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake( 0,-15,-23, 0);
    
    [rightBtn setImage:[UIImage imageNamed:@"消息黑色"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"消息" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem];
    
    searchView = [[SOnlineShop_seachView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 3;
    self.navigationItem.titleView = searchView;
    searchView.groundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    searchView.searchTitle.textColor = WordColor;
    searchView.thisImage.image = [UIImage imageNamed:@"黑色放大镜"];
    [searchView.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark - 搜索
- (void)searchBtnClick{
    SSearch * search = [[SSearch alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 消息
- (void)rightBtnClick {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
            [self showModel];
        };
        return;
    }
    SMessage * mess = [[SMessage alloc] init];
    [self.navigationController pushViewController:mess animated:YES];
}
- (void)createUI {
    [_mTable registerNib:[UINib nibWithNibName:@"SOnlineShop_ClassInfoList_moreCell_left" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOnlineShop_ClassInfoList_moreCell_left"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mTable.showsVerticalScrollIndicator = NO;
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
    _mCollect.collectionViewLayout = mFlowLayout;
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShop_ClassInfoList_moreCell_right" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShop_ClassInfoList_moreCell_right"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShop_ClassInfoList_more_header" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SOnlineShop_ClassInfoList_more_header"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShop_ClassInfoList_more_footer" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SOnlineShop_ClassInfoList_more_footer"];
    
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
    SOnlineShop_ClassInfoList_moreCell_left * cell = [tableView dequeueReusableCellWithIdentifier:@"SOnlineShop_ClassInfoList_moreCell_left" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    SGoodsCategoryCateIndex * list = arr[indexPath.row];
    cell.thisTitle.text = list.short_name;
    if ([cate_id isEqualToString:@""]) {
        if (indexPath.row == 0) {
            cell.line.hidden = NO;
            cell.thisTitle.backgroundColor = [UIColor whiteColor];
        } else {
            cell.line.hidden = YES;
            cell.thisTitle.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
    } else {
        if (list.top_cate_isno == YES) {
            cell.line.hidden = NO;
            cell.thisTitle.backgroundColor = [UIColor whiteColor];
        } else {
            cell.line.hidden = YES;
            cell.thisTitle.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SGoodsCategoryCateIndex * list = arr[indexPath.row];
    for (SGoodsCategoryCateIndex * list in arr) {
        list.top_cate_isno = NO;
    }
    cate_id = list.cate_id;
    list.top_cate_isno = YES;
    [_mTable reloadData];
    [self showModel];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    SGoodsCategoryCateIndex * list = brr[section];
    return list.three_cate.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return brr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenW - 90)/3, (ScreenW - 90)/3 + 30);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SOnlineShop_ClassInfoList_more_header * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SOnlineShop_ClassInfoList_more_header" forIndexPath:indexPath];
//        [header.moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        SGoodsCategoryCateIndex * list = brr[indexPath.section];
        header.thisTitle.text = [NSString stringWithFormat:@"  %@",list.short_name];
        
        reusableview = header;
        
    }// header;
    if (kind == UICollectionElementKindSectionFooter) {
        SOnlineShop_ClassInfoList_more_footer * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SOnlineShop_ClassInfoList_more_footer" forIndexPath:indexPath];
        
        SOnlineShop_ClassInfoList_more_footerCont * con = [[SOnlineShop_ClassInfoList_more_footerCont alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 70 - 30, 60)];
        [footer.thisContent addSubview:con];
        
        SGoodsCategoryCateIndex * list = brr[indexPath.section];
        [con showModel:list.host_brand andPriceShow:NO andType:@"SGoodsCategoryCateIndex"];
        
//        con.SOnlineShop_ClassInfoList_more_footerCont_select = ^{
//
//        };

        reusableview = footer;
    }
    return reusableview;
}
#pragma mark - 查看更多
- (void)moreBtnClick {
    SSearch_content * search_con = [[SSearch_content alloc] init];
    search_con.mySearch = @"查看更多";
    [self.navigationController pushViewController:search_con animated:YES];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {ScreenW - 90,50};
    return size;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    SGoodsCategoryCateIndex * list = brr[section];
    if (list.host_brand.count == 0) {
        CGSize size = {0.01,0.01};
        return size;
    }
    
    CGSize size = {ScreenW - 90,120};
    return size;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShop_ClassInfoList_moreCell_right * cell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShop_ClassInfoList_moreCell_right" forIndexPath:indexPath];
    
    SGoodsCategoryCateIndex * list = brr[indexPath.section];
    SGoodsCategoryCateIndex * list_sub = list.three_cate[indexPath.row];
    [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list_sub.cate_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.thisTitle.text = list_sub.short_name;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SGoodsCategoryCateIndex * list = brr[indexPath.section];

    SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
    class_sub.cate_type = @"7";
    class_sub.two_cate_id = list.cate_id;
    class_sub.short_name = list.short_name;
    class_sub.class_num = indexPath.row + 1;
    [self.navigationController pushViewController:class_sub animated:YES];
    
}
@end

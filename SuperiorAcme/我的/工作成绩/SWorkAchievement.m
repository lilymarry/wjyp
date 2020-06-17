//
//  SWorkAchievement.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//
#define NAVBAR_CHANGE_POINT 50
#import "SWorkAchievement.h"
#import "SWorkAchievementCell.h"
#import "SWorkAchievement_top.h"
#import "SWorkAchievement_header.h"
#import "SShareNum.h"
#import "SRecommend.h"
#import "SNowRegion.h"

#import "SUserGradeRank.h"
#import "CQPlaceholderView.h"

@interface SWorkAchievement () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    UIView * red_line;
    SWorkAchievement_header * header;
    BOOL type;//NO分享榜 YES推荐榜
    
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView *placeholderView;
    NSString * model_type;//type = 'share' 显示分享排行（默认） type = 'recommend' 显示推荐排行
    NSString * city_name;//城市名称
    
    SWorkAchievement_top * top;
    
    NSString * infinite;//是否有权限无线点击查看
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

/*
 *添加"分享榜"和"推荐榜"的page属性,和临时数据存储数组
 */
@property (nonatomic, assign) NSInteger sharePage; //当前"分享榜"网络请求page
@property (nonatomic, assign) NSInteger sharePreviousPage; //点击"分享榜按钮"时,记录上一次"分享榜"的page
@property (nonatomic, strong) NSMutableArray * shareMutArr; //"分享榜"的临时数据存储数组
@property (nonatomic, assign) NSInteger recommendPage; //当前"推荐榜"网络请求page
@property (nonatomic, assign) NSInteger recommendPreviousPage; //点击"推荐榜按钮"时,记录上一次"推荐榜"的page
@property (nonatomic, strong) NSMutableArray * recommendMutArr; //"推荐榜"的临时数据存储数组

@end

@implementation SWorkAchievement

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SWorkAchievementCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SWorkAchievementCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 + 15, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    top = [[SWorkAchievement_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242 * 840 + 20)];
    _mTable.tableHeaderView = top;
    //分享次数
    [top.topOneBtn addTarget:self action:@selector(topOneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //成功推荐
    [top.topTwoBtn addTarget:self action:@selector(topTwoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    model_type = @"share";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"] == nil) {
        city_name = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"];
    } else {
        city_name = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"];
    }
    
    //    page = 1;//旧代码
    
    /*
     *一次性初始化page,分享榜page,推荐榜page
     */
    page = _sharePage = _recommendPage = 1;
    
    [self initRefresh];
    [self showModel];
}
#pragma mark - 分享次数
- (void)topOneBtnClick {
    SShareNum * num = [[SShareNum alloc] init];
    [self.navigationController pushViewController:num animated:YES];
}
#pragma mark - 成功推荐
- (void)topTwoBtnClick {
    SRecommend * recom = [[SRecommend alloc] init];
    [self.navigationController pushViewController:recom animated:YES];
}
#pragma mark - 当前地区
- (void)addressBtnClick {
    SNowRegion * region = [[SNowRegion alloc] init];
    [self.navigationController pushViewController:region animated:YES];
    region.SNowRegion_choice = ^{
        city_name = [[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"];
        page = 1;
        [self showModel];
    };
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白
    [self scrollViewDidScroll:_mTable];
    
    self.title = @"分享成绩";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)initRefresh
{
    __block SWorkAchievement * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
//        page++; //旧代码
        
        /*
         *上划请求更多数据时,判断当前是处于"分享榜",还是处于"推荐榜",并分别计算"分享榜"和"推荐榜"网络请求的page
         */
        if ([model_type isEqualToString:@"share"]) {
            _sharePage++;
        }else if ([model_type isEqualToString:@"recommend"]){
            _recommendPage++;
        }
        
        [blockSelf showModel];
    }];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)showModel {
    SUserGradeRank * list = [[SUserGradeRank alloc] init];
    /*
     *在模拟器中无法获取有效的位置信息,防止崩溃
     */
    if (city_name == nil) {
        city_name = @"";
    }
    list.city_name = city_name;
    list.type = model_type;
    
    /*
     *根据当前的model_type,分别请求相应的model_type对应的数据
     */
    if ([model_type isEqualToString:@"share"]) {
        page = _sharePage;
    }else if ([model_type isEqualToString:@"recommend"]){
        page = _recommendPage;;
    }
    
    
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sUserGradeRankSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SUserGradeRank * list = (SUserGradeRank *)data;
        [top.thisImage sd_setImageWithURL:[NSURL URLWithString:list.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        top.nickname.text = list.data.nickname;
        top.share_num.text = [NSString stringWithFormat:@"%@/%@",list.data.share_num,list.data.share_rank];
        top.recommend_num.text =[NSString stringWithFormat:@"%@/%@",list.data.recommend_num,list.data.recommend_rank] ;
        top.parent_name.text = [NSString stringWithFormat:@"推荐人:%@",list.data.parent_name];
        /*
         *保存请求到的是否有权限查看值
         */
        infinite = list.data.infinite;
        
        if (page == 1) {
            
            
            /*
             *请求到第一页数据后,根据model_type判断是"分享榜"还是"推荐榜",并分别存储数据
             *注意arr的赋值不能直接用 = ,因为都是可变的数组,一旦arr移除所有的数据后,响应的shareMutArr或者recommendMutArr对应的数据也会被移除,不能用copy,copy出的是不可变数组,会崩溃;用mutableCopy复制出的数组可以正常运行
             */
            if ([model_type isEqualToString:@"share"]) {
                [arr removeAllObjects];
                self.shareMutArr = [NSMutableArray arrayWithArray:list.data.rank_list];
                arr = [self.shareMutArr mutableCopy];
            }else if ([model_type isEqualToString:@"recommend"]){
                [arr removeAllObjects];
                self.recommendMutArr = [NSMutableArray arrayWithArray:list.data.rank_list];
                arr = [self.recommendMutArr mutableCopy];
            }
            
//            arr = [NSMutableArray arrayWithArray:list.data.rank_list]; //旧代码
            [_mTable.mj_footer resetNoMoreData];
        } else {
            if (list.data.rank_list.count) {
                
                
                /*
                 *根据model_type分别将 page>=2 以后的数据,追加到相应的model_type数组内
                 *注意arr的赋值不能直接用 = ,因为都是可变的数组,一旦arr移除所有的数据后,响应的shareMutArr或者recommendMutArr对应的数据也会被移除,不能用copy,copy出的是不可变数组,会崩溃;用mutableCopy复制出的数组可以正常运行
                 */
                if ([model_type isEqualToString:@"share"]) {
                    if (_sharePage != _sharePreviousPage) {
                        [self.shareMutArr addObjectsFromArray:list.data.rank_list];
                    }
                    arr = [self.shareMutArr mutableCopy];
                }else if ([model_type isEqualToString:@"recommend"]){
                    if (_recommendPage != _recommendPreviousPage) {
                        [self.recommendMutArr addObjectsFromArray:list.data.rank_list];
                    }
                    arr = [self.recommendMutArr mutableCopy];
                }
                

//                [arr addObjectsFromArray:list.data.rank_list];//旧代码

                [_mTable.mj_footer endRefreshing];
                
            } else {
                
                [_mTable.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [_mTable.mj_header endRefreshing];
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor redColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        //        home_search.thisSeaViewrch.backgroundColor = [UIColor whiteColor];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        //        home_search.thisSearchView.backgroundColor = [UIColor colorWithRed:239/255.0 green:244/255.0 blue:244/255.0 alpha:0.5];
    }
    
    //获取tableView当前的y偏移
    CGFloat contentOffsety  = scrollView.contentOffset.y;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
        _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>= 200-64){
        _mTable.contentInset  = UIEdgeInsetsMake(-225, 0, 0, 0);
    }
}

- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 90;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        header = [[SWorkAchievement_header alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 90)];
        if (type == NO) {
            red_line = [[UIView alloc] initWithFrame:CGRectMake(ScreenW/2 - 120, 38, 100, 2)];
            //默认分享榜
            [header.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        } else {
            red_line = [[UIView alloc] initWithFrame:CGRectMake(ScreenW/2 + 20, 38, 100, 2)];
            //默认推荐榜
            [header.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        [header.classView addSubview:red_line];
        red_line.backgroundColor = [UIColor redColor];
        
        
        //分享榜
        [header.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //推荐榜
        [header.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //当前地区
        [header.addressBtn addTarget:self action:@selector(addressBtnClick) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"1.%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"]);
        NSLog(@"2.%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"]);
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"] == nil) {
            [header.addressBtn setTitle:[NSString stringWithFormat:@" %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"]] forState:UIControlStateNormal];
        } else {
            [header.addressBtn setTitle:[NSString stringWithFormat:@" %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"]] forState:UIControlStateNormal];

        }
        
        return header;
    }
    return nil;
}
#pragma mark - 分享榜
- (void)oneBtnClick {
    type = NO;
    model_type = @"share";
    /*
     *点击分享榜按钮后,记录当前已经发起过网络请求的sharePage
     */
    _sharePreviousPage = _sharePage;
    
    [self showModel];
}
#pragma mark - 推荐榜
- (void)twoBtnClick {
    type = YES;
    model_type = @"recommend";
    /*
     *点击分享榜按钮后,记录当前已经发起过网络请求的recommendPage
     */
    _recommendPreviousPage = _recommendPage;
    
    [self showModel];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWorkAchievementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWorkAchievementCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.row == 0) {
        cell.thisR.hidden = NO;
        cell.thisR.image = [UIImage imageNamed:@"奖牌R"];
        cell.thisR_othre.hidden = YES;
        cell.othre_num.hidden = YES;
    } else if (indexPath.row == 1) {
        cell.thisR.hidden = NO;
        cell.thisR.image = [UIImage imageNamed:@"奖牌R2"];
        cell.thisR_othre.hidden = YES;
        cell.othre_num.hidden = YES;
    } else if (indexPath.row == 2) {
        cell.thisR.hidden = NO;
        cell.thisR.image = [UIImage imageNamed:@"奖牌R3"];
        cell.thisR_othre.hidden = YES;
        cell.othre_num.hidden = YES;
    } else {
        cell.thisR.hidden = YES;
        cell.thisR_othre.hidden = NO;
        cell.othre_num.hidden = NO;
        cell.othre_num.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
    }
    
    SUserGradeRank * list = arr[indexPath.row];
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.nickname.text = list.nickname;
    if (type == NO) {
        
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"分享 %@ 次",list.num]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, list.num.length)];
        cell.num.attributedText = AttributedStr;
    } else {
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"推荐 %@ 人",list.num]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, list.num.length)];
        cell.num.attributedText = AttributedStr;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (type == YES) {
        SUserGradeRank * list = arr[indexPath.row];
        SRecommend * recom = [[SRecommend alloc] init];
        recom.name = list.nickname;
        recom.parent_id = list.parent_id;
        recom.type = YES;
        /*
         *传递是否有权限无限查看值
         */
        recom.infinite = infinite;
        [self.navigationController pushViewController:recom animated:YES];
    }
}

/*
 *"分享榜"和"推荐榜"数据存储数组
 */
#pragma mark - 懒加载
-(NSMutableArray *)shareMutArr{
    if (!_shareMutArr) {
        _shareMutArr = [NSMutableArray array];
    }
    return _shareMutArr;
}

-(NSMutableArray *)recommendMutArr{
    if (!_recommendMutArr) {
        _recommendMutArr = [NSMutableArray array];
    }
    return _recommendMutArr;
}
@end

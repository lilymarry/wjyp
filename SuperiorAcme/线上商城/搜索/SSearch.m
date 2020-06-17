//
//  SSearch.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SSearch.h"
#import "SSearch_nav.h"
#import "CommodityMerchant.h"
#import "SSearchCell.h"
#import "SSearch_content.h"
#import "UBSearchController.h"

#define underlineDataKey @"SearchType_underline"

@interface SSearch ()
{
    SSearch_nav * search;
    CommodityMerchant * cm;
    NSMutableArray * keywords_arr;//历史数据
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UIButton *clearBtn;

//没有数据时候需要隐藏
@property (weak, nonatomic) IBOutlet UIView *historySearchHeadView;

@end

@implementation SSearch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    cm.hidden = YES;
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
//    lefthBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);

    [rightBtn setImage:[UIImage imageNamed:@"红色搜索"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem];
    
    UIView *navigationBarView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, ScreenW - NavigationBarTitleViewMargin * 2, 44)];
    self.navigationItem.titleView = navigationBarView;
    
    search = [[SSearch_nav alloc] initWithFrame:CGRectMake(0, 7, ScreenW, 30)];
    search.layer.masksToBounds = YES;
    search.layer.cornerRadius = 3;
    self.navigationItem.titleView = search;
    [search.choiceTypeBtn addTarget:self action:@selector(choiceTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [search.choiceTypeBtn setTag:0];
    
    switch (_searchType) {
        case SearchType_online:
        {
        }
            break;
        case SearchType_underline:
        {
            search.isHiddenBtnImgV = YES;
        }
            break;
            
        default:
            break;
    }
    
    
    //商品、商家 操作
    cm = [[CommodityMerchant alloc] initWithFrame:CGRectMake(70, 60, 80, 80)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:cm];
    cm.hidden = YES;
    [cm.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cm.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 清空历史搜搜
- (void)clearBtnClick {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认清除全部历史记录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        keywords_arr = [[NSMutableArray alloc] init];
        switch (_searchType) {
            case SearchType_online:
                {
                   [[NSUserDefaults standardUserDefaults] setObject:keywords_arr forKey:@"keywords_arr"];
                }
                break;
            case SearchType_underline:
            {
                [[NSUserDefaults standardUserDefaults] setObject:keywords_arr forKey:underlineDataKey];
            }
                break;
                
            default:
                break;
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_mCollect reloadData];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 商品、商家
- (void)choiceTypeBtnClick:(UIButton *)btn {
    cm.hidden = NO;
    if (btn.tag == 0) {
        [cm.oneBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [cm.twoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [cm.oneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cm.twoBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
}
#pragma mark - 选择商品
- (void)oneBtnClick {
    [search.choiceTypeBtn setTitle:@"商品" forState:UIControlStateNormal];
    [search.choiceTypeBtn setTag:0];
    cm.hidden = YES;
}
#pragma mark - 选择商家
- (void)twoBtnClick {
    [search.choiceTypeBtn setTitle:@"商家" forState:UIControlStateNormal];
    [search.choiceTypeBtn setTag:1];
    cm.hidden = YES;
}
#pragma mark - 搜索
- (void)rightBtnClick {
    if ([search.searchTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入搜索内容" toView:self.view];
        return;
    }
    [search.searchTF resignFirstResponder];

    [keywords_arr removeObject:search.searchTF.text];
    [keywords_arr insertObject:search.searchTF.text atIndex:0];
    switch (_searchType) {
        case SearchType_online:
        {
            [[NSUserDefaults standardUserDefaults] setObject:keywords_arr forKey:@"keywords_arr"];
        }
            break;
        case SearchType_underline:
        {
            [[NSUserDefaults standardUserDefaults] setObject:keywords_arr forKey:underlineDataKey];
           
            [[NSUserDefaults standardUserDefaults] synchronize];
            [_mCollect reloadData];
            UBSearchController * searchVC = [[UBSearchController alloc] init];
            searchVC.keyWord = search.searchTF.text;
            [self.navigationController pushViewController:searchVC animated:YES];
            return;
        }
            break;
            
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_mCollect reloadData];
    SSearch_content * search_con = [[SSearch_content alloc] init];
    search_con.mySearch = search.searchTF.text;
    if (search.choiceTypeBtn.tag == 0) {
        search_con.type = NO;
    } else {
        search_con.type = YES;
    }
    [self.navigationController pushViewController:search_con animated:YES];
}
- (void)createUI {
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 10;//用于控制单元格之间最小 行间距
    mFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    mFlowLayout.itemSize = CGSizeMake((ScreenW - 40)/3, 40);//设置单元格的宽和高
    mFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//各分区上下左右空白区域大小
    
    [_mCollect setCollectionViewLayout:mFlowLayout];
    //隐藏滚轴
    _mCollect.showsVerticalScrollIndicator = NO;
    //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SSearchCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SSearchCell"];
    
    //历史数据
    keywords_arr = [[NSMutableArray alloc] init];
    
    switch (_searchType) {
        case SearchType_online:
        {
            [keywords_arr addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"keywords_arr"]];
        }
            break;
        case SearchType_underline:
        {
            [keywords_arr addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:underlineDataKey]];
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    _historySearchHeadView.hidden = !keywords_arr.count;
    
    return keywords_arr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SSearchCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SSearchCell" forIndexPath:indexPath];
    
    mCell.thisTitle.text = keywords_arr[indexPath.row];
    
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [search.searchTF resignFirstResponder];
    
    search.searchTF.text = keywords_arr[indexPath.row];
    //保存搜索内容-置换位置
    [keywords_arr removeObject:search.searchTF.text];
    [keywords_arr insertObject:search.searchTF.text atIndex:0];
    switch (_searchType) {
        case SearchType_online:
        {
            [[NSUserDefaults standardUserDefaults] setObject:keywords_arr forKey:@"keywords_arr"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [_mCollect reloadData];
            
            SSearch_content * search_con = [[SSearch_content alloc] init];
            search_con.mySearch = search.searchTF.text;
            if (search.choiceTypeBtn.tag == 0) {
                search_con.type = NO;
            } else {
                search_con.type = YES;
            }
            [self.navigationController pushViewController:search_con animated:YES];
        }
            break;
        case SearchType_underline:
        {
            [[NSUserDefaults standardUserDefaults] setObject:keywords_arr forKey:underlineDataKey];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            [_mCollect reloadData];
            
            UBSearchController * searchVC = [[UBSearchController alloc] init];
            searchVC.keyWord = search.searchTF.text;
            [self.navigationController pushViewController:searchVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
@end

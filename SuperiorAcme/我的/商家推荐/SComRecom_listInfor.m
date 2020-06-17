//
//  SComRecom_listInfor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SComRecom_listInfor.h"
#import "SComRecom_listInforCell.h"
#import "SComRecom_listInfor_Top.h"

#import "SUserReferInfo.h"
#import "SOnlineShop_ClassInfoList_more_header.h"

@interface SComRecom_listInfor () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray * arr;
    NSMutableArray * brr;
    NSMutableArray * crr;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SComRecom_listInfor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    //Cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SComRecom_listInforCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SComRecom_listInforCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShop_ClassInfoList_more_header" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SOnlineShop_ClassInfoList_more_header"];
    _mCollect.backgroundColor = [UIColor whiteColor];

    SComRecom_listInfor_Top * top = [[SComRecom_listInfor_Top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 650)];
    [_mCollect addSubview:top];
    
    SUserReferInfo * infor = [[SUserReferInfo alloc] init];
    infor.refer_id = _refer_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [infor sUserReferInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SUserReferInfo * infor = (SUserReferInfo *)data;
            [top.logo sd_setImageWithURL:[NSURL URLWithString:infor.data.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            top.name.text = infor.data.name;
            top.desc.text = infor.data.desc;
            top.score.text = [NSString stringWithFormat:@"评分%@分",infor.data.score];

            /*
             * 0 待客服审核
               1 待招商审核
               2 客服审核未通过  refuse_desc 客服拒绝理由
               3 招商审核未通过  is_desc  招商人员拒绝理由
               4 待入驻
               5 入驻审核未通过  is_kaihu 客服拒绝理由
               6 入驻成功
               7 入驻待审核
             */
            if ([infor.data.status isEqualToString:@"0"]) {
                top.status.text = @"待客服审核";
            }
            if ([infor.data.status isEqualToString:@"1"]) {
                top.status.text = @"待招商审核";
            }
            if ([infor.data.status isEqualToString:@"2"]) {
                top.status.text = [NSString stringWithFormat:@"客服审核未通过(%@)",infor.data.refuse_desc];
            }
            if ([infor.data.status isEqualToString:@"3"]) {
                top.status.text = [NSString stringWithFormat:@"招商审核未通过(%@)",infor.data.is_desc];
            }
            if ([infor.data.status isEqualToString:@"4"]) {
                top.status.text = @"待入驻";
            }
            if ([infor.data.status isEqualToString:@"5"]) {
                top.status.text = [NSString stringWithFormat:@"入驻审核未通过(%@)",infor.data.is_kaihu];
            }
            if ([infor.data.status isEqualToString:@"6"]) {
                top.status.text = @"入驻成功";
            }
            if ([infor.data.status isEqualToString:@"7"]) {
                top.status.text = @"入驻待审核";
            }
            top.range_id.text = infor.data.range_id;
            top.link_man.text = infor.data.link_man;
            top.job.text = infor.data.job;
            top.link_phone.text = infor.data.link_phone;
            top.tmail_url.text = infor.data.tmail_url;
            top.jd_url.text = infor.data.jd_url;
            top.other_url.text = infor.data.other_url;
            top.product_desc.text = infor.data.product_desc;
            top.create_time.text = infor.data.create_time;
            
            arr = [[NSMutableArray alloc] init];
            for (SUserReferInfo * list in infor.data.product_pic) {
                [arr addObject:list.path];
            }
            
            brr = [[NSMutableArray alloc] init];
            [brr addObject:infor.data.business_license];
            
            crr = [[NSMutableArray alloc] init];
            for (SUserReferInfo * list in infor.data.other_license) {
                [crr addObject:list.path];
            }
            [_mCollect reloadData];
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
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"推荐详情";
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
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return arr.count;
    }
    if (section == 1) {
        return brr.count;
    }
    return crr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    if (section == 0) {
        return UIEdgeInsetsMake(650, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//设置垂直间距,默认的垂直和水平间距都是10
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

    return 10;
}
//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenW - 10 * 4)/3, (ScreenW - 10 * 4)/3);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        CGSize size = {ScreenW,0.01};
        return size;
    }
    CGSize size = {ScreenW,50};
    return size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SOnlineShop_ClassInfoList_more_header * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SOnlineShop_ClassInfoList_more_header" forIndexPath:indexPath];
        //        [header.moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        header.pur_left.hidden = YES;
        header.pur_right.hidden = YES;
        
        header.backgroundColor = [UIColor groupTableViewBackgroundColor];
        header.thisTitle.textColor = WordColor_sub;
        header.thisTitle.backgroundColor = [UIColor clearColor];
        header.pur_left_WWW.constant = 5;
        if (indexPath.section == 0) {
            header.thisTitle.text = @"产品照片";
        }
        if (indexPath.section == 1) {
            header.thisTitle.text = @"营业执照照片";
        }
        if (indexPath.section == 2) {
            header.thisTitle.text = @"其他证件照片";
        }
        reusableview = header;

    }// header;
    return reusableview;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SComRecom_listInforCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SComRecom_listInforCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        [mCell.path sd_setImageWithURL:arr[indexPath.row] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    }
    if (indexPath.section == 1) {
        [mCell.path sd_setImageWithURL:brr[indexPath.row] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    }
    if (indexPath.section == 2) {
        [mCell.path sd_setImageWithURL:crr[indexPath.row] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    }
    
    return mCell;
}
@end

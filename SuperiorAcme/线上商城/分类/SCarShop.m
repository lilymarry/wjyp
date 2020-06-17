//
//  SCarShop.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarShop.h"
#import "SCarShopTop.h"
#import "SCarShopTopCell.h"
#import "SCarShop_sub.h"
#import "SCarBuyCarSelect.h"
#import "SCarClassView.h"

@interface SCarShop () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray * arr;
    NSArray * brr;
    SCarShopTop * top;
    NSString * model_min_price;//价格最小不能为0 单位为元
    NSString * model_max_price;//价格最大值
    BOOL first_isno_one;
    BOOL first_isno_two;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation SCarShop

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
    
    SCarBuyCarSelect * carSelect = [[SCarBuyCarSelect alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [carSelect sCarBuyCarSelectSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SCarBuyCarSelect * carSelect = (SCarBuyCarSelect *)data;
            arr = carSelect.data.style_list;
            brr = carSelect.data.brand_list;
            
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
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"汽车购";
    
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
- (void)createUI {
    top = [[SCarShopTop alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 230)];
    [_mCollect addSubview:top];
    top.SCarShopTop_choice = ^(NSString *min_price, NSString *max_price) {
        model_min_price = min_price;
        model_max_price = max_price;
    };
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 0;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 0;//用于控制单元格之间最小 行间距
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    [_mCollect registerNib:[UINib nibWithNibName:@"SCarShopTopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SCarShopTopCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SCarClassView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SCarClassView"];
    
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return arr.count;
    }
    return brr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    if (section == 0) {
        return UIEdgeInsetsMake(230, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ScreenW/4, 100);
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        CGSize size = {ScreenW,40};
        return size;
    }
    CGSize size = {ScreenW,0};
    return size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SCarClassView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SCarClassView" forIndexPath:indexPath];
        header.thisTitle.text = @"品牌";

        
        reusableview = header;
        
    }// header;
     return reusableview;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SCarShopTopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SCarShopTopCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        SCarBuyCarSelect * list = arr[indexPath.row];
        mCell.thisImage.layer.borderWidth = 0.0;
        if (first_isno_one == NO) {
            if (indexPath.row == 0) {
                [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.true_style_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                mCell.thisTitle.textColor = [UIColor redColor];
                list.style_type = YES;
            } else {
                [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.style_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                mCell.thisTitle.textColor = WordColor;
            }
        } else {
            if (list.style_type == NO) {
                [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.style_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                mCell.thisTitle.textColor = WordColor;
            } else {
                [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.true_style_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                mCell.thisTitle.textColor = [UIColor redColor];
            }
        }
        
        mCell.thisTitle.text = list.style_name;
    } else {
        SCarBuyCarSelect * list = brr[indexPath.row];
        mCell.thisTitle.text = list.brand_name;
        if (first_isno_two == NO) {
            if (indexPath.row == 0) {
                mCell.thisTitle.textColor = [UIColor redColor];
                [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.true_brand_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                list.brand_type = YES;
            } else {
                mCell.thisTitle.textColor = WordColor;
                [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.brand_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            }
        } else {
            if (list.brand_type == NO) {
                mCell.thisTitle.textColor = WordColor;
                [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.brand_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            } else {
                mCell.thisTitle.textColor = [UIColor redColor];
                [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.true_brand_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                
            }
        }
    }
    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (first_isno_one == NO) {
            first_isno_one = YES;
            SCarBuyCarSelect * list_first = arr.firstObject;
            list_first.style_type = YES;
            SCarBuyCarSelect * list = arr[indexPath.row];
            if (list.style_type == NO) {
                list.style_type = YES;
            } else {
                list.style_type = NO;
            }
        } else {
            SCarBuyCarSelect * list = arr[indexPath.row];
            if (list.style_type == NO) {
                list.style_type = YES;
            } else {
                list.style_type = NO;
            }
        }
        [_mCollect reloadData];
    } else {
        if (first_isno_two == NO) {
            first_isno_two = YES;
            SCarBuyCarSelect * list_first = brr.firstObject;
            list_first.brand_type = YES;
            SCarBuyCarSelect * list = brr[indexPath.row];
            if (list.brand_type == NO) {
                list.brand_type = YES;
            } else {
                list.brand_type = NO;
            }
        } else {
            SCarBuyCarSelect * list = brr[indexPath.row];
            if (list.brand_type == NO) {
                list.brand_type = YES;
            } else {
                list.brand_type = NO;
            }
        }
        [_mCollect reloadData];
    }
}

- (void)submitBtnClick {
    if ([model_min_price integerValue] == 0) {
        [MBProgressHUD showError:@"价格最小不能为0" toView:self.view];
        return;
    }
//    if ([self styleArr] == NO) {
//        [MBProgressHUD showError:@"请选择车型" toView:self.view];
//        return;
//    }
//    if ([self brandArr] == NO) {
//        [MBProgressHUD showError:@"请选择品牌" toView:self.view];
//        return;
//    }
    SCarShop_sub * shop = [[SCarShop_sub alloc] init];
    shop.min_price = model_min_price;
    shop.max_price = model_max_price;
    //车型
    if (arr.count == 0) {
        shop.style_id = @"0";
    } else {
        NSMutableArray * styleArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < arr.count; i++) {
            SCarBuyCarSelect * list = arr[i];
            if (list.style_type == YES) {
                [styleArr addObject:list.style_id];
            }
        }
        shop.style_id = [styleArr componentsJoinedByString:@","];
    }
    //品牌
    if (brr.count == 0) {
        shop.brand_id = @"0";
    } else {
        NSMutableArray * brandArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < brr.count; i++) {
            SCarBuyCarSelect * list = brr[i];
            if (list.brand_type == YES) {
                [brandArr addObject:list.brand_id];
            }
        }
        shop.brand_id = [brandArr componentsJoinedByString:@","];
    }
    [self.navigationController pushViewController:shop animated:YES];
}
- (BOOL)styleArr {
    for (SCarBuyCarSelect * list in arr) {
        if (list.style_type == YES) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)brandArr {
    for (SCarBuyCarSelect * list in brr) {
        if (list.brand_type == YES) {
            return YES;
        }
    }
    return NO;
}
@end

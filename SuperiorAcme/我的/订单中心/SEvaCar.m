//
//  SEvaCar.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaCar.h"
#import "SEvaCarCell.h"
#import "SEvaCar_header.h"
#import "SEvaCar_footer.h"
//三方多图
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"

#import "SCarOrderCommentPage.h"//汽车购界面显示
#import "SHouseOrderCommentPage.h"//房产购界面显示

#import "SCarOrderAddComment.h"//汽车购评价
#import "SHouseOrderAddComment.h"//房产购评价

@interface SEvaCar () <UICollectionViewDelegate,UICollectionViewDataSource,ZLPhotoPickerBrowserViewControllerDelegate>
{
    
    NSString * car_img;//": "http://wjyp.txunda.com/Uploads/CarBuy/2017-09-19/59c0b1324fc8e.png",//图片
    NSString * car_name;//": "宝马x6 -- 惠安",//车名称
    NSString * pre_money;//": "99.00",//优惠券金额
    NSString * num;//": "1",//购买数量
    NSString * goods_price;//": "99.00",//优惠券总价
    NSString * order_price;//": "99.00",//订单总价
    NSString * true_pre_money;//": "200.00",//可抵扣金额
    NSString * all_price;//": "500000.00",//车全价
    
    NSArray * arr;//标签数组
    
    NSInteger oneStar_num;
    NSInteger twoStar_num;
    NSInteger threeStar_num;
    NSInteger fourStar_num;
    NSInteger fiveStar_num;
    
    NSMutableArray * pic_arr;//图片数组
    
    SEvaCar_footer * footer;//取评价内容做全局
    
    UIButton * rigthBtn;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SEvaCar

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"评价";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNav];
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _mCollect.collectionViewLayout = mFlowLayout;
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    [_mCollect registerNib:[UINib nibWithNibName:@"SEvaCarCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SEvaCarCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SEvaCar_header" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SEvaCar_header"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SEvaCar_footer" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SEvaCar_footer"];

    [self showModel];
    oneStar_num = 4;
    twoStar_num = 4;
    threeStar_num = 4;
    fourStar_num = 4;
    fiveStar_num = 4;
    pic_arr = [[NSMutableArray alloc] init];
}
- (void)showModel {
    if ([_type isEqualToString:@"汽车购"]) {
        SCarOrderCommentPage * comment = [[SCarOrderCommentPage alloc] init];
        comment.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [comment sCarOrderCommentPageSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SCarOrderCommentPage * comment = (SCarOrderCommentPage *)data;
                car_img = comment.data.car_img;
                car_name = comment.data.car_name;
                pre_money = comment.data.pre_money;
                num = comment.data.num;
                goods_price = comment.data.goods_price;
                order_price = comment.data.order_price;
                true_pre_money = comment.data.true_pre_money;
                all_price = comment.data.all_price;
                arr = comment.data.label_list;
                [_mCollect reloadData];
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_type isEqualToString:@"房产购"]) {
        SHouseOrderCommentPage * comment = [[SHouseOrderCommentPage alloc] init];
        comment.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [comment sHouseOrderCommentPageSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SHouseOrderCommentPage * comment = (SHouseOrderCommentPage *)data;
                car_img = comment.data.house_style_img;
                car_name = [NSString stringWithFormat:@"%@ %@ %@/平",comment.data.house_name,comment.data.style_name,comment.data.one_price];
                pre_money = comment.data.pre_money;
                num = comment.data.num;
                goods_price = comment.data.goods_price;
                order_price = comment.data.order_price;
                true_pre_money = comment.data.true_pre_money;
                all_price = comment.data.all_price;
                arr = comment.data.label_list;
                [_mCollect reloadData];
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
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
    
    [rigthBtn setTitle:@"提交" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arr.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([_type isEqualToString:@"汽车购"]) {
        CGSize size = {ScreenW,420 - 50};
        return size;
    }
    CGSize size = {ScreenW,420};
    return size;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = {ScreenW,300};
    return size;
}
#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SEvaCar_header * header = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SEvaCar_header" forIndexPath:indexPath];
        [header.car_img sd_setImageWithURL:[NSURL URLWithString:car_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        header.car_name.text = car_name;
        header.pre_money.text = [NSString stringWithFormat:@"￥%@",pre_money];
        
        if ([_type isEqualToString:@"汽车购"]) {
            header.fiveStar.hidden = YES;
            header.fiveStar_HHH.constant = 0;
            header.all_price.text = [NSString stringWithFormat:@"车全款：￥%@",all_price];
            header.true_pre_money.text = [NSString stringWithFormat:@"可    抵：￥%@车款",true_pre_money];
        }
        if ([_type isEqualToString:@"房产购"]) {
            header.oneStar_title.text = @"价格";
            header.twoStar_title.text = @"地段";
            header.threeStar_title.text = @"配套";
            header.fourStar_title.text = @"交通";
            header.all_price.text = [NSString stringWithFormat:@"房全款：￥%@",all_price];
            header.true_pre_money.text = [NSString stringWithFormat:@"可    抵：￥%@房款",true_pre_money];
        }
        //评价分数
        header.SEvaCar_header_StarNum = ^(NSInteger index, NSInteger starNum) {
            if (index == 0) {
                oneStar_num = starNum;
            }
            if (index == 1) {
                twoStar_num = starNum;
            }
            if (index == 2) {
                threeStar_num = starNum;
            }
            if (index == 3) {
                fourStar_num = starNum;
            }
            if (index == 4) {
                fiveStar_num = starNum;
            }
        };
        
        reusableview = header;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        footer = [_mCollect dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SEvaCar_footer" forIndexPath:indexPath];

        //删除已选
        footer.SEvaCar_footer_Close = ^(NSInteger num) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除?" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击取消");
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击确定");
                [footer closeShow:num];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        };
        //选择图片
        footer.SEvaCar_footer_Choice = ^(NSMutableArray *arr) {
            ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
            pickerVc.maxCount = 5 - (arr.count - 1);
            pickerVc.status = PickerViewShowStatusCameraRoll;
            pickerVc.photoStatus = PickerPhotoStatusPhotos;
            pickerVc.topShowPhotoPicker = YES;
            pickerVc.isShowCamera = YES;
            pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
                NSLog(@"sss:%@",status.mutableCopy);
                
                for (int i = 0; i < status.count; i++) {
                    id assets = status[i];
                    if ([assets isKindOfClass:[ZLPhotoAssets class]]) {
                        ZLPhotoAssets * ddd = (ZLPhotoAssets *)assets;
                        [arr addObject:ddd.originImage];
                    } else {
                        ZLCamera * ddd = (ZLCamera *)assets;
                        [arr addObject:ddd.photoImage];
                    }
                }
                pic_arr = arr;
                [footer choiceShow:arr];
            };
            [pickerVc showPickerVc:self];
        };
        //看图片
        footer.SEvaCar_footer_Look = ^(NSArray *arr, NSInteger num) {
            NSMutableArray * thisPic_sub = [[NSMutableArray alloc] init];
            for (int i = 0; i < arr.count; i++) {
                ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
                photo.photoImage = arr[i];
                [thisPic_sub addObject:photo];
            }
            
            ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
            // 淡入淡出效果
            // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
            // 数据源/delegate
            pickerBrowser.editing = YES;
            pickerBrowser.photos = thisPic_sub;
            // 能够删除
            pickerBrowser.delegate = self;
            // 当前选中的值
            pickerBrowser.currentIndex = num;
            // 展示控制器
            [pickerBrowser showPickerVc:self];
        };
        
        reusableview = footer;
    }
    return reusableview;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((ScreenW - 10 * 5)/4, 40);
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SEvaCarCell * cell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SEvaCarCell" forIndexPath:indexPath];
    cell.choiceBtn.layer.borderWidth = 0.5;
    [cell.choiceBtn setTag:indexPath.row];
    [cell.choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([_type isEqualToString:@"汽车购"]) {
        SCarOrderCommentPage * list = arr[indexPath.row];
        [cell.choiceBtn setTitle:list.car_label forState:UIControlStateNormal];
        if (list.label_BOOL == NO) {
            [cell.choiceBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
            cell.choiceBtn.layer.borderColor = WordColor_sub_sub.CGColor;
        } else {
            [cell.choiceBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            cell.choiceBtn.layer.borderColor = [UIColor redColor].CGColor;
        }
    }
    if ([_type isEqualToString:@"房产购"]) {
        SHouseOrderCommentPage * list = arr[indexPath.row];
        [cell.choiceBtn setTitle:list.house_label forState:UIControlStateNormal];
        if (list.label_BOOL == NO) {
            [cell.choiceBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
            cell.choiceBtn.layer.borderColor = WordColor_sub_sub.CGColor;
        } else {
            [cell.choiceBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            cell.choiceBtn.layer.borderColor = [UIColor redColor].CGColor;
        }
    }
    

    return cell;
}
- (void)choiceBtnClick:(UIButton *)btn {
    if ([_type isEqualToString:@"汽车购"]) {
        SCarOrderCommentPage * list = arr[btn.tag];
        if (list.label_BOOL == NO) {
            list.label_BOOL = YES;
        } else {
            list.label_BOOL = NO;
        }
    }
    if ([_type isEqualToString:@"房产购"]) {
        SHouseOrderCommentPage * list = arr[btn.tag];
        if (list.label_BOOL == NO) {
            list.label_BOOL = YES;
        } else {
            list.label_BOOL = NO;
        }
    }
    [_mCollect reloadData];
}
- (void)rigthBtnClick {
    rigthBtn.userInteractionEnabled = NO;

    if ([_type isEqualToString:@"汽车购"]) {
        SCarOrderAddComment * addComment = [[SCarOrderAddComment alloc] init];
        addComment.order_id = _order_id;
        addComment.exterior = [NSString stringWithFormat:@"%zd",oneStar_num];
        addComment.space = [NSString stringWithFormat:@"%zd",twoStar_num];
        addComment.controllability = [NSString stringWithFormat:@"%zd",threeStar_num];
        addComment.consumption = [NSString stringWithFormat:@"%zd",fourStar_num];
        
        NSMutableArray * model_arr = [[NSMutableArray alloc] init];
        for (SCarOrderCommentPage * list in arr) {
            if (list.label_BOOL == YES) {
                [model_arr addObject:list.label_id];
            }
        }
        if (model_arr.count == 0) {
            addComment.label_str = @"";
        } else {
            addComment.label_str = [NSString stringWithFormat:@",%@,",[model_arr componentsJoinedByString:@","]];
        }
        
        NSMutableDictionary * pic_dic = [[NSMutableDictionary alloc] init];
        for (int i = 1; i < pic_arr.count; i++) {
            [pic_dic setValue:[self compressImage2Quality:pic_arr[i] toByte:102400] forKey:[NSString stringWithFormat:@"pictures%zd",i - 1]];
        }
        if (pic_arr.count == 1) {
            addComment.pictures = nil;
        } else {
            addComment.pictures = pic_dic;
        }
        if ([footer.evaTV.text isEqualToString:@"写下您的评价吧~"]) {
            addComment.content = @"";
        } else {
            addComment.content = footer.evaTV.text;
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [addComment sCarOrderAddCommentSuccess:^(NSString *code, NSString *message) {
            rigthBtn.userInteractionEnabled = YES;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.SEvaCar_Back) {
                        self.SEvaCar_Back();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            rigthBtn.userInteractionEnabled = YES;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_type isEqualToString:@"房产购"]) {
        SHouseOrderAddComment * addComment = [[SHouseOrderAddComment alloc] init];
        addComment.order_id = _order_id;
        addComment.price = [NSString stringWithFormat:@"%zd",oneStar_num];
        addComment.lot = [NSString stringWithFormat:@"%zd",twoStar_num];
        addComment.supporting = [NSString stringWithFormat:@"%zd",threeStar_num];
        addComment.traffic = [NSString stringWithFormat:@"%zd",fourStar_num];
        addComment.environment = [NSString stringWithFormat:@"%zd",fiveStar_num];
        
        NSMutableArray * model_arr = [[NSMutableArray alloc] init];
        for (SCarOrderCommentPage * list in arr) {
            if (list.label_BOOL == YES) {
                [model_arr addObject:list.label_id];
            }
        }
        if (model_arr.count == 0) {
            addComment.label_str = @"";
        } else {
            addComment.label_str = [NSString stringWithFormat:@",%@,",[model_arr componentsJoinedByString:@","]];
        }
        
        NSMutableDictionary * pic_dic = [[NSMutableDictionary alloc] init];
        for (int i = 1; i < pic_arr.count; i++) {
            [pic_dic setValue:[self compressImage2Quality:pic_arr[i] toByte:1] forKey:[NSString stringWithFormat:@"pictures%zd",i - 1]];
        }
        if (pic_arr.count == 1) {
            addComment.pictures = nil;
        } else {
            addComment.pictures = pic_dic;
        }
        if ([footer.evaTV.text isEqualToString:@"写下您的评价吧~"]) {
            addComment.content = @"";
            
        } else {
            addComment.content = footer.evaTV.text;
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [addComment HouseOrderAddCommentSuccess:^(NSString *code, NSString *message) {
            rigthBtn.userInteractionEnabled = YES;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.SEvaCar_Back) {
                        self.SEvaCar_Back();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            rigthBtn.userInteractionEnabled = YES;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
- (UIImage *)compressImage2Quality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compressQuality = 1;
    NSData *data = UIImageJPEGRepresentation(image, compressQuality);
    if (data.length < maxLength) {
        //质量小于压缩大小
        return image;
    }
    /*压缩质量*/
    //指定大小压缩比例
    compressQuality = (CGFloat)maxLength/(CGFloat)data.length;
    data = UIImageJPEGRepresentation(image, compressQuality);
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) {
        //质量小于压缩大小
        return resultImage;
    }
    /*压缩大小*/
    NSUInteger lastDataLenth = 0;
    while (data.length > maxLength && data.length != lastDataLenth) {
        lastDataLenth = data.length;
        //计算压缩比例
        CGFloat compressSize = (CGFloat) maxLength/(CGFloat)data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(compressSize)), (NSUInteger)(resultImage.size.height * sqrtf(compressSize)));
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return resultImage;
}
@end

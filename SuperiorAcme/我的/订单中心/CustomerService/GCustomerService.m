//
//  GCustomerService.m
//  SeaMonkey
//
//  Created by TXD_air on 16/10/31.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//



#import "GCustomerService.h"
#import "GCustomerServiceType.h"//选择 售后类型、货物状态、原因
#import "HRelease_imageView.h"//多图上传凭证
//三方多图
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"
//申请售后提交
#import "SAfterSaleBackApply.h"
#import "SAfterSaleBackApplyType.h"//售后类型及货物状态


@interface GCustomerService () <ZLPhotoPickerBrowserViewControllerDelegate,UITextViewDelegate>
{
    HRelease_imageView * rele_imageView;
    NSMutableArray * imageArr;
    
    NSArray * modelArr;
    NSArray * modelBrr;
    BOOL moneyType;//YES显示 NO隐藏
    
    NSString * one_id;
    NSString * two_id;
    NSString * three_id;
}
@property (weak, nonatomic) IBOutlet UILabel *titleContent;
@property (weak, nonatomic) IBOutlet UIView *titleContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleContentView_HHH;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UITextField *oneTF;
@property (strong, nonatomic) IBOutlet UITextField *threeTF;
@property (strong, nonatomic) IBOutlet UITextField *twoTF;
@property (strong, nonatomic) IBOutlet UITextField *fourTF;
@property (strong, nonatomic) IBOutlet UITextView *fiveTV;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIView *image_View;//上传凭证
@property (strong, nonatomic) IBOutlet UILabel *thisMoneyContent;
@property (weak, nonatomic) IBOutlet UIView *hiddenView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hiddenView_HHH;
@end

@implementation GCustomerService


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNav];
    
    _thisMoneyContent.text = [NSString stringWithFormat:@"最多可退%@元(若涉及运费、税费退还问题，请与商家协商解决。)",_thisMoney];
    
    [_oneBtn setTag:0];
    [_twoBtn setTag:1];
    [_threeBtn setTag:2];
    [_oneBtn addTarget:self action:@selector(choiceTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [_twoBtn addTarget:self action:@selector(choiceTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [_threeBtn addTarget:self action:@selector(choiceTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    _fiveTV.delegate = self;
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 5;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    rele_imageView = [[HRelease_imageView alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 100)];
    [_image_View addSubview:rele_imageView];
    __block GCustomerService * gSelf = self;
    imageArr = [[NSMutableArray alloc] initWithObjects:@"照片默认", nil];
    //选择图片
    rele_imageView.HRelease_imageViewChoice = ^(UIButton * btn) {
        [gSelf choiceImageView];
    };
    //观看图片
    rele_imageView.HRelease_imageViewLook = ^(NSInteger num) {
        // 图片游览器
        NSMutableArray * thisPic = [[NSMutableArray alloc] init];
        for (int i = 0; i < imageArr.count; i++) {
            if (i > 0) {
                [thisPic addObject:imageArr[i]];
            }
        }
        [gSelf look:thisPic num:num - 1];
    };
    //删除图片
    rele_imageView.HRelease_imageViewClose = ^(NSInteger num) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除?" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确定");
            
            [imageArr removeObjectAtIndex:num];
            [rele_imageView setChoiceImage:imageArr];
            
        }]];
        
        [gSelf presentViewController:alertController animated:YES completion:nil];
    };
    
    SAfterSaleBackApplyType * nowType = [[SAfterSaleBackApplyType alloc] init];
    nowType.order_goods_id = _order_goods_id;
    nowType.order_type = _order_type != nil ? _order_type : @"";
    [nowType sAfterSaleBackApplyTypeSuccess:^(NSString *code, NSString *message, id data) {
        if ([code isEqualToString:@"1"]) {
            SAfterSaleBackApplyType * nowType = (SAfterSaleBackApplyType *)data;
            if ([nowType.data.money_status isEqualToString:@"1"]) {
                _hiddenView.hidden = NO;
                _hiddenView_HHH.constant = 120;
                moneyType = YES;
            } else {
                _hiddenView.hidden = YES;
                _hiddenView_HHH.constant = 0;
                moneyType = NO;
            }
            if ([nowType.data.after_desc isEqualToString:@""] || nowType.data.after_desc == nil) {
                _titleContentView.hidden = YES;
                _titleContentView_HHH.constant = 0;
            } else {
                _titleContent.text = nowType.data.after_desc;
            }
            
            modelArr = nowType.data.list;
            modelBrr = nowType.data.goods_status;
            
            if (!SWNOTEmptyArr(modelArr)) {
                
                [MBProgressHUD showError:@"没有可发起的售后类型" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                    return ;
                });
            }
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"申请售后";
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
- (void)choiceTypeClick:(UIButton *)btn {
    GCustomerServiceType * choice = [[GCustomerServiceType alloc] init];
    choice.type = btn.tag;
    choice.modelArr = modelArr;
    choice.modelBrr = modelBrr;
    [self.navigationController pushViewController:choice animated:YES];
    choice.GCustomerServiceType_Type = ^(NSString * thisType, NSString * type_id) {
        if (btn.tag == 0) {
            _oneTF.text = thisType;
            one_id = type_id;
            if ([thisType isEqualToString:@"免费换货"] || [thisType isEqualToString:@"免费维修"]) {
                _hiddenView.hidden = YES;
                _hiddenView_HHH.constant = 0;
                moneyType = NO;
            } else {
                _hiddenView.hidden = NO;
                _hiddenView_HHH.constant = 120;
                moneyType = YES;
            }
        } else if (btn.tag == 1) {
            _twoTF.text = thisType;
            two_id = type_id;
        } else if (btn.tag == 2) {
            _threeTF.text = thisType;
            three_id = type_id;
        }
    };
}

#pragma mark - 多图
- (void)choiceImageView {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 5 - (imageArr.count - 1);
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
                [imageArr addObject:ddd.originImage];
            } else {
                ZLCamera * ddd = (ZLCamera *)assets;
                [imageArr addObject:ddd.photoImage];
            }
        }
        [rele_imageView setChoiceImage:imageArr];
    };
    [pickerVc showPickerVc:self];
}
- (void)look:(NSMutableArray *)thisPhoto num:(NSInteger )num {
    NSMutableArray * thisPic_sub = [[NSMutableArray alloc] init];
    for (int i = 0; i < thisPhoto.count; i++) {
        ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
        photo.photoImage = thisPhoto[i];
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
}
//- (void)closeBtnClick {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除?" preferredStyle:UIAlertControllerStyleAlert];
//
//
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//        NSLog(@"点击取消");
//
//    }]];
//
//
//    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击确定");
//
//        //        [_imageBtn setBackgroundImage:[UIImage imageNamed:@"发布添加"] forState:UIControlStateNormal];
//        //        _closeBtn.hidden = YES;
//    }]];
//
//    [self presentViewController:alertController animated:YES completion:nil];
//}

- (void)submitBtnClick {
    if ([_oneTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择售后类型" toView:self.view];
        return;
    }
    if ([_twoTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择货物状态" toView:self.view];
        return;
    }
    if ([_threeTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择原因" toView:self.view];
        return;
    }
    if (moneyType == YES && [_fourTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入退款金额" toView:self.view];
        return;
    }
    if (moneyType == NO && [_fourTF.text floatValue] > [_thisMoney floatValue]) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"最多%@x(退货运费由买家承担)",_thisMoney] toView:self.view];
        return;
    }
    SAfterSaleBackApply * saleOne = [[SAfterSaleBackApply alloc] init];
    saleOne.reason = one_id;
    saleOne.back_money = _fourTF.text;
    saleOne.back_desc = _fiveTV.text;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (NSInteger i = 1; i < imageArr.count; i++) {
        [dic setObject:imageArr[i] forKey:[NSString stringWithFormat:@"back_img[%zd]",i - 1]];
    }
    saleOne.back_img = dic;
    saleOne.cause = three_id;
    saleOne.goods_status = two_id;
    saleOne.order_id = _order_id;
    saleOne.order_type = _order_type;
    saleOne.order_goods_id = _order_goods_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [saleOne sAfterSaleBackApplySuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToViewController:_inforBlock animated:YES];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

#pragma mark -UITextViewDelegate zhao
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请输入"]) {
        textView.text = @"";
        textView.textColor = WordColor;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入";
        textView.textColor = WordColor_sub_sub;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end

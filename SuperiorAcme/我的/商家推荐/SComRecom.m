//
//  SComRecom.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SComRecom.h"
#import "SComRecomChoice.h"
#import "HRelease_imageView.h"
//三方多图
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"

#import "SUserMerchantRefer.h"

@interface SComRecom () <ZLPhotoPickerBrowserViewControllerDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    HRelease_imageView * rele_imageView1;
    NSMutableArray * imageArr1;
    
    HRelease_imageView * rele_imageView2;
    NSMutableArray * imageArr2;
    
    HRelease_imageView * rele_imageView3;
    NSMutableArray * imageArr3;
    
    NSString * submit_range_id;
    
}
@property (strong, nonatomic) IBOutlet UIButton *choiceBtn;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *lastView;
@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;


@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *range_id_TF;
@property (strong, nonatomic) IBOutlet UITextField *link_manTF;
@property (strong, nonatomic) IBOutlet UITextField *jobTF;
@property (strong, nonatomic) IBOutlet UITextField *link_phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *tmail_urlTF;
@property (strong, nonatomic) IBOutlet UITextField *jd_urlTF;
@property (strong, nonatomic) IBOutlet UITextField *other_urlTF;
@property (strong, nonatomic) IBOutlet UITextView *product_descTV;
@end

@implementation SComRecom

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_choiceBtn addTarget:self action:@selector(choiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _product_descTV.delegate = self;
    _nameTF.delegate = self;
    _link_manTF.delegate = self;
    _link_phoneTF.delegate = self;
    _jobTF.delegate = self;
    _tmail_urlTF.delegate = self;
    _jd_urlTF.delegate = self;
    _other_urlTF.delegate = self;
    
    
    __block SComRecom * gSelf = self;
    
    
    rele_imageView1 = [[HRelease_imageView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 100)];
    [_topView addSubview:rele_imageView1];
    imageArr1 = [[NSMutableArray alloc] initWithObjects:@"照片默认", nil];
    //选择图片
    rele_imageView1.HRelease_imageViewChoice = ^(UIButton * btn) {
        [gSelf choiceImageView1];
    };
    //观看图片
    rele_imageView1.HRelease_imageViewLook = ^(NSInteger num) {
        // 图片游览器
        NSMutableArray * thisPic = [[NSMutableArray alloc] init];
        for (int i = 0; i < imageArr1.count; i++) {
            if (i > 0) {
                [thisPic addObject:imageArr1[i]];
            }
        }
        [gSelf look:thisPic num:num - 1];
    };
    //删除图片
    rele_imageView1.HRelease_imageViewClose = ^(NSInteger num) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除?" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确定");
            
            [imageArr1 removeObjectAtIndex:num];
            [rele_imageView1 setChoiceImage:imageArr1];
            
        }]];
        
        [gSelf presentViewController:alertController animated:YES completion:nil];
    };
    
    
    rele_imageView2 = [[HRelease_imageView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 100)];
    [_secondView addSubview:rele_imageView2];
    imageArr2 = [[NSMutableArray alloc] initWithObjects:@"照片默认", nil];
    //选择图片
    rele_imageView2.HRelease_imageViewChoice = ^(UIButton * btn) {
        [gSelf choiceImageView2];
    };
    //观看图片
    rele_imageView2.HRelease_imageViewLook = ^(NSInteger num) {
        // 图片游览器
        NSMutableArray * thisPic = [[NSMutableArray alloc] init];
        for (int i = 0; i < imageArr2.count; i++) {
            if (i > 0) {
                [thisPic addObject:imageArr2[i]];
            }
        }
        [gSelf look:thisPic num:num - 1];
    };
    //删除图片
    rele_imageView2.HRelease_imageViewClose = ^(NSInteger num) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除?" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确定");
            
            [imageArr2 removeObjectAtIndex:num];
            [rele_imageView2 setChoiceImage:imageArr2];
            
        }]];
        
        [gSelf presentViewController:alertController animated:YES completion:nil];
    };
    

    
    rele_imageView3 = [[HRelease_imageView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 100)];
    [_lastView addSubview:rele_imageView3];
    imageArr3 = [[NSMutableArray alloc] initWithObjects:@"照片默认", nil];
    //选择图片
    rele_imageView3.HRelease_imageViewChoice = ^(UIButton * btn) {
        [gSelf choiceImageView3];
    };
    //观看图片
    rele_imageView3.HRelease_imageViewLook = ^(NSInteger num) {
        // 图片游览器
        NSMutableArray * thisPic = [[NSMutableArray alloc] init];
        for (int i = 0; i < imageArr3.count; i++) {
            if (i > 0) {
                [thisPic addObject:imageArr3[i]];
            }
        }
        [gSelf look:thisPic num:num - 1];
    };
    //删除图片
    rele_imageView3.HRelease_imageViewClose = ^(NSInteger num) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除?" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确定");
            
            [imageArr3 removeObjectAtIndex:num];
            [rele_imageView3 setChoiceImage:imageArr3];
            
        }]];
        
        [gSelf presentViewController:alertController animated:YES completion:nil];
    };
}

#pragma mark - 多图1
- (void)choiceImageView1 {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 9 - (imageArr1.count - 1);
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
                [imageArr1 addObject:ddd.originImage];
            } else {
                ZLCamera * ddd = (ZLCamera *)assets;
                [imageArr1 addObject:ddd.photoImage];
            }
        }
        [rele_imageView1 setChoiceImage:imageArr1];
    };
    [pickerVc showPickerVc:self];
}
#pragma mark - 多图2
- (void)choiceImageView2 {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 1 - (imageArr2.count - 1);
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
                [imageArr2 addObject:ddd.originImage];
            } else {
                ZLCamera * ddd = (ZLCamera *)assets;
                [imageArr2 addObject:ddd.photoImage];
            }
        }
        [rele_imageView2 setChoiceImage:imageArr2];
    };
    [pickerVc showPickerVc:self];
}
#pragma mark - 多图3
- (void)choiceImageView3 {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 9 - (imageArr3.count - 1);
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
                [imageArr3 addObject:ddd.originImage];
            } else {
                ZLCamera * ddd = (ZLCamera *)assets;
                [imageArr3 addObject:ddd.photoImage];
            }
        }
        [rele_imageView3 setChoiceImage:imageArr3];
    };
    [pickerVc showPickerVc:self];
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
- (void)closeBtnClick {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        
        //        [_imageBtn setBackgroundImage:[UIImage imageNamed:@"发布添加"] forState:UIControlStateNormal];
        //        _closeBtn.hidden = YES;
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"商家推荐";
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
#pragma mark - 选择经营范围
- (void)choiceBtnClick {
    SComRecomChoice * choice = [[SComRecomChoice alloc] init];
    choice.submit_range_id = submit_range_id;
    [self.navigationController pushViewController:choice animated:YES];
    choice.SComRecomChoiceSuccess = ^(NSString *range_id, NSString *range_name) {
        _range_id_TF.text = range_name;
        submit_range_id = range_id;
    };
}
- (void)submitBtnClick {
    SUserMerchantRefer * refer = [[SUserMerchantRefer alloc] init];
    if ([_nameTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写您的商户名称" toView:self.view];
        return;
    }
    refer.name = _nameTF.text;
    if (submit_range_id == nil) {
        [MBProgressHUD showError:@"请选择经营范围" toView:self.view];
        return;
    }
    refer.range_id = submit_range_id;
    if ([_link_manTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写商家联系人" toView:self.view];
        return;
    }
    refer.link_man = _link_manTF.text;
    if ([_link_phoneTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写商家联系电话" toView:self.view];
        return;
    }
    refer.link_phone = _link_phoneTF.text;
    if ([_jobTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写联系人职位" toView:self.view];
        return;
    }
    refer.job = _jobTF.text;
    if ([_tmail_urlTF.text isEqualToString:@""] && [_jd_urlTF.text isEqualToString:@""] && [_other_urlTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请至少填写一种网店地址" toView:self.view];
        return;
    }
    refer.tmail_url = _tmail_urlTF.text;
    refer.jd_url = _jd_urlTF.text;
    refer.other_url = _other_urlTF.text;
    if ([_product_descTV.text isEqualToString:@"请填写计划销售产品描述"]) {
        [MBProgressHUD showError:@"请填写计划销售产品描述" toView:self.view];
        return;
    }
    refer.product_desc = _product_descTV.text;

    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if (imageArr1.count == 1) {
        [MBProgressHUD showError:@"请上传产品图片" toView:self.view];
        return;
    }
    if (imageArr2.count == 1) {
        [MBProgressHUD showError:@"请上传营业执照" toView:self.view];
        return;
    }
    if (imageArr3.count == 1) {
        [MBProgressHUD showError:@"请上传其他证件照片" toView:self.view];
        return;
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    for (int i = 0; i < imageArr1.count; i++) {
        if (i != 0) {
            [dic setObject:[self compressImage2Quality:imageArr1[i] toByte:102400] forKey:[NSString stringWithFormat:@"product_pic[%zd]",i - 1]];
        }
    }
    for (int i = 0; i < imageArr2.count; i++) {
        if (i != 0) {
            [dic setObject:[self compressImage2Quality:imageArr2[i] toByte:102400] forKey:[NSString stringWithFormat:@"business_license[%zd]",i - 1]];

        }
    }
    for (int i = 0; i < imageArr3.count; i++) {
        if (i != 0) {
            [dic setObject:[self compressImage2Quality:imageArr3[i] toByte:102400] forKey:[NSString stringWithFormat:@"other_license[%zd]",i - 1]];
        }
    }
    refer.pic_dic = dic;
    [refer sUserMerchantReferSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请填写计划销售产品描述"]) {
        textView.text = @"";
        textView.textColor = WordColor;
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请填写计划销售产品描述";
        textView.textColor = WordColor_30;
    }
    return YES;
}
@end

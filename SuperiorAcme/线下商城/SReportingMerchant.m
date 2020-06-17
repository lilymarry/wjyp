//
//  SReportingMerchant.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#define TEXTVIEW_TIP_TEXT (@"请描述您的举报理由,200字以内")

#import "SReportingMerchant.h"
#import "SBusinessQualification.h"
#import "SMerchantReport.h"
#import "HRelease_imageView.h"  //上传凭证
//三方多图
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"




@interface SReportingMerchant () <UITextViewDelegate,ZLPhotoPickerBrowserViewControllerDelegate>
{
    NSString * model_report_type_id;
}
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITextView *reportTV;
@property (strong, nonatomic) IBOutlet UILabel *rep_Type;

@property (weak, nonatomic) IBOutlet UIView *image_View;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) HRelease_imageView *rele_imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image_view_gapCon;


@end

@implementation SReportingMerchant

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _reportTV.delegate = self;
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    model_report_type_id = @"";
    
    [self uploadImgPingZhengMethod];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"举报商家";
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
#pragma mark - 举报理由
- (IBAction)reportBtn:(UIButton *)sender {
    SBusinessQualification * bq = [[SBusinessQualification alloc] init];
    bq.type = YES;
    [self.navigationController pushViewController:bq animated:YES];
    bq.SBusinessQualification_choice = ^(NSString *report_type_id, NSString *report_type_name) {
        model_report_type_id = report_type_id;
        _rep_Type.text = report_type_name;
    };
}
- (void)submitBtnClick {
    SMerchantReport * rep = [[SMerchantReport alloc] init];
    rep.report_type_id = model_report_type_id;
    if ([_reportTV.text isEqualToString:@"请描述您的举报理由"]) {
        rep.report_content = @"";
    } else {
        rep.report_content = _reportTV.text;
    }
    rep.merchant_id = _merchant_id;
    
    if (!SWNOTEmptyStr(model_report_type_id)) {
        [MBProgressHUD showError:@"请输入举报类型" toView:self.view];
        return;
    }
    
    if (!SWNOTEmptyStr(rep.report_content)) {
        [MBProgressHUD showError:@"请填写举报理由" toView:self.view];
        return;
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (NSInteger i = 1; i < _imageArr.count; i++) {
        [dic setObject:_imageArr[i] forKey:[NSString stringWithFormat:@"report_pic[%zd]",i - 1]];
    }
    
    if(!SWNOTEmptyDictionary(dic)){
        [MBProgressHUD showError:@"请选择上传凭证" toView:self.view];
        return;
    }
    rep.report_pic = dic;
    rep.isUnderline = _isUnderline;
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [rep sMerchantReportSuccess:^(NSString *code, NSString *message) {
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
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:TEXTVIEW_TIP_TEXT]) {
        textView.text = @"";
        textView.textColor = WordColor;
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = TEXTVIEW_TIP_TEXT;
        textView.textColor = WordColor_30;
    }
    return YES;
}

#pragma mark - 上传凭证视

-(void)uploadImgPingZhengMethod
{
    
    _image_view_gapCon.constant = .5;
    
    _rele_imageView = [[HRelease_imageView alloc] initWithFrame:CGRectMake(10, 25, ScreenW - 20, 100)];
    [_image_View addSubview:_rele_imageView];
    
    self.imageArr = [[NSMutableArray alloc] initWithObjects:@"照片默认", nil];
    __weak typeof(self) gSelf = self;
    //选择图片
    gSelf.rele_imageView.HRelease_imageViewChoice = ^(UIButton * btn) {
        [gSelf choiceImageView];
    };
    
    //观看图片
    gSelf.rele_imageView.HRelease_imageViewLook = ^(NSInteger num) {
        // 图片游览器
        NSMutableArray * thisPic = [[NSMutableArray alloc] init];
        for (int i = 0; i < gSelf.imageArr.count; i++) {
            if (i > 0) {
                [thisPic addObject:gSelf.imageArr[i]];
            }
        }
        [gSelf look:thisPic num:num - 1];
    };
    
    //删除图片
    gSelf.rele_imageView.HRelease_imageViewClose = ^(NSInteger num) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除?" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确定");
            
            [gSelf.imageArr removeObjectAtIndex:num];
            [gSelf.rele_imageView setChoiceImage:gSelf.imageArr];
            
        }]];
        
        [gSelf presentViewController:alertController animated:YES completion:nil];
    };
    
}

#pragma mark - 多图
- (void)choiceImageView {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 9 - (_imageArr.count - 1);
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
                [_imageArr addObject:ddd.originImage];
            } else {
                ZLCamera * ddd = (ZLCamera *)assets;
                [_imageArr addObject:ddd.photoImage];
            }
        }
        [_rele_imageView setChoiceImage:_imageArr];
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

@end

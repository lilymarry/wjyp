//
//  SEvaSubmit_subViewController.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaSubmit_subViewController.h"
#import "RatingBar.h"
#import "HRelease_imageView.h"

//三方多图
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"

#import "SOrderCommentGoods.h"

@interface SEvaSubmit_subViewController ()  <ZLPhotoPickerBrowserViewControllerDelegate,UITextViewDelegate>
{
    HRelease_imageView * rele_imageView;
    NSMutableArray * imageArr;
    NSString * star_num;
}
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UIView *evaImageView;
@property (strong, nonatomic) IBOutlet UIImageView *goods_img;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@end

@implementation SEvaSubmit_subViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
//    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"商品评价";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNav];
    
    _contentTV.delegate = self;
    [_goods_img sd_setImageWithURL:[NSURL URLWithString:_model_goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    _goods_name.text = _model_goods_name;
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 5;
    
    //星星
    RatingBar * star_edit = [[RatingBar alloc] initWithFrame:CGRectMake(80,0, 130, 50)];
    star_edit.viewColor = [UIColor clearColor];
    star_edit.enable = YES;
    star_edit.starNumber = 5;
    star_num = @"5";
    star_edit.starNum = ^(int starNum) {
        star_num = [NSString stringWithFormat:@"%d",starNum];
    };
    [_starView addSubview:star_edit];
    
    rele_imageView = [[HRelease_imageView alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 100)];
    [_evaImageView addSubview:rele_imageView];
    imageArr = [[NSMutableArray alloc] initWithObjects:@"照片默认", nil];
    [rele_imageView setChoiceImage:imageArr];
    __block SEvaSubmit_subViewController * gSelf = self;
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
        [self look:thisPic num:num - 1];
    };
    //删除图片
    rele_imageView.HRelease_imageViewClose = ^(NSInteger num) {
        [self delImage:num];
    };
    
    
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
#pragma mark - 多图
- (void)choiceImageView {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 9 - (imageArr.count - 1);
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
- (void)delImage:(NSInteger)num{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        
        [imageArr removeObjectAtIndex:num];
        [rele_imageView setChoiceImage:imageArr];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)submitBnt:(UIButton *)sender {
    _submitBtn.userInteractionEnabled = NO;
    SOrderCommentGoods * add = [[SOrderCommentGoods alloc] init];
    add.order_goods_id = _order_goods_id;
    add.content = [_contentTV.text isEqualToString:@"宝贝满足你的期待吗？说说你的使用心得，分享给想买的他们吧(最多500字)"] ? @"" : _contentTV.text;
    add.all_star = star_num;
    add.order_id = _order_id;
    add.order_type = _order_type;
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    for (int i = 1; i < imageArr.count; i++) {
        [dic setValue:[self compressImage2Quality:imageArr[i] toByte:102400] forKey:[NSString stringWithFormat:@"pictures[%zd]",i - 1]];
    }
    if (imageArr.count == 1) {
        add.pictures = nil;
    } else {
        add.pictures = dic;
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [add sOrderCommentGoodsSuccess:^(NSString *code, NSString *message) {
        _submitBtn.userInteractionEnabled = YES;
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
        _submitBtn.userInteractionEnabled = YES;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
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
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"宝贝满足你的期待吗？说说你的使用心得，分享给想买的他们吧(最多500字)"]) {
        textView.text = @"";
        textView.textColor = WordColor;
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"宝贝满足你的期待吗？说说你的使用心得，分享给想买的他们吧(最多500字)";
        textView.textColor = WordColor_sub;
    }
    return YES;
}
@end

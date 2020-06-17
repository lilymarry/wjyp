//
//  SEvaUnderLineShopVC.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#define TEXTVIEW_TIP_TEXT (@"请输入您对本店的看法吧...")

#import "SEvaUnderLineShopVC.h"
#import "RatingBar.h"
#import "SAAPIHelper.h"
#import "HRelease_imageView.h"  //上传凭证
//三方多图
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"

@interface SEvaUnderLineShopVC ()<ZLPhotoPickerBrowserViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *shopImgV;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIView *shopInvirmentView;
@property (nonatomic,strong)RatingBar *shopInvirmentStarView;

@property (weak, nonatomic) IBOutlet UIView *shopServeceView;
@property (nonatomic,strong)RatingBar *shopServeceStarView;

@property (weak, nonatomic) IBOutlet UIButton *submmitBtn;

@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) HRelease_imageView *rele_imageView;
@property (weak, nonatomic) IBOutlet UIView *image_View;

@property (nonatomic, strong) SAAPIHelper *apiHelper;
@property (nonatomic, strong) UBShopDetailModel *dataModel;


@end

@implementation SEvaUnderLineShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺评论";
    
    self.apiHelper = [SAAPIHelper new];
    [self createNav];
    [self subViewSetting];
    [self uploadImgPingZhengMethod];
    [self feachData];
}

- (IBAction)submmitBtnClick:(UIButton *)sender {
    if(!SWNOTEmptyStr(_order_id)){
        [MBProgressHUD showSuccess:@"订单ID为空" toView:self.view];
        return;
    }
    if ([_textView.text isEqualToString:TEXTVIEW_TIP_TEXT]) {
        _textView.text = @"";
    }
    
    if(_shopInvirmentStarView.starNumber <= 0){
        [MBProgressHUD showSuccess:@"请为店铺环境评星级" toView:self.view];
        return;
    }
    
    if(_shopServeceStarView.starNumber <= 0){
        [MBProgressHUD showSuccess:@"请为店铺服务评星级" toView:self.view];
        return;
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (NSInteger i = 1; i < _imageArr.count; i++) {
        [dic setObject:_imageArr[i] forKey:[NSString stringWithFormat:@"picture[%zd]",i - 1]];
    }
    
    if(!SWNOTEmptyDictionary(dic)){
        [MBProgressHUD showError:@"请选择要上传的图片" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [self.apiHelper offlineStoreCommentWithOrder_id:_order_id
                                            content:_textView.text
                                            picture:dic
                                        environment:_shopInvirmentStarView.starNumber
                                              serve:_shopServeceStarView.starNumber
                                         completion:^(BOOL isSuccess, NSString *message, id result) {
                                             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                             [MBProgressHUD showSuccess:message toView:self.view];
                                             if (isSuccess) {
                                                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                     if (self.isPopRootVC) {
                                                         [self.navigationController popToRootViewControllerAnimated:YES];
                                                         return;
                                                     }
                                                     [self.navigationController popViewControllerAnimated:YES];
                                                 });
                                             }
                                         }];
    
    
}

- (void)feachData{
    MJWeakSelf;
    [self.apiHelper offlineStoreCommonWithOrder_id:_order_id
                                        completion:^(BOOL isSuccess, NSString *message, id result) {
                                            if (isSuccess) {
                                                weakSelf.dataModel = result;
                                            }else{
                                                [MBProgressHUD showSuccess:message toView:self.view];
                                            }
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

-(void)uploadImgPingZhengMethod{
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


- (void)subViewSetting{
    self.shopInvirmentStarView = [[RatingBar alloc] initWithFrame:CGRectMake(40,0, 130, 29)];
    self.shopInvirmentStarView.viewColor = [UIColor clearColor];
    self.shopInvirmentStarView.starNum = ^(int starNum) {};
    self.shopInvirmentStarView.starNumber = 5;
    [self.shopInvirmentView addSubview:self.shopInvirmentStarView];
    
    self.shopServeceStarView = [[RatingBar alloc] initWithFrame:CGRectMake(40,0, 130, 29)];
    self.shopServeceStarView.viewColor = [UIColor clearColor];
    self.shopServeceStarView.starNum = ^(int starNum) {};
    [self.shopServeceView addSubview:self.shopServeceStarView];
    self.shopServeceStarView.starNumber = 5;
    
    self.submmitBtn.layer.cornerRadius = 4.0f;
    self.submmitBtn.clipsToBounds = YES;
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

- (void)setDataModel:(UBShopDetailModel *)dataModel{
    _dataModel = dataModel;
    self.title = _dataModel.merchant_name;
    [self.shopImgV sd_setImageWithURL:[NSURL URLWithString:_dataModel.logo]
                     placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

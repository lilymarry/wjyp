//
//  SAM_Recommend.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#define TIP_LABEL_HHH (50)

#import "SAM_Recommend.h"
#import "SRecommendingAddBusiness.h"
//三方多图
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"
#import "SAddress_choice.h"
#import "DatePicker_Country.h"
#import "AcceptCompanyVC.h"
#import "SRecommendingBusinessInfo.h"

@interface SAM_Recommend () <ZLPhotoPickerBrowserViewControllerDelegate,UITextViewDelegate>
{
    NSString * modelType;//默认1
    NSString * imageType;//1、2、3、4 5
    UIImage * model_oneImage;
    UIImage * model_twoImage;
    UIImage * model_threeImage;
    UIImage * model_fourImage;
    UIImage * model_logoImage;
    NSString * one_area_id;
    NSString * model_rec_type_id;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *mSeg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secView_HHH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *thirdTitle;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scroll_HHH;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet UITextField *mechant_nameTF;
@property (weak, nonatomic) IBOutlet UITextField *user_nameTF;
@property (weak, nonatomic) IBOutlet UITextField *user_positionTF;
@property (weak, nonatomic) IBOutlet UITextField *user_phone;
@property (weak, nonatomic) IBOutlet UITextView *descTV;

@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;
@property (weak, nonatomic) IBOutlet UIImageView *fourImage;
@property (weak, nonatomic) IBOutlet UIButton *logoBtn;
@property (weak, nonatomic) IBOutlet UITextField *logoTF;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *addressBtn_oneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressBtn_twoTF;
@property (weak, nonatomic) IBOutlet UITextField *rec_typeTF;


@property (weak, nonatomic) IBOutlet UILabel *reasonLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submmitBtn_HHH;

@end

@implementation SAM_Recommend

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _scroll_HHH.constant = 70 + 730 + (ScreenW - 30)/2 * 3 + 50 + 50 - TIP_LABEL_HHH; //+ 30 + (ScreenW - 30)/2 + 20
    _secView_HHH.constant = 100 + (ScreenW - 30)/2 * 3 + 40 + 50  - TIP_LABEL_HHH;
    _thirdView_HHH.constant = 0;// (ScreenW - 30)/2 + 20
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 5;
    
    _descTV.delegate = self;
    
    modelType = @"1";
    _thirdTitle.hidden = YES;
    _thirdView.hidden = YES;
    [_mSeg addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    
    if (_isno == NO && _showModel_isno == YES) {
        if (_left_right == NO) {
            [_mSeg setSelectedSegmentIndex:0];
            _scroll_HHH.constant = 70 + 730 + (ScreenW - 30)/2 * 3 + 50 + 50 - TIP_LABEL_HHH; //+ 30 + (ScreenW - 30)/2 + 20
            _secView_HHH.constant = 100 + (ScreenW - 30)/2 * 3 + 40 + 50 - TIP_LABEL_HHH;
            _thirdView_HHH.constant = 0;// (ScreenW - 30)/2 + 20
            _thirdTitle.hidden = YES;
            _thirdView.hidden = YES;
            modelType = @"1";
        } else {
            [_mSeg setSelectedSegmentIndex:1];
            _scroll_HHH.constant = 70 + 730 + (ScreenW - 30)/2 * 3 + 50 + 30 + (ScreenW - 30)/2 + 20 + 50 - TIP_LABEL_HHH;
            _secView_HHH.constant = 100 + (ScreenW - 30)/2 * 3 + 40 + 50 - TIP_LABEL_HHH;
            _thirdView_HHH.constant = (ScreenW - 30)/2 + 20;
            _thirdTitle.hidden = NO;
            _thirdView.hidden = NO;
            modelType = @"2";
        }
        _mSeg.userInteractionEnabled = NO;
        if (_isno == NO && _showModel_isno == YES) {
            _mechant_nameTF.userInteractionEnabled = NO;
            _rec_typeTF.userInteractionEnabled = NO;
            _user_nameTF.userInteractionEnabled = NO;
            _user_positionTF.userInteractionEnabled = NO;
            _user_phone.userInteractionEnabled = NO;
            _rec_typeTF.userInteractionEnabled = NO;
            _rec_typeTF.userInteractionEnabled = NO;
            _rec_typeTF.userInteractionEnabled = NO;
            _rec_typeTF.userInteractionEnabled = NO;
            _descTV.userInteractionEnabled = NO;
            _submmitBtn_HHH.constant = 0;
        }
        

        SRecommendingBusinessInfo * infor = [[SRecommendingBusinessInfo alloc] init];
        infor.recommending_id = _recommending_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sRecommendingBusinessInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SRecommendingBusinessInfo * infor = (SRecommendingBusinessInfo *)data;
                _mechant_nameTF.text = infor.data.merchant_name;
                [_logoImage sd_setImageWithURL:[NSURL URLWithString:infor.data.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                _logoTF.text = @" ";
                _rec_typeTF.text = infor.data.rec_type_id;
                _user_nameTF.text = infor.data.user_name;
                _user_positionTF.text = infor.data.user_position;
                _user_phone.text = infor.data.user_phone;
                _addressBtn_oneTF.text = infor.data.city;
                _addressBtn_twoTF.text = infor.data.street;
                _descTV.text = infor.data.desc;
                _descTV.textColor = WordColor;
                [_oneImage sd_setImageWithURL:[NSURL URLWithString:infor.data.license] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                [_twoImage sd_setImageWithURL:[NSURL URLWithString:infor.data.facade] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                [_threeImage sd_setImageWithURL:[NSURL URLWithString:infor.data.identity] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                [_fourImage sd_setImageWithURL:[NSURL URLWithString:infor.data.apply] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                if ([_status isEqualToString:@"2"] || [_status isEqualToString:@"3"] || [_status isEqualToString:@"5"]) {
//                    [MBProgressHUD showError:infor.data.reason toView:self.view];
                    _reasonLab.text = infor.data.reason;
                    
                    _scroll_HHH.constant = 70 + 730 + (ScreenW - 30)/2 * 3 + 50 + 50 - TIP_LABEL_HHH + 100; //+ 30 + (ScreenW - 30)/2 + 20
                    _secView_HHH.constant = 100 + (ScreenW - 30)/2 * 3 + 40 + 50 - TIP_LABEL_HHH + 100;
                }
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
- (void)selected:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        _scroll_HHH.constant = 70 + 730 + (ScreenW - 30)/2 * 3 + 50 + 50 - TIP_LABEL_HHH; //+ 30 + (ScreenW - 30)/2 + 20
        _secView_HHH.constant = 100 + (ScreenW - 30)/2 * 3 + 40 + 50 - TIP_LABEL_HHH;
        _thirdView_HHH.constant = 0;// (ScreenW - 30)/2 + 20
        _thirdTitle.hidden = YES;
        _thirdView.hidden = YES;
        modelType = @"1";
        
    } else {
        _scroll_HHH.constant = 70 + 730 + (ScreenW - 30)/2 * 3 + 50 + 30 + (ScreenW - 30)/2 + 20 + 50 - TIP_LABEL_HHH;
        _secView_HHH.constant = 100 + (ScreenW - 30)/2 * 3 + 40 + 50 - TIP_LABEL_HHH;
        _thirdView_HHH.constant = (ScreenW - 30)/2 + 20;
        _thirdTitle.hidden = NO;
        _thirdView.hidden = NO;
        modelType = @"2";
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_isno == NO) {
        self.title = @"联盟商家推荐";
    } else {
        self.title = @"申请填写";
    }
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
- (IBAction)addressBtn:(UIButton *)sender {
    if (_isno == NO && _showModel_isno == YES) {
        return;
    }
    if (sender.tag == 0) {
        [self thisCity];
    } else {
        [self thisStreet];
    }
}
- (void)thisCity {
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view addSubview:view];
    
    DatePicker_Country * pick = [[DatePicker_Country alloc] init];
    pick.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pick animated:YES completion:nil];
    
    pick.DatePicker_Country_Back = ^{
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
    pick.DatePicker_Country_Submit = ^(NSString *one, NSString *two, NSString *three, NSString *one_id, NSString *two_id, NSString *three_id) {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        
        _addressBtn_oneTF.text = [NSString stringWithFormat:@"%@%@%@",one,two,three];
        _addressBtn_twoTF.text = @"";
        one_area_id = three_id;
    };
}
- (void)thisStreet {
    SAddress_choice * choiceAdd = [[SAddress_choice alloc] init];
    if ([_addressBtn_oneTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请先选择省份" toView:self.view];
        return;
    }
    choiceAdd.area_id = one_area_id;
    [self.navigationController pushViewController:choiceAdd animated:YES];
    choiceAdd.SAddress_choice_choice = ^(NSString *thisName, NSString *this_id) {
        _addressBtn_twoTF.text = thisName;

    };
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请填写申请商家的情况"]) {
        _descTV.textColor = WordColor;
        _descTV.text = @"";
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        _descTV.textColor = WordColor_30;
        _descTV.text = @"请填写申请商家的情况";
    }
    return YES;
}
- (IBAction)logoBtn:(UIButton *)sender {
    if (_isno == NO && _showModel_isno == YES) {
        return;
    }
    imageType = @"5";
    [self choiceImageView];
}
- (IBAction)rec_typeBtn:(UIButton *)sender {
    if (_isno == NO && _showModel_isno == YES) {
        return;
    }
    AcceptCompanyVC * com = [[AcceptCompanyVC alloc] init];
    com.type = @"2";
    [self.navigationController pushViewController:com animated:YES];
    com.AcceptCompanyVC_delivery = ^(NSString *delivery_id, NSString *delivery_name) {
        model_rec_type_id = delivery_id;
        _rec_typeTF.text = delivery_name;
    };
}
- (IBAction)oneBtn:(UIButton *)sender {
    if (_isno == NO && _showModel_isno == YES) {
        return;
    }
    imageType = @"1";
    [self choiceImageView];
}
- (IBAction)twoBtn:(UIButton *)sender {
    if (_isno == NO && _showModel_isno == YES) {
        return;
    }
    imageType = @"2";
    [self choiceImageView];
}
- (IBAction)threeBtn:(UIButton *)sender {
    if (_isno == NO && _showModel_isno == YES) {
        return;
    }
    imageType = @"3";
    [self choiceImageView];
}
- (IBAction)fourBtn:(UIButton *)sender {
    if (_isno == NO && _showModel_isno == YES) {
        return;
    }
    imageType = @"4";
    [self choiceImageView];
}
- (void)choiceImageView {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 1;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.photoStatus = PickerPhotoStatusPhotos;
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.isShowCamera = YES;
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
//        NSLog(@"sss:%@",status.mutableCopy);
        
        for (int i = 0; i < status.count; i++) {
            id assets = status[i];
            if ([assets isKindOfClass:[ZLPhotoAssets class]]) {
                ZLPhotoAssets * ddd = (ZLPhotoAssets *)assets;
                if ([imageType isEqualToString:@"1"]) {
                    _oneImage.image = ddd.originImage;
                    model_oneImage = ddd.originImage;
                }
                if ([imageType isEqualToString:@"2"]) {
                    _twoImage.image = ddd.originImage;
                    model_twoImage = ddd.originImage;
                }
                if ([imageType isEqualToString:@"3"]) {
                    _threeImage.image = ddd.originImage;
                    model_threeImage = ddd.originImage;
                }
                if ([imageType isEqualToString:@"4"]) {
                    _fourImage.image = ddd.originImage;
                    model_fourImage = ddd.originImage;
                }
                if ([imageType isEqualToString:@"5"]) {
                    _logoImage.image = ddd.originImage;
                    _logoTF.text = @" ";
                    model_logoImage = ddd.originImage;
                }
            } else {
                ZLCamera * ddd = (ZLCamera *)assets;
                if ([imageType isEqualToString:@"1"]) {
                    _oneImage.image = ddd.photoImage;
                    model_oneImage = ddd.photoImage;
                }
                if ([imageType isEqualToString:@"2"]) {
                    _twoImage.image = ddd.photoImage;
                    model_twoImage = ddd.photoImage;
                }
                if ([imageType isEqualToString:@"3"]) {
                    _threeImage.image = ddd.photoImage;
                    model_threeImage = ddd.photoImage;
                }
                if ([imageType isEqualToString:@"4"]) {
                    _fourImage.image = ddd.photoImage;
                    model_fourImage = ddd.photoImage;
                }
                if ([imageType isEqualToString:@"5"]) {
                    _logoImage.image = ddd.photoImage;
                    _logoTF.text = @" ";
                    model_logoImage = ddd.photoImage;
                }
            }
        }
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
- (IBAction)submitBtn:(UIButton *)sender {
    NSMutableDictionary * pic = [[NSMutableDictionary alloc] init];
    SRecommendingAddBusiness * add = [[SRecommendingAddBusiness alloc] init];
    if ([_mechant_nameTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入商家名称" toView:self.view];
        return;
    }
    add.mechant_name = _mechant_nameTF.text;
    
    if (![_status isEqualToString:@"3"]) {
        if (model_logoImage == nil) {
            [MBProgressHUD showError:@"请上传门头照片" toView:self.view];
            return;
        }
        [pic setValue:[self compressImage2Quality:model_logoImage toByte:102400] forKey:@"logo"];
    } else {
        //审核拒绝
        if (model_logoImage != nil) {
            [pic setValue:[self compressImage2Quality:model_logoImage toByte:102400] forKey:@"logo"];
        }
    }
    
    if (model_rec_type_id == nil) {
        [MBProgressHUD showError:@"请选择类别" toView:self.view];
        return;
    }
    add.rec_type_id = model_rec_type_id;
    if ([_user_nameTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入联系人" toView:self.view];
        return;
    }
    add.user_name = _user_nameTF.text;
    if ([_user_positionTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入职位" toView:self.view];
        return;
    }
    add.user_position = _user_positionTF.text;
    if ([_user_phone.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入联系电话" toView:self.view];
        return;
    }
    add.user_phone = _user_phone.text;
    if ([_addressBtn_oneTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择所在地区" toView:self.view];
        return;
    }
    add.city  = _addressBtn_oneTF.text;
    if ([_addressBtn_twoTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择所在街道" toView:self.view];
        return;
    }
    add.street = _addressBtn_twoTF.text;
    if ([_descTV.text isEqualToString:@"请填写申请企业的情况"]) {
        [MBProgressHUD showError:@"请填写申请企业的情况" toView:self.view];
        return;
    }
    add.desc = _descTV.text;
    
    if (![_status isEqualToString:@"3"]) {
        if (model_oneImage == nil) {
            [MBProgressHUD showError:@"请上传营业执照" toView:self.view];
            return;
        }
        [pic setValue:[self compressImage2Quality:model_oneImage toByte:102400] forKey:@"license"];
    } else {
        //审核拒绝
        if (model_oneImage != nil) {
            [pic setValue:[self compressImage2Quality:model_oneImage toByte:102400] forKey:@"license"];
        }
    }
    if (![_status isEqualToString:@"3"]) {
        if (model_twoImage == nil) {
            [MBProgressHUD showError:@"请上传身份证正面" toView:self.view];
            return;
        }
        [pic setValue:[self compressImage2Quality:model_twoImage toByte:102400] forKey:@"facade"];
    } else {
        //审核拒绝
        if (model_twoImage != nil) {
            [pic setValue:[self compressImage2Quality:model_twoImage toByte:102400] forKey:@"facade"];
        }
    }
    if (![_status isEqualToString:@"3"]) {
        if (model_threeImage == nil) {
            [MBProgressHUD showError:@"请上传身份证反面" toView:self.view];
            return;
        }
        [pic setValue:[self compressImage2Quality:model_threeImage toByte:102400] forKey:@"identity"];
    } else {
        //审核拒绝
        if (model_threeImage != nil) {
            [pic setValue:[self compressImage2Quality:model_threeImage toByte:102400] forKey:@"identity"];
        }
    }
    if (![_status isEqualToString:@"3"]) {
        if ([modelType isEqualToString:@"2"] && model_fourImage == nil) {
            [MBProgressHUD showError:@"请上传申请说明" toView:self.view];
            return;
        }
        if ([modelType isEqualToString:@"2"]) {
            [pic setValue:[self compressImage2Quality:model_fourImage toByte:102400] forKey:@"apply"];
        }
    } else {
        //审核拒绝
        if (model_fourImage != nil) {
            if ([modelType isEqualToString:@"2"]) {
                [pic setValue:[self compressImage2Quality:model_fourImage toByte:102400] forKey:@"apply"];
            }
        }
    }
    add.pic = pic;
    add.type = modelType;
    [MBProgressHUD showMessage:nil toView:self.view];
    [add sRecommendingAddBusinessSuccess:^(NSString *code, NSString *message) {
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

@end

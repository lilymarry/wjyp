//
//  SRealNameAuth.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRealNameAuth.h"
#import "SPhotoVC.h"
#import "DatePicker_Country.h"
#import "SAddress_choice.h"
//三方多图
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"
#import "UIButton+WebCache.h"
#import "TimeDatePick.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import "SUserPersonalAuth.h"
#import "SUserCompAuth.h"
#import "SUserPersonalAuthInfo.h"
#import "SUserUserInfo.h"

@interface SRealNameAuth () <BMKGeoCodeSearchDelegate,ZLPhotoPickerBrowserViewControllerDelegate,UITextFieldDelegate>
{

    NSString * one_province;//省
    NSString * one_city;//市
    NSString * one_area;//区
    NSString * one_street;//街道
    NSString * one_province_id;//省id
    NSString * one_city_id;//市id
    NSString * one_area_id;//区县id
    NSString * one_street_id;//街道id
    
    NSString * one_model_lng;//经度
    NSString * one_model_lat;//纬度
    
    NSString * two_province;//省
    NSString * two_city;//市
    NSString * two_area;//区
    NSString * two_street;//街道
    NSString * two_province_id;//省id
    NSString * two_city_id;//市id
    NSString * two_area_id;//区县id
    NSString * two_street_id;//街道id
    
    NSString * two_model_lng;//经度
    NSString * two_model_lat;//纬度
    
    BMKGeoCodeSearch * _searcher;
    
    BOOL left_right;//默认左
    
    UIImage * oneImage_first;
    NSString * oneImage_first_url;
    UIImage * oneImage_secend;
    NSString * oneImage_secend_url;
    UIImage * twoImage_first;
    NSString * twoImage_first_url;
    
    NSString * timeSp_one_start;
    NSString * timeSp_one_end;
    NSString * timeSp_two_start;
    NSString * timeSp_two_end;
    
    BOOL left_editISNO;//是否可编辑 YES不可编辑
    BOOL right_editISNO;//是否可编辑 YES不可编辑
    
    NSString * auth_status;//"0",//认证状态 0未认证 1认证中 2已认证 3拒绝
    NSString * auth_desc;
    NSString * comp_auth_status;//""//企业认证拒绝原因
    NSString * comp_desc;
}
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ScrollView_HHH;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sgConBtn;
@property (strong, nonatomic) IBOutlet UILabel *image_Title_first;
@property (strong, nonatomic) IBOutlet UILabel *Image_Title;
@property (strong, nonatomic) IBOutlet UIView *mOneView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mOneView_HHH;
@property (strong, nonatomic) IBOutlet UIImageView *one_leftImage;
@property (strong, nonatomic) IBOutlet UIImageView *one_rightImage;
@property (strong, nonatomic) IBOutlet UIButton *one_rightBtn;
@property (strong, nonatomic) IBOutlet UIView *mTwoView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mTwoView_HHH;
@property (strong, nonatomic) IBOutlet UIImageView *two_leftImage;
@property (strong, nonatomic) IBOutlet UIImageView *two_rightImage;
@property (strong, nonatomic) IBOutlet UIButton *two_rightBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *sexTF;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UITextField *oneCityTF;
@property (strong, nonatomic) IBOutlet UITextField *oneStreetTF;

@property (strong, nonatomic) IBOutlet UITextField *companyTF;
@property (strong, nonatomic) IBOutlet UITextField *comCodeTF;
@property (strong, nonatomic) IBOutlet UITextField *startTF;
@property (strong, nonatomic) IBOutlet UITextField *start_oneTF;
@property (strong, nonatomic) IBOutlet UITextField *endTF;
@property (strong, nonatomic) IBOutlet UITextField *end_oneTF;
@property (strong, nonatomic) IBOutlet UITextField *twoCityTF;
@property (strong, nonatomic) IBOutlet UITextField *twoStreetTF;
@property (strong, nonatomic) IBOutlet UILabel *introduction;
@end

@implementation SRealNameAuth

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_sgConBtn addTarget:self action:@selector(sgConBtnClick:) forControlEvents:UIControlEventValueChanged];
    _nameTF.delegate = self;
    _codeTF.delegate = self;
    _companyTF.delegate = self;
    _comCodeTF.delegate = self;
    
    _mOneView.hidden = NO;
    _mOneView_HHH.constant = 350;
    _mTwoView.hidden = YES;
    _mTwoView_HHH.constant = 0;
    _image_Title_first.text = @"上传身份证照";
    _Image_Title.text = @"对焦使身份证上面字体和照片清晰可见";
    _two_leftImage.hidden = NO;
    _two_rightImage.hidden = NO;
    _two_rightBtn.hidden = NO;
    _ScrollView_HHH.constant = 90 + 350 + 40 + 100 + (ScreenW - 30)/2 * 2 + 20 + 50 + 10 + 50;
    _one_leftImage.image = [UIImage imageNamed:@"认证图1-1"];
    _two_leftImage.image = [UIImage imageNamed:@"认证图1-2"];
    
    
    SUserUserInfo * userInfo = [[SUserUserInfo alloc] init];
    [userInfo sUserUserInfoSuccess:^(NSString *code, NSString *message, id data) {
        SUserUserInfo * userInfo = (SUserUserInfo *)data;
        if ([userInfo.data.auth_status integerValue] != 2) {
            _topBtn.hidden = NO;
        } else {
            _topBtn.hidden = YES;
        }
    } andFailure:^(NSError *error) {
    }];
    
    
    SUserPersonalAuthInfo * infor = [[SUserPersonalAuthInfo alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [infor sUserPersonalAuthInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SUserPersonalAuthInfo * infor = (SUserPersonalAuthInfo *)data;
        auth_status = infor.data.auth_status;
        auth_desc = infor.data.auth_desc;
        if ([auth_status isEqualToString:@"0"]) {
            _introduction.text = @"提示：认证企业资质后，此账号个人信息认证不做唯一性认证限制";
        } else if ([auth_status isEqualToString:@"1"]) {
            _introduction.text = @"提示：认证中";
        } else if ([auth_status isEqualToString:@"2"]) {
            _introduction.text = @"提示：认证通过";
        } else if ([auth_status isEqualToString:@"3"]) {
            _introduction.text = [NSString stringWithFormat:@"提示：%@",auth_desc];
        }
        if ([infor.data.auth_status isEqualToString:@"0"]) {
            one_province = @"";
            one_city = @"";
            one_area = @"";
            one_street = @"";
            one_province_id = @"";
            one_city_id = @"";
            one_area_id = @"";
            one_street_id = @"";
            one_model_lng = @"";
            one_model_lat = @"";
            
            timeSp_one_start = @"";
            timeSp_one_end = @"";
            
            oneImage_first_url = @"";
            oneImage_secend_url = @"";
           

        } else {
            one_province = infor.data.auth_province_name;
            one_city = infor.data.auth_city_name;
            one_area = infor.data.auth_area_name;
            one_street = infor.data.auth_street_name;
            one_province_id = infor.data.auth_province_id;
            one_city_id = infor.data.auth_city_id;
            one_area_id = infor.data.auth_area_id;
            one_street_id = infor.data.auth_street_id;
            
            _nameTF.text = infor.data.real_name;
            _sexTF.text = [infor.data.sex isEqualToString:@"1"] ? @"男" : @"女";
            _codeTF.text = infor.data.id_card_num;
            _oneCityTF.text = [NSString stringWithFormat:@"%@%@%@",infor.data.auth_province_name,infor.data.auth_city_name,infor.data.auth_area_name];
            _oneStreetTF.text = infor.data.auth_street_name;
            //开始云检索获取经纬度
            [self startSearch];
            
            timeSp_one_start = infor.data.id_card_start_time;
            _start_oneTF.text = infor.data.id_card_start_date;
            timeSp_one_end = infor.data.id_card_end_time;
            _end_oneTF.text = [infor.data.id_card_end_date isEqualToString:@"0"] ? @"永久" : infor.data.id_card_end_date;
        
            oneImage_first_url = infor.data.positive_id_card;
            oneImage_secend_url = infor.data.back_id_card;
            [_one_rightImage sd_setImageWithURL:[NSURL URLWithString:oneImage_first_url] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            [_two_rightImage sd_setImageWithURL:[NSURL URLWithString:oneImage_secend_url] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            
            if ([infor.data.auth_status isEqualToString:@"1"]||[infor.data.auth_status isEqualToString:@"2"]) {
                _nameTF.userInteractionEnabled = NO;
                _sexTF.userInteractionEnabled = NO;
                _codeTF.userInteractionEnabled = NO;
                left_editISNO = YES;
                _submitBtn.hidden = YES;
            } else {
                _submitBtn.hidden = NO;
                if ([infor.data.auth_status isEqualToString:@"3"]) {
                    [_submitBtn setTitle:@"重新提交" forState:UIControlStateNormal];
                }
            }
            
        }
        
        comp_auth_status = infor.data.comp_auth_status;
        comp_desc = infor.data.comp_desc;
        if ([infor.data.comp_auth_status isEqualToString:@"0"]) {
            two_province = @"";
            two_city = @"";
            two_area = @"";
            two_street = @"";
            two_province_id = @"";
            two_city_id = @"";
            two_area_id = @"";
            two_street_id = @"";
            two_model_lng = @"";
            two_model_lat = @"";
            
            timeSp_two_start = @"";
            timeSp_two_end = @"";
            
            twoImage_first_url = @"";
            
        } else {
            two_province = infor.data.comp_province_name;
            two_city = infor.data.comp_city_name;
            two_area = infor.data.comp_area_name;
            two_street = infor.data.comp_street_name;
            two_province_id = infor.data.comp_province_id;
            two_city_id = infor.data.comp_city_id;
            two_area_id = infor.data.comp_area_id;
            two_street_id = infor.data.comp_street_id;
            
            _companyTF.text = infor.data.com_name;
            _comCodeTF.text = infor.data.comp_reg_num;
            _twoCityTF.text = [NSString stringWithFormat:@"%@%@%@",infor.data.comp_province_name,infor.data.comp_city_name,infor.data.comp_area_name];
            _twoStreetTF.text = infor.data.comp_street_name;
            
            timeSp_two_start = infor.data.comp_start_time;
            _startTF.text = infor.data.comp_start_date;
            timeSp_two_end = infor.data.comp_end_time;
            _endTF.text = [infor.data.comp_end_date isEqualToString:@"0"] ? @"永久" : infor.data.comp_end_date;
            
            twoImage_first_url = infor.data.comp_business_license;

            if ([infor.data.comp_auth_status isEqualToString:@"1"]||[infor.data.comp_auth_status isEqualToString:@"2"]) {
                _companyTF.userInteractionEnabled = NO;
                _comCodeTF.userInteractionEnabled = NO;
                right_editISNO = YES;
            }
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
    
    self.title = @"实名认证";
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
- (void)sgConBtnClick:(UISegmentedControl *)btn {
    
    [_nameTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_companyTF resignFirstResponder];
    [_comCodeTF resignFirstResponder];
    if (btn.selectedSegmentIndex == 0) {
        _one_leftImage.image = [UIImage imageNamed:@"认证图1-1"];
        _two_leftImage.image = [UIImage imageNamed:@"认证图1-2"];
        left_right = NO;
        if (oneImage_first == nil && [oneImage_first_url isEqualToString:@""]) {
            _one_rightImage.image = [UIImage imageNamed:@"认证图2"];
        } else {
            if ([oneImage_first_url isEqualToString:@""]) {
                _one_rightImage.image = oneImage_first;
            } else {
                [_one_rightImage sd_setImageWithURL:[NSURL URLWithString:oneImage_first_url] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            }
        }
        if (oneImage_secend == nil && [oneImage_secend_url isEqualToString:@""]) {
            _two_rightImage.image = [UIImage imageNamed:@"认证图3"];
        } else {
            if ([oneImage_secend_url isEqualToString:@""]) {
                _two_rightImage.image = oneImage_secend;
            } else {
                [_two_rightImage sd_setImageWithURL:[NSURL URLWithString:oneImage_secend_url] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            }
        }
        
        _mOneView.hidden = NO;
        _mOneView_HHH.constant = 350;
        _mTwoView.hidden = YES;
        _mTwoView_HHH.constant = 0;
        _image_Title_first.text = @"上传身份证照";
        _Image_Title.text = @"对焦使身份证上面字体和照片清晰可见";
        _two_leftImage.hidden = NO;
        _two_rightImage.hidden = NO;
        _two_rightBtn.hidden = NO;
        _ScrollView_HHH.constant = 90 + 350 + 40 + 100 + (ScreenW - 30)/2 * 2 + 20 + 50 + 10 + 50;
        if ([auth_status isEqualToString:@"0"]) {
            _introduction.text = @"提示：认证企业资质后，此账号个人信息认证不做唯一性认证限制";
            _submitBtn.hidden = NO;
        } else if ([auth_status isEqualToString:@"1"]) {
            _introduction.text = @"提示：认证中";
            _submitBtn.hidden = YES;
        } else if ([auth_status isEqualToString:@"2"]) {
            _introduction.text = @"提示：认证通过";
            _submitBtn.hidden = YES;
        } else if ([auth_status isEqualToString:@"3"]) {
            _introduction.text = [NSString stringWithFormat:@"提示：%@",auth_desc];
            _submitBtn.hidden = NO;
            [_submitBtn setTitle:@"重新提交" forState:UIControlStateNormal];
        }
        if (![one_model_lng isEqualToString:@""]) {
            //开始云检索获取经纬度
            [self startSearch];
        }
    } else {
        _one_leftImage.image = [UIImage imageNamed:@"认证图1-3"];
        left_right = YES;
        if (twoImage_first == nil && [twoImage_first_url isEqualToString:@""]) {
            _one_rightImage.image = [UIImage imageNamed:@"认证图4"];
        } else {
            if ([twoImage_first_url isEqualToString:@""]) {
                _one_rightImage.image = twoImage_first;
            } else {
                [_one_rightImage sd_setImageWithURL:[NSURL URLWithString:twoImage_first_url] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            }
        }
        _mOneView.hidden = YES;
        _mOneView_HHH.constant = 0;
        _mTwoView.hidden = NO;
        _mTwoView_HHH.constant = 300;
        _image_Title_first.text = @"上传营业执照";
        _Image_Title.text = @"对焦使营业执照上面字体和照片清晰可见";
        _two_leftImage.hidden = YES;
        _two_rightImage.hidden = YES;
        _two_rightBtn.hidden = YES;
        _ScrollView_HHH.constant = 90 + 300 + 40 + 100 + (ScreenW - 30)/2 + 10 + 50 + 10 + 50;
        if ([comp_auth_status isEqualToString:@"0"]) {
            _introduction.text = @"";
            _submitBtn.hidden = NO;
        } else if ([comp_auth_status isEqualToString:@"1"]) {
            _introduction.text = @"提示：认证中";
            _submitBtn.hidden = YES;
        } else if ([comp_auth_status isEqualToString:@"2"]) {
            _introduction.text = @"提示：认证通过";
            _submitBtn.hidden = YES;
        } else if ([comp_auth_status isEqualToString:@"3"]) {
            _introduction.text = [NSString stringWithFormat:@"提示：%@",comp_desc];
            _submitBtn.hidden = NO;
            [_submitBtn setTitle:@"重新提交" forState:UIControlStateNormal];
        }
        if (![two_model_lng isEqualToString:@""]) {
            //开始云检索获取经纬度
            [self startSearch];
        }
    }
}
- (IBAction)choiceSex:(UIButton *)sender {
    [_nameTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_companyTF resignFirstResponder];
    [_comCodeTF resignFirstResponder];
    if (left_editISNO == YES) {
        //审核中、已通过不可编辑
        return;
    }
    
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, NAVIGATION_BAR_HEIGHT)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view addSubview:view];
    
    SPhotoVC * phone = [[SPhotoVC alloc] init];
    phone.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:phone animated:YES completion:nil];
    [phone.photoBtn setTitle:@"女" forState:UIControlStateNormal];
    [phone.choiceBtn setTitle:@"男" forState:UIControlStateNormal];
    //默认返回
    phone.SPhotoVC = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
    
    //女
    phone.SPhotoVC_Photo = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        _sexTF.text = @"女";
    };
    //男
    phone.SPhotoVC_Choicek = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        _sexTF.text = @"男";

    };
}
- (IBAction)choiceCity:(UIButton *)sender {
    [_nameTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_companyTF resignFirstResponder];
    [_comCodeTF resignFirstResponder];
    if (sender.tag == 0) {
        if (left_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    } else {
        if (right_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    }
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
        
        if (sender.tag == 0) {
            one_province = one;
            one_city = two;
            one_area = three;
            one_province_id = one_id;
            one_city_id = two_id;
            one_area_id = three_id;
            
            one_street = @"";
            one_street_id = @"";
            _oneStreetTF.text = @"";
            _oneCityTF.text = [NSString stringWithFormat:@"%@%@%@",one,two,three];
        } else {
            two_province = one;
            two_city = two;
            two_area = three;
            two_province_id = one_id;
            two_city_id = two_id;
            two_area_id = three_id;
            
            two_street = @"";
            two_street_id = @"";
            _twoStreetTF.text = @"";
            _twoCityTF.text = [NSString stringWithFormat:@"%@%@%@",one,two,three];
        }

    };
}
- (IBAction)choiceStreet:(UIButton *)sender {
    [_nameTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_companyTF resignFirstResponder];
    [_comCodeTF resignFirstResponder];
    if (sender.tag == 0) {
        if (left_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    } else {
        if (right_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    }
    SAddress_choice * choiceAdd = [[SAddress_choice alloc] init];
    if (sender.tag == 0) {
        if ([one_area_id isEqualToString:@""]) {
            [MBProgressHUD showError:@"请先选择省份" toView:self.view];
            return;
        }
        choiceAdd.area_id = one_area_id;
    } else {
        if ([two_area_id isEqualToString:@""]) {
            [MBProgressHUD showError:@"请先选择省份" toView:self.view];
            return;
        }
        choiceAdd.area_id = two_area_id;
    }
    
    [self.navigationController pushViewController:choiceAdd animated:YES];
    choiceAdd.SAddress_choice_choice = ^(NSString *thisName, NSString *this_id) {
        if (sender.tag == 0) {
            _oneStreetTF.text = thisName;
            one_street = thisName;
            one_street_id = this_id;
        } else {
            _twoStreetTF.text = thisName;
            two_street = thisName;
            two_street_id = this_id;
        }
        
        //开始云检索获取经纬度
        [self startSearch];
    };
}
- (void)startSearch {
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    if (left_right == NO) {
        geoCodeSearchOption.city= one_city;
        geoCodeSearchOption.address = [NSString stringWithFormat:@"%@%@",one_area,one_street];
    } else {
        geoCodeSearchOption.city= two_city;
        geoCodeSearchOption.address = [NSString stringWithFormat:@"%@%@",two_area,two_street];
    }
    
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    _searcher.delegate = nil;
}
//实现Deleage处理回调结果
//接收正向编码结果

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
        NSLog(@"lng:%.6f",result.location.longitude);
        NSLog(@"lat:%.6f",result.location.latitude);
        if (left_right == NO) {
            one_model_lng = [NSString stringWithFormat:@"lng:%.6f",result.location.longitude];
            one_model_lat = [NSString stringWithFormat:@"lat:%.6f",result.location.latitude];
        } else {
            two_model_lng = [NSString stringWithFormat:@"lng:%.6f",result.location.longitude];
            two_model_lat = [NSString stringWithFormat:@"lat:%.6f",result.location.latitude];
        }
        
    }
    else {
        [MBProgressHUD showError:@"抱歉，未找到结果" toView:self.view];
    }
}
- (IBAction)startDay:(UIButton *)sender {
    [_nameTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_companyTF resignFirstResponder];
    [_comCodeTF resignFirstResponder];
    if (left_right == NO) {
        if (left_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    } else {
        if (right_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    }
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view addSubview:view];
    
    
    TimeDatePick * pick = [[TimeDatePick alloc] init];
    pick.type = @"1";
    pick.thisHour = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    pick.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pick animated:YES completion:nil];
    pick.datePicker.frame = CGRectMake(0, ScreenH - 216, ScreenW, 216);
    pick.foreverBtn.hidden = YES;
    pick.foreverBtn_HHH.constant = 0;
    [pick.subMitBtn setTitle:@"完成" forState:UIControlStateNormal];
    pick.TimeDatePickBack = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
    pick.TimeDatePickSubmit_YMD = ^(NSString * year, NSString * month, NSString * day, NSString * hour, NSString * minute) {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        
        
        NSString* timeStr = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];//2011-01-26 17:40:50
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
        NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
        NSLog(@"timeSp:%@",timeSp); //时间戳的值
        
        if (left_right == NO) {
            timeSp_one_start = timeSp;
            _start_oneTF.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];

        } else {
            timeSp_two_start = timeSp;
            _startTF.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];

        }
    };
}
- (IBAction)endDay:(UIButton *)sender {
    [_nameTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_companyTF resignFirstResponder];
    [_comCodeTF resignFirstResponder];
    if (left_right == NO) {
        if (left_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    } else {
        if (right_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    }
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view addSubview:view];
    
    
    TimeDatePick * pick = [[TimeDatePick alloc] init];
    pick.type = @"1";
    pick.thisHour = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"];
    pick.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pick animated:YES completion:nil];
    [pick.subMitBtn setTitle:@"完成" forState:UIControlStateNormal];

    pick.TimeDatePickBack = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
    pick.TimeDatePickSubmit_YMD = ^(NSString * year, NSString * month, NSString * day, NSString * hour, NSString * minute) {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        
        
        NSString* timeStr = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];//2011-01-26 17:40:50
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
        NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
        NSLog(@"timeSp:%@",timeSp); //时间戳的值
        
        if (left_right == NO) {
            _end_oneTF.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            timeSp_one_end = timeSp;
        } else {
            _endTF.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            timeSp_two_end = timeSp;
        }
    };
    pick.TimeDatePick_foreverBtn = ^{
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        if (left_right == NO) {
            _end_oneTF.text = @"永久";
            timeSp_one_end = @"0";
        } else {
            _endTF.text = @"永久";
            timeSp_two_end = @"0";
        }
    };
}
- (IBAction)oneImageBtn:(UIButton *)sender {
    [_nameTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_companyTF resignFirstResponder];
    [_comCodeTF resignFirstResponder];
    if (left_right == NO) {
        if (left_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    } else {
        if (right_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    }
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 1;
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
                if (left_right == NO) {
                    oneImage_first_url = @"";
                    oneImage_first = [self compressImage2Quality:ddd.originImage toByte:102400];
                    oneImage_first = ddd.originImage;
                } else {
                    twoImage_first_url = @"";
                    twoImage_first = [self compressImage2Quality:ddd.originImage toByte:102400];
                }
                _one_rightImage.image = ddd.originImage;
            } else {
                ZLCamera * ddd = (ZLCamera *)assets;
                if (left_right == NO) {
                    oneImage_first_url = @"";
                    oneImage_first = [self compressImage2Quality:ddd.photoImage toByte:102400];
                } else {
                    twoImage_first_url = @"";
                    twoImage_first = [self compressImage2Quality:ddd.photoImage toByte:102400];
                }
                _one_rightImage.image =  ddd.photoImage;
            }
        }
    };
    [pickerVc showPickerVc:self];
}
- (IBAction)twoImageBtn:(UIButton *)sender {
    [_nameTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_companyTF resignFirstResponder];
    [_comCodeTF resignFirstResponder];
    if (left_right == NO) {
        if (left_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    } else {
        if (right_editISNO == YES) {
            //审核中、已通过不可编辑
            return;
        }
    }
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 1;
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
                oneImage_secend_url = @"";
                oneImage_secend = [self compressImage2Quality:ddd.originImage toByte:102400];
                _two_rightImage.image = ddd.originImage;
            } else {
                ZLCamera * ddd = (ZLCamera *)assets;
                oneImage_secend_url = @"";
                oneImage_secend = [self compressImage2Quality:ddd.photoImage toByte:102400];
                _two_rightImage.image = ddd.photoImage;
            }
        }
    };
    [pickerVc showPickerVc:self];
}
- (UIImage *)compressImage2Quality:(UIImage *)image toByte:(NSInteger)maxLength {
    
    
    //修改为不压缩 图片看不清 by_fxg
    return image;
    
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
#pragma mark - 提交
- (void)submitBtnClick {
    [_nameTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_companyTF resignFirstResponder];
    [_comCodeTF resignFirstResponder];
    if (left_right == NO) {
        SUserPersonalAuth * auth = [[SUserPersonalAuth alloc] init];
        if ([_nameTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请填写真实姓名" toView:self.view];
            return;
        }
        auth.real_name = _nameTF.text;
        if ([_sexTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择性别" toView:self.view];
            return;
        }
        auth.sex = [_sexTF.text isEqualToString:@"男"] ? @"1" : @"2";
        if ([_codeTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请填写身份证号" toView:self.view];
            return;
        }
        auth.id_card_num = _codeTF.text;
        if ([timeSp_one_start isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择身份证有效期开始时间" toView:self.view];
            return;
        }
        auth.card_start_time = timeSp_one_start;
        if ([timeSp_one_end isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择身份证有效期结束时间" toView:self.view];
            return;
        }
        auth.card_end_time = timeSp_one_end;
        if ([one_province_id isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择所在地区" toView:self.view];
            return;
        }
        auth.auth_province_id = one_province_id;
        auth.auth_city_id = one_city_id;
        auth.auth_area_id = one_area_id;
        if ([one_street_id isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择所在街道" toView:self.view];
            return;
        }
        auth.auth_street_id = one_street_id;
        if (![auth_status isEqualToString:@"3"]) {
            if (oneImage_first == nil) {
                [MBProgressHUD showError:@"请上传身份证正面照片" toView:self.view];
                return;
            }
            auth.positive_id_card = oneImage_first;
            if (oneImage_secend == nil) {
                [MBProgressHUD showError:@"请上传身份证背面照片" toView:self.view];
                return;
            }
            auth.back_id_card = oneImage_secend;
        } else {
            if (oneImage_first != nil) {
                auth.positive_id_card = oneImage_first;
            }
            if (oneImage_secend != nil) {
                auth.back_id_card = oneImage_secend;
            }
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [auth sUserPersonalAuthSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else {
        SUserCompAuth * com = [[SUserCompAuth alloc] init];
        if ([_companyTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请填写企业名称" toView:self.view];
            return;
        }
        com.com_name = _companyTF.text;
        if ([_comCodeTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请填写注册号" toView:self.view];
            return;
        }
        com.comp_reg_num = _comCodeTF.text;
        if ([timeSp_two_start isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择营业开始时间" toView:self.view];
            return;
        }
        com.comp_start_time = timeSp_two_start;
        if ([timeSp_two_end isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择营业截止时间" toView:self.view];
            return;
        }
        com.comp_end_time = timeSp_two_end;
        if ([two_province_id isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择所在地区" toView:self.view];
            return;
        }
        com.comp_province_id = two_province_id;
        com.comp_city_id = two_city_id;
        com.comp_area_id = two_area_id;
        if ([two_street_id isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择所在街道" toView:self.view];
            return;
        }
        com.comp_street_id = two_street_id;
        if (![comp_auth_status isEqualToString:@"3"]) {
            if (twoImage_first == nil) {
                [MBProgressHUD showError:@"营业执照照片" toView:self.view];
                return;
            }
            com.comp_business_license = twoImage_first;
        } else {
            if (twoImage_first != nil) {
                com.comp_business_license = twoImage_first;
            }
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [com sUserCompAuthSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (IBAction)topBtnClick:(UIButton *)sender {
    [MBProgressHUD showError:@"请先完善个人认证" toView:self.view];
}
@end

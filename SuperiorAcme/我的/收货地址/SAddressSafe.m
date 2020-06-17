//
//  SAddressSafe.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddressSafe.h"
#import "DatePicker_Country.h"
#import "SAddress_choice.h"

#import "SAddressAddAddress.h"
#import "SAddressGetOneAddress.h"
#import "SAddressEditAddress.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface SAddressSafe () <UITextViewDelegate,BMKGeoCodeSearchDelegate>
{
    NSString * province;//省
    NSString * city;//市
    NSString * area;//区
    NSString * street;//街道
    NSString * province_id;//省id
    NSString * city_id;//市id
    NSString * area_id;//区县id
    NSString * street_id;//街道id
    NSString * model_lng;//经度
    NSString * model_lat;//纬度
    
    BMKGeoCodeSearch * _searcher;
}
@property (strong, nonatomic) IBOutlet UITextField *receiverTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *oneTF;
@property (strong, nonatomic) IBOutlet UITextField *twoTF;
@property (strong, nonatomic) IBOutlet UITextView *addressTV;
@end

@implementation SAddressSafe

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _addressTV.delegate = self;
   


    if (_type == NO) {
        province = @"";
        city = @"";
        area = @"";
        street = @"";
        province_id = @"";
        city_id = @"";
        area_id = @"";
        street_id = @"";
        model_lng = @"";
        model_lat = @"";
    } else {
        SAddressGetOneAddress * getOne = [[SAddressGetOneAddress alloc] init];
        getOne.address_id = _address_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [getOne sAddressGetOneAddressSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SAddressGetOneAddress * getOne = (SAddressGetOneAddress *)data;
                province = getOne.data.province;
                city = getOne.data.city;
                area = getOne.data.area;
                street = getOne.data.street;
                province_id = getOne.data.province_id;
                city_id = getOne.data.city_id;
                area_id = getOne.data.area_id;
                street_id = getOne.data.street_id;
                model_lng = getOne.data.lng;
                model_lat = getOne.data.lat;
                
                _receiverTF.text = getOne.data.receiver;
                _phoneTF.text = getOne.data.phone;
                _oneTF.text = [NSString stringWithFormat:@"%@%@%@",getOne.data.province,getOne.data.city,getOne.data.area];
                _twoTF.text = getOne.data.street;
                _addressTV.text = getOne.data.address;
                _addressTV.textColor = WordColor;
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
 //   [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_type == NO) {
        self.title = @"新增地址";

    } else {
        self.title = @"编辑地址";

    }
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
//       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
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
    
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    if (_type == NO) {
        SAddressAddAddress * add = [[SAddressAddAddress alloc] init];
        if ([_receiverTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请填写姓名" toView:self.view];
            return;
        }
        add.receiver = _receiverTF.text;
        if ([_phoneTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请填写手机号" toView:self.view];
            return;
        }
        add.phone = _phoneTF.text;
        if ([_oneTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择所在地区" toView:self.view];
            return;
        }
        if ([_twoTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择所在街道" toView:self.view];
            return;
        }
        add.province = province;
        add.city = city;
        add.area = area;
        add.street = street;
        add.province_id = province_id;
        add.city_id = city_id;
        add.area_id = area_id;
        add.street_id = street_id;
        if ([_addressTV.text isEqualToString:@"详细地址"]) {
            [MBProgressHUD showError:@"请输入详细地址" toView:self.view];
            return;
        }
        add.address = _addressTV.text;
        add.lng = model_lng;//lng
        add.lat = model_lat;//lat
        [MBProgressHUD showMessage:nil toView:self.view];
        [add sAddressAddAddressSuccess:^(NSString *code, NSString *message) {
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
    } else {
        SAddressEditAddress * edit = [[SAddressEditAddress alloc] init];
        edit.address_id = _address_id;
        if ([_receiverTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请填写姓名" toView:self.view];
            return;
        }
        edit.receiver = _receiverTF.text;
        if ([_phoneTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请填写手机号" toView:self.view];
            return;
        }
        edit.phone = _phoneTF.text;
        if ([_oneTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择所在地区" toView:self.view];
            return;
        }
        if ([_twoTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择所在街道" toView:self.view];
            return;
        }
        edit.province = province;
        edit.city = city;
        edit.area = area;
        edit.street = street;
        edit.province_id = province_id;
        edit.city_id = city_id;
        edit.area_id = area_id;
        edit.street_id = street_id;
        if ([_addressTV.text isEqualToString:@"详细地址"]) {
            [MBProgressHUD showError:@"请输入详细地址" toView:self.view];
            return;
        }
        edit.address = _addressTV.text;
        edit.lng = model_lng;//lng
        edit.lat = model_lat;//lat
        [MBProgressHUD showMessage:nil toView:self.view];
        [edit sAddressEditAddressSuccess:^(NSString *code, NSString *message) {
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
    
}
#pragma mark - 所在地区
- (IBAction)oneBtn:(UIButton *)sender {
    
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
        _twoTF.text = @"";
        street = @"";
        street_id = @"";
        
        _oneTF.text = [NSString stringWithFormat:@"%@%@%@",one,two,three];
        province = one;
        city = two;
        area = three;
        province_id = one_id;
        city_id = two_id;
        area_id = three_id;
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
}
#pragma mark - 所在街道
- (IBAction)twoBtn:(UIButton *)sender {
    SAddress_choice * choiceAdd = [[SAddress_choice alloc] init];
    if ([area_id isEqualToString:@""]) {
        [MBProgressHUD showError:@"请先选择省份" toView:self.view];
        return;
    }
    choiceAdd.area_id = area_id;
    [self.navigationController pushViewController:choiceAdd animated:YES];
    choiceAdd.SAddress_choice_choice = ^(NSString *thisName, NSString *this_id) {
        _twoTF.text = thisName;
        street = thisName;
        street_id = this_id;
        //开始云检索获取经纬度
        [self startSearch];
    };
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"详细地址"]) {
        textView.text = @"";
        textView.textColor = WordColor;
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"详细地址";
        textView.textColor = WordColor_30;
    } else {
        textView.textColor = WordColor;
    }
    return YES;
}
- (void)startSearch {
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= city;
    geoCodeSearchOption.address = [NSString stringWithFormat:@"%@%@",area,street];
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
        model_lng = [NSString stringWithFormat:@"lng:%.6f",result.location.longitude];
        model_lat = [NSString stringWithFormat:@"lat:%.6f",result.location.latitude];
    }
    else {
        [MBProgressHUD showError:@"抱歉，未找到结果" toView:self.view];
    }
}

@end

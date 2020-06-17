//
//  DatePicker_Country.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "DatePicker_Country.h"
#import "SAddressGetRegion.h"

@interface DatePicker_Country () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString * region_one;
    NSString * region_two;
    NSString * region_three;
    NSString * region_id_one;
    NSString * region_id_two;
    NSString * region_id_three;
    NSArray * arr;
    NSArray * brr;
    NSArray * crr;
}
@property (strong, nonatomic) IBOutlet UIPickerView *mPicker;

@end

@implementation DatePicker_Country

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    region_id_one = @"";
    region_id_two = @"";
    region_id_three = @"";
    
    [self showModel];
}
- (void)showModel {
    SAddressGetRegion * reg = [[SAddressGetRegion alloc] init];
    if ([region_id_one isEqualToString:@""]) {
        reg.region_id = @"";
    } else {
        if (![region_id_one isEqualToString:@""] && [region_id_two isEqualToString:@""]) {
            reg.region_id = region_id_one;
        } else {
            reg.region_id = region_id_two;
        }
    }
    [reg sAddressGetRegionSuccess:^(NSString *code, NSString *message, id data) {
        if ([code isEqualToString:@"1"]) {
            SAddressGetRegion * reg = (SAddressGetRegion *)data;
            if (reg.data.province_list.count != 0) {
                arr = reg.data.province_list;
            } else {
                arr = @[];
            }
            if (reg.data.city_list.count != 0) {
                brr = reg.data.city_list;
            } else {
                brr = @[];
            }
            if (reg.data.area_list.count != 0) {
                crr = reg.data.area_list;
            } else {
                crr = @[];
            }
            [_mPicker reloadAllComponents];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
#pragma mark ------>> 每个组件的 row 数量 <<------
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return arr.count;
            break;
        case 1:
        {// 根据第 0 列选中省 得到对应的城市数组
            return brr.count;
        }
            break;
        case 2:
        {// 根据第 1 列选中城市  找到县级的数组
            return  crr.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"滚动了第 %ld 列 ",component);
    if (component == 0) {
        [_mPicker selectRow:0 inComponent:1 animated:YES];
        [_mPicker selectRow:0 inComponent:2 animated:YES];
        SAddressGetRegion * reg = arr[row];
        
        region_id_one = reg.region_id;
        region_one = reg.region_name;

        region_id_two = @"";
        region_two = @"";
        
        region_id_three = @"";
        region_three = @"";
    }
    if (component == 1) {
        [_mPicker selectRow:0 inComponent:2 animated:YES];
        SAddressGetRegion * reg = brr[row];
        
        region_id_two = reg.region_id;
        region_two = reg.region_name;
        
        region_id_three = @"";
        region_three = @"";
    }
    if (component == 2) {
        SAddressGetRegion * reg = crr[row];
        
        region_id_three = reg.region_id;
        region_three = reg.region_name;

    }
    [self showModel];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    // 获取第 0 列选中的省份  那么后面的城市就是这个省份的城市数组里面的
    //    NSInteger indexP = self.provinceCurrentIndex;
    //    province_Model *modelP = self.allProvinceArray[indexP];
    
    // 创建 UILabel 用于显示每一个 row 上面的内容
    UILabel *label = [UILabel new];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = WordColor;
    
    switch (component) {
        case 0:
        {// 第 0 列 显示省份
            SAddressGetRegion * reg = arr[row];
            label.text =  reg.region_name;
        }
            break;
        case 1:
        {// 根据第 0 选中的省份 来确定第 1 列显示城市
            SAddressGetRegion * reg = brr[row];
            label.text =  reg.region_name;
        }
            break;
        case 2:
        {// 根据第 1 列选中城市  找到县级的数组 返回对应的下标的县名
            //     NSInteger indexCity = [pickerView selectedRowInComponent:1];
            
            SAddressGetRegion * reg = crr[row];
            label.text =  reg.region_name;
        }
            break;
            
        default:
            label.text = @"其他";
            break;
    }
    return label;
}
- (IBAction)backBtn:(UIButton *)sender {
    if (self.DatePicker_Country_Back) {
        self.DatePicker_Country_Back();
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)submitBtn:(UIButton *)sender {
    if ([region_id_one isEqualToString:@""]) {
        SAddressGetRegion * reg = arr.firstObject;
        region_id_one = reg.region_id;
        region_one = reg.region_name;
    }
    if ([region_id_two isEqualToString:@""]) {
        SAddressGetRegion * reg = brr.firstObject;
        region_id_two = reg.region_id;
        region_two = reg.region_name;
    }
    if ([region_id_three isEqualToString:@""]) {
        SAddressGetRegion * reg = crr.firstObject;
        region_id_three = reg.region_id;
        region_three = reg.region_name;
    }
    if (self.DatePicker_Country_Submit) {
        self.DatePicker_Country_Submit(region_one,region_two,region_three,region_id_one,region_id_two,region_id_three);
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end

//
//  TimeDatePick.m
//  HouseFB
//
//  Created by TXD_air on 16/8/17.
//  Copyright © 2016年 GYM. All rights reserved.
//

#import "TimeDatePick.h"

@interface TimeDatePick () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString * thisYear;//年
    NSString * thisMonth;//月
    NSString * thisDay;//日
    NSString * thisHour;//时
    NSString * thisMinute;//分
    
    
    NSInteger num_left;
    NSInteger num_right;
    NSArray * arr;
    NSArray * brr;
    
    BOOL is_no;//是否可选
}
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) NSMutableArray * deliveryTimes;
@property (strong, nonatomic) IBOutlet UIPickerView *thisPickerView;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;
@property (strong, nonatomic) IBOutlet UIButton *backSubBtn;
@end

@implementation TimeDatePick

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@",[self deliveryTimes]);
    
    // Do any additional setup after loading the view from its nib.
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, ScreenH - 216 - 50, ScreenW, 216)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    if ([_type isEqualToString:@"1"]) {
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _thisTitle.text = @"选择日期";
    } else if ([_type isEqualToString:@"2"]) {
//        datePicker.datePickerMode = UIDatePickerModeTime;
        _datePicker.hidden = YES;
        _thisTitle.text = @"选择时间";
    }
//    
//    NSString* timeStr = [NSString stringWithFormat:@"30"];//2011-01-26 17:40:50
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
//    NSDate* date = [formatter dateFromString:timeStr];
//    
//    [datePicker setDate:date animated:YES];
     [self.view addSubview:_datePicker];
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_backSubBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_subMitBtn addTarget:self action:@selector(subMitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    arr = _thisHour;
//    brr = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"56",@"57",@"58",@"59"];
    brr = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59"];
//    [_thisPickerView selectRow:1 inComponent:1 animated:YES];
}

- (void)dateChanged:(UIDatePicker *)sender {
    //NSDateFormatter这个类用来设置时间的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //设置格式 yyyy表示年，MM表示月，dd表示日，a表示上午/下午，hh表示12小时制，HH表示24小时制，mm表示分，ss表示秒，eeee表示星期几，eee表示周几，ee表示第几天，e表示第几天
    [formatter setDateFormat:@"当前时间是yyyy年MM月dd日 a HH时mm分ss秒 eeee"];
    //设置星期几的别称  注意：顺序从星期日开始
    [formatter setWeekdaySymbols:@[@"礼拜天",@"礼拜1",@"礼拜2",@"礼拜3",@"礼拜4",@"礼拜5",@"礼拜6"]];
    //设置上午的别称
    [formatter setAMSymbol:@"前晌"];
    //设置下午的别称
    [formatter setPMSymbol:@"后晌"];
    //根据日期的格式formatter把NSDate类型转换为NSString类型
    NSString *dateStr = [formatter stringFromDate:sender.date];
    NSLog(@"%@",dateStr);
    //调出设备当前的时间
    NSDate *nowDate = [NSDate date];
    NSLog(@"%@",nowDate);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:sender.date];
    long weekNumber = [comps weekday]; //获取星期对应的长整形字符串
    long day=[comps day];//获取日期对应的长整形字符串
    long year=[comps year];//获取年对应的长整形字符串
    long month=[comps month];//获取月对应的长整形字符串
    long hour=[comps hour];//获取小时对应的长整形字符串
    long minute=[comps minute];//获取月对应的长整形字符串
    long second=[comps second];//获取秒对应的长整形字符串
    
    thisYear = [NSString stringWithFormat:@"%ld",year];
    if ([NSString stringWithFormat:@"%ld",month].length == 1) {
        thisMonth = [NSString stringWithFormat:@"0%@",[NSString stringWithFormat:@"%ld",month]];
    } else {
        thisMonth = [NSString stringWithFormat:@"%ld",month];
    }
    if ([NSString stringWithFormat:@"%ld",day].length == 1) {
        thisDay = [NSString stringWithFormat:@"0%@",[NSString stringWithFormat:@"%ld",day]];
    } else {
        thisDay = [NSString stringWithFormat:@"%ld",day];
    }
    if ([NSString stringWithFormat:@"%ld",hour].length == 1) {
        thisHour = [NSString stringWithFormat:@"0%@",[NSString stringWithFormat:@"%ld",hour]];
    } else {
        thisHour = [NSString stringWithFormat:@"%ld",hour];
    }
    if ([NSString stringWithFormat:@"%ld",minute].length == 1) {
        thisMinute = [NSString stringWithFormat:@"0%@",[NSString stringWithFormat:@"%ld",minute]];
    } else {
        thisMinute = [NSString stringWithFormat:@"%ld",minute];
    }

}
//返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}
//返回每一列中的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return arr.count;
    }
    return brr.count;
    
}
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
//    if (component == 0) {
//        //刷新指定列中的行
//        //选择指定的item
//        [pickerView selectRow:0 inComponent:1 animated:YES];
//    }
    if (component == 0) {
        num_left = row;
        if (num_left == arr.count - 1) {
            is_no = YES;
        } else {
            is_no = NO;
        }
        [pickerView reloadComponent:0];
    } else {
        num_right = row;
        [pickerView reloadComponent:1];
    }

}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return ScreenW/2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    if (component == 0) {
        
        UIView * hourView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW/2, 30)];
        
        UILabel * hour = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW/2, 30)];
        hour.font = [UIFont systemFontOfSize:23];
        hour.textAlignment = NSTextAlignmentCenter;
        [hourView addSubview:hour];
        
        if (row == num_left) {
            hour.text = [NSString stringWithFormat:@"%@时",arr[row]];
        } else {
            hour.text = arr[row];
        }

        
        return hourView;
    }
    
    UIView * minuteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW/2, 30)];
    
    UILabel * minute = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW/2, 30)];
    minute.font = [UIFont systemFontOfSize:23];
    minute.textAlignment = NSTextAlignmentCenter;
    [minuteView addSubview:minute];
    
    if (row == num_right) {
//        if (is_no == YES&&row == 1) {
//            minute.textColor = wordGayColor222;
//        } else {
//            minute.textColor = [UIColor blackColor];
//        }
        minute.text = [NSString stringWithFormat:@"%@分",brr[row]];
    } else {
        minute.text = brr[row];
//        minute.textColor = [UIColor blackColor];

    }
    
    
    return minuteView;
}

#pragma mark - 返回
- (void)backBtnClick {
    if (self.TimeDatePickBack) {
        self.TimeDatePickBack();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 完成
- (void)subMitBtnClick {
    
    if (thisYear == nil) {
        NSDate *nowDate = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//设置成中国阳历
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
        comps = [calendar components:unitFlags fromDate:nowDate];
        long weekNumber = [comps weekday]; //获取星期对应的长整形字符串
        long day =[comps day];//获取日期对应的长整形字符串
        long year=[comps year];//获取年对应的长整形字符串
        long month=[comps month];//获取月对应的长整形字符串
        long hour=[comps hour];//获取小时对应的长整形字符串
        long minute=[comps minute];//获取月对应的长整形字符串
        long second=[comps second];//获取秒对应的长整形字符串
        
        thisYear = [NSString stringWithFormat:@"%ld",year];
        if ([NSString stringWithFormat:@"%ld",month].length == 1) {
            thisMonth = [NSString stringWithFormat:@"0%@",[NSString stringWithFormat:@"%ld",month]];
        } else {
            thisMonth = [NSString stringWithFormat:@"%ld",month];
        }
        if ([NSString stringWithFormat:@"%ld",day].length == 1) {
            thisDay = [NSString stringWithFormat:@"0%@",[NSString stringWithFormat:@"%ld",day]];
        } else {
            thisDay = [NSString stringWithFormat:@"%ld",day];
        }
        if ([NSString stringWithFormat:@"%ld",hour].length == 1) {
            thisHour = [NSString stringWithFormat:@"0%@",[NSString stringWithFormat:@"%ld",hour]];
        } else {
            thisHour = [NSString stringWithFormat:@"%ld",hour];
        }
        if ([NSString stringWithFormat:@"%ld",minute].length == 1) {
            thisMinute = [NSString stringWithFormat:@"0%@",[NSString stringWithFormat:@"%ld",minute]];
        } else {
            thisMinute = [NSString stringWithFormat:@"%ld",minute];
        }
    }
    
    
    if ([_type isEqualToString:@"1"]) {
        
        NSString* timeStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:00",thisYear,thisMonth,thisDay,@"00",@"00"];//2011-01-26 17:40:50
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
//        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//        NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
        NSLog(@"timeSp:%@",timeSp); //时间戳的值
        
        
        NSDate  *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
        
        NSInteger year=[components year];
        NSInteger month=[components month];
        NSInteger day=[components day];
        
        NSDate* thisNowDate = [formatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00", (long)year,(long)month,(long)day]];
        NSString *thisNowTimeSp = [NSString stringWithFormat:@"%ld", (long)[thisNowDate timeIntervalSince1970]];
        NSLog(@"thisNowTimeSp:%@",thisNowTimeSp); //时间戳的值
        
        //1天：86400秒
        
        
//        if ([date timeIntervalSince1970] < [thisNowDate timeIntervalSince1970] + 24 * 60 * 60) {
//            [MBProgressHUD showError:@"预定的时间从明天开始" toView:self.view];
//            return;
//        } else {
//            if ([date timeIntervalSince1970] > ([thisNowDate timeIntervalSince1970] + 8 * 24 * 60 * 60)) {
//                [MBProgressHUD showError:@"配送时间为一周内" toView:self.view];
//                return;
//            }
//        }

//        if ([thisDay isEqualToString:[NSString stringWithFormat:@"%ld",day]]) {
//            [MBProgressHUD showError:@"预定的时间从明天开始" toView:self.view];
//            return;
//        }
//        datePicker.datePickerMode = UIDatePickerModeTime;
        
        if ([_subMitBtn.titleLabel.text isEqualToString:@"下一步"]) {
            _type = @"2";
            _datePicker.hidden = YES;
            _thisTitle.text = @"选择时间";
            [_subMitBtn setTitle:@"完成" forState:UIControlStateNormal];
        } else {
//            thisNowTimeSp
            
            //不需要小时、分钟的情况
            if (self.TimeDatePickSubmit_YMD) {
                self.TimeDatePickSubmit_YMD(thisYear,thisMonth,thisDay,@"",@"");
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
        

    } else if ([_type isEqualToString:@"2"]) {
        //获取系统当前年月日
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        
        int year =(int) [dateComponent year];
        int month = (int) [dateComponent month];
        int day = (int) [dateComponent day];
        int hour = (int) [dateComponent hour];
        int minute = (int) [dateComponent minute];
//        if (is_no == YES&&[brr[num_right] isEqualToString:@"30"]) {
//            [MBProgressHUD showError:@"最晚21点" toView:self.view];
//            return;
//        }
        if (self.TimeDatePickSubmit_YMD) {
            self.TimeDatePickSubmit_YMD(thisYear,thisMonth,thisDay,arr[num_left],brr[num_right]);
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
}


#pragma mark - 清除Picker自定义XibView 上下的线 ---- 暂时没有用到
- (void)clearSeparatorWithView:(UIView * )view
{
    if(view.subviews != 0  )
    {
        if(view.bounds.size.height < 5)
        {
            view.backgroundColor = [UIColor clearColor];
        }
        
        [view.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
            [self clearSeparatorWithView:obj];
        }];
    }
    
}

#pragma mark - 取时间Arr --- 暂时没有用到
- (NSMutableArray *)deliveryTimes {
    if (!_deliveryTimes) {
        NSCalendar * calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents * components = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
        NSString * minString = [NSString stringWithFormat:@"%02zd",components.minute];
        NSInteger lastMin = [[minString substringFromIndex:1] integerValue];
        NSInteger diff = 10 - lastMin;
        diff = diff?diff + 10:10;
        NSLog(@"%zd",diff);
        //开始时间
        NSDate * startDate = [[NSDate date] dateByAddingTimeInterval:diff * 60];
        //结束时间
        NSDate * endDate = [self endDate];
        NSMutableArray * tempArray = [NSMutableArray array];
        [tempArray addObject:@"立即送达"];
        for (NSInteger i = 0; ; i++) {
            NSDate * nDate = [startDate dateByAddingTimeInterval:i * 20 * 60];
            NSComparisonResult result = [nDate compare:endDate];
            if (result == NSOrderedDescending) {
                break;
            }
            
            [tempArray addObject:[self fetchDateStringFromDate:nDate withFormat:@"HH:mm"]];
        }
        _deliveryTimes = tempArray;
    }
    return _deliveryTimes;

}
- (NSString *)fetchDateStringFromDate:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString * dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
- (NSDate *)endDate {
    
    NSDateFormatter * fmt = NSDateFormatter.new;
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString * timeString = [fmt stringFromDate:[NSDate date]];
    timeString = [timeString stringByAppendingFormat:@" %@",@"23:59"];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    return [fmt dateFromString:timeString];
    
}

- (IBAction)foreverBtn:(UIButton *)sender {
    if (self.TimeDatePick_foreverBtn) {
        self.TimeDatePick_foreverBtn();
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)hiddenForever {
    _foreverBtn.hidden = YES;
    _foreverBtn_HHH.constant = 0;
    _datePicker.frame = CGRectMake(0, ScreenH - 216, ScreenW, 216);
}
@end

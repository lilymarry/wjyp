//
//  ChooseDateView.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ChooseDateView.h"

@interface ChooseDateView ()

@end

@implementation ChooseDateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        UIView *view=[[UIView alloc]initWithFrame:self.bounds];
        view.backgroundColor=[UIColor whiteColor];
        [self addSubview:view];
        
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(8, 5, 76, 30);
        
        [leftBtn setBackgroundColor:[UIColor clearColor]];
        [leftBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(cancelPress:) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [view addSubview:leftBtn];
        
        
        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(self.frame.size.width-80, 5, 76, 30);
        
        [rightBtn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:12/255.0 blue:255/255.0 alpha:1]];
        
        [rightBtn addTarget:self action:@selector(confirmDate:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [view addSubview:rightBtn];
        
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 1)];
        line.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [view addSubview:line];
        
        _datapicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 42, self.frame.size.width, self.frame.size.height-42)];
        
        // 设置日期选择控件的地区
        
        [_datapicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        
        
        //默认为当天。
        
        [_datapicker setCalendar:[NSCalendar currentCalendar]];
        
        [_datapicker setDate:[NSDate date]];

   
        _datapicker.minimumDate = [NSDate date];
        //显示年月日
        
        [_datapicker setDatePickerMode:UIDatePickerModeDate];
        
        
        
        [view addSubview:_datapicker];
        
        
    }
    return self;
}

- (void)confirmDate:(id)sender {
    
    NSDate *date=self.datapicker.date;
    NSString *dateStr=[self stringFromDate:date];
    if (self.delgate!=nil&&[self.delgate respondsToSelector:@selector(chooseDateView:type:)]) {
        [self.delgate chooseDateView:dateStr type:_type];
        
    }
    
    
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
- (void)cancelPress:(id)sender {
    
    if (self.delgate!=nil&&[self.delgate respondsToSelector:@selector(removeDateView)]) {
        [self.delgate removeDateView];
        
    }
    
}



@end

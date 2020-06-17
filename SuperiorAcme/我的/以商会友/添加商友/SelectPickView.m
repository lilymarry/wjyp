//
//  SelectPickView.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "SelectPickView.h"

@interface SelectPickView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *data;
    NSString *type;
}
@property (strong, nonatomic) IBOutlet UIPickerView *pickView;

@end

@implementation SelectPickView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SelectPickView" owner:self options:nil];
        [self addSubview:_thisView];
      
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
-(void)getData:(NSArray *)arr flag:(NSString *)flag
{
    data=arr;
    type=flag;
   [_pickView reloadAllComponents];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return data.count;
}
//#pragma mark-UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [data objectAtIndex:row];
}

- (IBAction)sureBtnPress:(id)sender
{
    NSInteger  rowI=  (int) [_pickView selectedRowInComponent:0];
    self.topBtnBlock(data[rowI], type, rowI);
    [self removeFromSuperview];
    
  
}
- (IBAction)CanselPress:(id)sender
{
     self.cancelBlock();
     [self removeFromSuperview];
    
}
-(void)reloaPickView
{
    
    [_pickView reloadAllComponents];
    
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

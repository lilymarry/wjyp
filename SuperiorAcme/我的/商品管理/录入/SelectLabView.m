//
//  SelectLabView.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "SelectLabView.h"
#import "AddAttr_nameFootCell.h"
@interface SelectLabView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *data;
    NSString *type;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mTableHHH;
@property (strong, nonatomic)IBOutlet  UITableView *mTable;
@end

@implementation SelectLabView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SelectLabView" owner:self options:nil];
        [self addSubview:_thisView];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mTable registerNib:[UINib nibWithNibName:@"AddAttr_nameFootCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddAttr_nameFootCell"];
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
    _mTableHHH.constant=data.count*44;
    [_mTable reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

        AddAttr_nameFootCell*  cell = [_mTable dequeueReusableCellWithIdentifier:@"AddAttr_nameFootCell" forIndexPath:indexPath];
    [ cell.AddBtn addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.AddBtn setTitle:data[indexPath.row] forState:UIControlStateNormal];

    if ([cell.AddBtn.titleLabel.text isEqualToString:_selectStr]) {
         [cell.AddBtn setTitleColor:[UIColor redColor]  forState:UIControlStateNormal];
    }
    else
    {
        if (indexPath.row==data.count-1) {
            [cell.AddBtn setTitleColor:[UIColor blueColor]  forState:UIControlStateNormal];
        }
        else
        {
            [cell.AddBtn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
        }
    }
        cell.AddBtn.tag=indexPath.row;
    
       cell.lineView.hidden=NO;
        return cell;
 
}
-(void)selectData:(UIButton *)but
{
    [self removeFromSuperview];
    self.topBtnBlock(data[but.tag], type, but.tag);
    
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

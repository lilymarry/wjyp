//
//  WAInRoomPlayerList.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAInRoomPlayerList.h"
#import "WAInRoomPlayerListCell.h"
#import "PeopleInRoomModel.h"
#import "CommonHelp.h"
@interface WAInRoomPlayerList ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation WAInRoomPlayerList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"玩家列表";
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WAInRoomPlayerListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAInRoomPlayerListCell"];
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 30);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setBackgroundColor:[UIColor clearColor]];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self getData];
}
-(void)getData
{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    PeopleInRoomModel *model=[[PeopleInRoomModel alloc] init];
    model.cid=_cid;
    [model PeopleInRoomModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            PeopleInRoomModel *model=(PeopleInRoomModel *)data;
            dataArr=[NSArray arrayWithArray:[self sortedArrayUsingComparatorByPaymentTimeWithDataArr:model.data.RoomPeople]];
       }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
        [_mTable reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
      
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
    
}
#pragma 返回
-(void)lefthBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WAInRoomPlayerListCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAInRoomPlayerListCell" forIndexPath:indexPath];
    [cell.videoBtn addTarget:self action:@selector(tapVideo:) forControlEvents:UIControlEventTouchUpInside];
    [cell.videoBtn setTag:indexPath.row];
    PeopleInRoomModel *model=dataArr[indexPath.row];
    [cell.headImaView sd_setImageWithURL:[NSURL URLWithString:model.head_pic]
                          placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    cell.nameLab.text=model.nickname;
    cell.timeLab.text=[CommonHelp timeWithTimeIntervalString:model.create_time andFormatter:@"YYYY.MM.dd HH:mm:ss"];
    return cell;
    
}
- (void)tapVideo:(id)sender {
    
    UIButton *but=(UIButton *)sender;
    NSLog(@"%d",(int) but.tag);
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}
# pragma mark 时间排序
- (NSArray *)sortedArrayUsingComparatorByPaymentTimeWithDataArr:(NSArray *)dataArr{
    
    NSArray *sortArray = [dataArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        PeopleInRoomModel *mode1=obj1;
        PeopleInRoomModel *mode2=obj2;
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
        
        NSDate *date1=[formatter dateFromString:[CommonHelp timeWithTimeIntervalString:mode1.create_time andFormatter:@"YYYY.MM.dd HH:mm:ss"]];
        NSDate *date2=[formatter dateFromString:[CommonHelp timeWithTimeIntervalString:mode2.create_time andFormatter:@"YYYY.MM.dd HH:mm:ss"]];
        
        
        if (date1 == [date1 earlierDate: date2]) {
            return NSOrderedDescending;//降序
        }
        else if (date1 == [date1 laterDate: date2])
        {
             return NSOrderedAscending;//升序
        }
        else
        {
            return NSOrderedSame;//相等
        }
    }];
    
    return sortArray;
    
  
    
}


@end

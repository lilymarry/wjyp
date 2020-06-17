//
//  WAMoneyPayList.m
//  CatchWAWA
//
//  Created by donkey on 2019/1/6.
//  Copyright © 2019 wotianshiyan. All rights reserved.
//

#import "WAMoneyPayList.h"
#import "WAMoneyPayListCell.h"
#import "MoneycChargeListModel.h"
#import "CommonHelp.h"
@interface WAMoneyPayList ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *type;
    NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (weak, nonatomic) IBOutlet UIView *line0;

@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (assign,nonatomic) NSInteger page;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHH;
@property (strong, nonatomic) IBOutlet UIView *Sview;

@end

@implementation WAMoneyPayList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_mTable registerNib:[UINib nibWithNibName:@"WAMoneyPayListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMoneyPayListCell"];
   
    if ([_flag isEqualToString:@"1"]) {
        _viewHH.constant=68;
        _Sview.hidden=NO;
         self.title=@"银两明细";
         [self initializeSubViewProperty];
    }
    else
    {
          _viewHH.constant=0;
          _Sview.hidden=YES;
          self.title=@"兑换记录";
    }
  
    type=@"1";
    [self refreshAndLoadMoreMethod];
}
//初始化子控件的相关属性
-(void)initializeSubViewProperty{
    _segment.tintColor = [UIColor clearColor];
    //定义选中状态的样式selected，类型为字典
    NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                               NSForegroundColorAttributeName:[UIColor colorWithRed:245/255.0 green:70/255.0 blue:151/255.0 alpha:1]};
    //定义未选中状态下的样式normal，类型为字典
    NSDictionary *normal = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                             NSForegroundColorAttributeName:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]};
   
    //通过setTitleTextAttributes: forState: 方法来给test控件设置文字内容的格式
    [_segment setTitleTextAttributes:normal forState:UIControlStateNormal];
    [_segment setTitleTextAttributes:selected forState:UIControlStateSelected];
    
    //设置test初始状态下的选中下标
    _segment.selectedSegmentIndex = 0;
    
    _line0.frame=CGRectMake(60, 64, ScreenW/2-20-80, 1);

}
- (void)refreshAndLoadMoreMethod{
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    [_mTable.mj_header beginRefreshing];
    
    _mTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getData];
    }];
    
}
-(void)getData
{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    MoneycChargeListModel *model=[[MoneycChargeListModel alloc] init];
    
    model.p=[NSString stringWithFormat:@"%d",(int)self.page];
    model.type=type;
    [model MoneycChargeListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            MoneycChargeListModel *model=(MoneycChargeListModel *)data;
            if (self->_page==1) {
                [self->dataArr removeAllObjects];
                if ([_flag isEqualToString:@"1"]) {
                      self->dataArr =[NSMutableArray arrayWithArray:model.data.list];
                }
                else
                {
                     self->dataArr =[NSMutableArray arrayWithArray:[self searchDuihuanData:model.data.list]];
                }
              
            }
            else
            {
                if ([_flag isEqualToString:@"1"]) {
                     [self->dataArr addObjectsFromArray:model.data.list];
                }
                else
                {
                   [ self->dataArr addObjectsFromArray:[self searchDuihuanData:model.data.list]];
                }
             
                
            }
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
        [_mTable.mj_footer endRefreshing];
        [_mTable.mj_header endRefreshing];
        
        [_mTable reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
        [_mTable.mj_footer endRefreshing];
        [_mTable.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
    
}
-(IBAction)change:(UISegmentedControl *)sender{
  
    if (sender.selectedSegmentIndex == 0) {
    
      _line0.frame=CGRectMake(60, 64, ScreenW/2-20-80, 1);
       type=@"1";
      
    }else {

       _line0.frame=CGRectMake(ScreenW/2+20+20, 64,ScreenW/2-20-80, 1);
      type=@"2";
    }
    [self refreshAndLoadMoreMethod];
}


-(void)viewWillAppear:(BOOL)animated
{
  //self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
        return 54;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        WAMoneyPayListCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMoneyPayListCell" forIndexPath:indexPath];
    MoneycChargeListModel *model= dataArr[indexPath.row];
    if ([_flag isEqualToString:@"1"]) {
          cell.nameLab.text=model.desc;
    }
    else
    {
         cell.nameLab.text=@"兑换银两";
    }
  
    cell.timeLab.text=[CommonHelp timeWithTimeIntervalString:model.create_time andFormatter:@"YYYY.MM.dd HH:mm:ss"];
    
    if ([type isEqualToString:@"1"]) {
        cell.moneyLab.text=[NSString
                            stringWithFormat:@"+%@",model.money];
    }
    else
    {
        cell.moneyLab.text=[NSString
                            stringWithFormat:@"-%@",model.money];
    }
 
        return cell;
   
    
    
}
-(NSArray *)searchDuihuanData:(NSArray *)arr
{
    NSMutableArray *data=[NSMutableArray array];
    for ( MoneycChargeListModel *model in arr) {
   
        if ([model.desc containsString:@"兑换"]) {
            [data addObject:model];
        }
    }
    return data;
    
}
@end

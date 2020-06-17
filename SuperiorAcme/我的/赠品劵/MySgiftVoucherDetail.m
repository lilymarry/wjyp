//
//  SgiftVoucherDetail.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "MySgiftVoucherDetail.h"
#import "MySgiftVoucherDetailCell.h"
#import "MyGiftDetailModel.h"
@interface MySgiftVoucherDetail ()<UITableViewDataSource,UITableViewDelegate>
@property (assign,nonatomic) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (weak, nonatomic) IBOutlet UITableView *tabView;


@end

@implementation MySgiftVoucherDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      self.title=@"赠品券明细";
       self.page=1;
     [_tabView registerNib:[UINib nibWithNibName:NSStringFromClass([MySgiftVoucherDetailCell class]) bundle:nil] forCellReuseIdentifier:@"MySgiftVoucherDetailCell"];
    [self refreshAndLoadMoreMethod];
}
- (void)refreshAndLoadMoreMethod{
    _tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    [_tabView.mj_header beginRefreshing];
    
    _tabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getData];
    }];
    
}
-(void)getData
{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    MyGiftDetailModel *model=[[MyGiftDetailModel alloc] init];
    
    model.p=[NSString stringWithFormat:@"%d",(int)self.page];
    model.id=_idstr;
    
    [model MyGiftDetailModelSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        MyGiftDetailModel * infor = (MyGiftDetailModel *)data;
        
        if ([code  intValue]==200) {
            if (_page==1) {
                self.dataArr =[NSMutableArray arrayWithArray:infor.data];
            }
            else
            {
                if (SWNOTEmptyArr(infor.data)) {
                   [self.dataArr addObjectsFromArray:infor.data];
                }
              
            }
            
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
        [_tabView reloadData];
        [_tabView.mj_footer endRefreshing];
        [_tabView.mj_header endRefreshing];
        
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
        [_tabView.mj_footer endRefreshing];
        [_tabView.mj_header endRefreshing];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        MySgiftVoucherDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MySgiftVoucherDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     MyGiftDetailModel *mode=self.dataArr[indexPath.row];
    cell.nameLab.text=mode.reason;
    cell.timeLab.text=mode.create_time;
    [cell.imaviewLoad sd_setImageWithURL:[NSURL URLWithString: mode.img]
                         placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    if ([mode.add_sub isEqualToString:@"0"]) {
        cell.moneyLab.text =[NSString stringWithFormat:@"+%@",mode.money];
    }
    else
    {
          cell.moneyLab.text =[NSString stringWithFormat:@"-%@",mode.money];
    }
        return cell;

}
#pragma mark ========== heightForHeaderInSection ==========
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
        return 69;
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

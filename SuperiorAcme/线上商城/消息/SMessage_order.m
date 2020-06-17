//
//  SMessage_order.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMessage_order.h"
#import "SMessage_orderCell.h"
#import "SUserMessageOrderMsgList.h"
#import "CQPlaceholderView.h"
#import "SUserMessageMsgList.h"
#import "SUserMessageAnnounceList.h"
#import "SMessageInfor.h"
#import "SOrderInfor.h"
#import "SMemberOrderInfor.h"

@interface SMessage_order () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView *placeholderView;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SMessage_order

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SMessage_orderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SMessage_orderCell"];
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)initRefresh
{
    __block SMessage_order * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)showModel {
    
    if ([_type isEqualToString:@"1"]) {
        SUserMessageOrderMsgList * list = [[SUserMessageOrderMsgList alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserMessageOrderMsgListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SUserMessageOrderMsgList * list = (SUserMessageOrderMsgList *)data;
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_type isEqualToString:@"2"]) {
        
        SUserMessageMsgList * list = [[SUserMessageMsgList alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserMessageMsgListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SUserMessageMsgList * list = (SUserMessageMsgList *)data;
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_type isEqualToString:@"3"]) {
        
        SUserMessageAnnounceList * list = [[SUserMessageAnnounceList alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserMessageAnnounceListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SUserMessageAnnounceList * list = (SUserMessageAnnounceList *)data;
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if ([_type isEqualToString:@"1"]) {
        self.title = @"订单消息";
    } else if ([_type isEqualToString:@"2"]) {
        self.title = @"通知消息";

    } else if ([_type isEqualToString:@"3"]) {
        self.title = @"公告消息";
        
    }
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    header.backgroundColor = [UIColor clearColor];
    
    UILabel * time = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW/2 - 85, 10, 170, 30)];
    [header addSubview:time];
    
    if ([_type isEqualToString:@"1"]) {
        SUserMessageOrderMsgList * list = arr[section];
        time.text = list.create_time;

    } else if ([_type isEqualToString:@"2"]) {
        SUserMessageMsgList * list = arr[section];
        time.text = list.create_time;

    } else if ([_type isEqualToString:@"3"]) {
        SUserMessageAnnounceList * list = arr[section];
        time.text = list.create_time;
        
    }
    time.textColor = [UIColor whiteColor];
    time.backgroundColor = WordColor_sub_sub;
    time.textAlignment = NSTextAlignmentCenter;
    time.font = [UIFont systemFontOfSize:13];
    time.layer.masksToBounds = YES;
    time.layer.cornerRadius = 3;
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //type == 1
    if ([_type isEqualToString:@"1"]) {

        SUserMessageOrderMsgList * list = arr[indexPath.section];
        CGSize size = [list.content boundingRectWithSize:CGSizeMake(ScreenW - 50, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        return 50 + size.height + 10;
    }
    //type == 2
    if ([_type isEqualToString:@"2"]) {

        SUserMessageMsgList * list = arr[indexPath.section];
        CGSize size = [list.content boundingRectWithSize:CGSizeMake(ScreenW - 50, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        return 50 + size.height + 10;

    }
    
    //type == 3
    SUserMessageAnnounceList * list = arr[indexPath.section];
    CGSize size = [list.title boundingRectWithSize:CGSizeMake(ScreenW - 50, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return 50 + size.height + 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SMessage_orderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SMessage_orderCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([_type isEqualToString:@"1"]) {
        cell.thisTitle.textColor = [UIColor orangeColor];
        cell.thisTitle.text = @"订单消息";
        SUserMessageOrderMsgList * list = arr[indexPath.section];
        cell.thisContent.text = list.content;
    }
    if ([_type isEqualToString:@"2"]) {
        cell.thisTitle.textColor = MyBlue;
        cell.thisTitle.text = @"通知消息";
        SUserMessageMsgList * list = arr[indexPath.section];
        cell.thisContent.text = list.content;
    }
    if ([_type isEqualToString:@"3"]) {
        cell.thisTitle.textColor = [UIColor redColor];
        cell.thisTitle.text = @"公告消息";
        SUserMessageAnnounceList * list = arr[indexPath.section];
        cell.thisContent.text = list.title;
        if (list.is_read && [list.is_read isEqualToString:@"0"]) {
            cell.statusLabel.hidden = NO;
        } else {
            cell.statusLabel.hidden = YES;
        }
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_type isEqualToString:@"1"]) {

        SUserMessageOrderMsgList * list = arr[indexPath.section];
        if ([list.chat isEqualToString:@""] || list.chat == nil) {
            if ([list.type integerValue] == 1) {
                //会员卡
                SMemberOrderInfor * infor = [[SMemberOrderInfor alloc] init];
                infor.order_id = list.order_id;
                infor.order_status = list.order_status;
                infor.member_coding = list.member_coding;
                infor.type = @"会员卡";
                [self.navigationController pushViewController:infor animated:YES];
            } else {
                
                //商品  0普通商品订单 2拼单购 3无界预购 4比价购 5无界商店 6积分抽奖
                 NSInteger typeNum = [list.type integerValue];
                 SOrderInfor * infor = [[SOrderInfor alloc] init];
                 NSString * typeStr;
                switch (typeNum) {
                    case 0:
                    {
                        typeStr = @"普通商品";
                        infor.order_id = list.order_id;
                        infor.order_type = typeStr;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                        break;
                        
                    case 2:
                    {
                        typeStr = @"拼单购";
                        infor.order_id = list.order_id;
                        infor.order_type = typeStr;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                        break;
                    
                    case 3:
                    {
                        typeStr = @"无界预购";
                        infor.order_id = list.order_id;
                        infor.order_type = typeStr;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                        break;
                    
                    case 4:
                    {
                        typeStr = @"比价购";
                        infor.order_id = list.order_id;
                        infor.order_type = typeStr;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                        break;
                        
                    case 5:
                    {
                        typeStr = @"无界商店";
                        infor.order_id = list.order_id;
                        infor.order_type = typeStr;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                        break;
                    
                    case 6:
                    {
                        typeStr = @"积分抽奖";
                        infor.order_id = list.order_id;
                        infor.order_type = typeStr;
                        [self.navigationController pushViewController:infor animated:YES];
                        return;
                    }
                        break;
                        
//                    case 12:
//                        typeStr = @"普通商品";
//                        infor.Is_399=YES;
//                        break;
//                    case 15:
//                        typeStr = @"赠品专区";
//                        break;
//                    case 13:
//                        typeStr = @"普通商品";
//                        infor.Is_2980=YES;
//                        break;
                    case 9:
                       {
                           SMemberOrderInfor * infor = [[SMemberOrderInfor alloc] init];
                           infor.order_id = list.order_id;
                           infor.type = @"线下商铺";
                           infor.pay_status = @"1";
                           infor.common_status = 1;
                           infor.status = @"10086";
                           [self.navigationController pushViewController:infor animated:YES];
                           return;
                       }
                        break;
                    default:
                        break;
                    
                }
              
               
                
            }
        } else {
            [MBProgressHUD showError:list.chat toView:self.view];
        }
    }
    if ([_type isEqualToString:@"3"]) {
        SUserMessageAnnounceList * list = arr[indexPath.section];
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"公告消息";
        infor.id = list.id;
        [self.navigationController pushViewController:infor animated:YES];
    }
}
@end

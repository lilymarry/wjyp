//
//  SEvaAll.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaAll.h"
#import "SEvaAllCell.h"
#import "SShopCar_editViewCell.h"
#import "SHouseInfor_top.h"
#import "SCarBuyCommentList.h"
#import "SAAPIHelper.h"
#import "SEvaTop.h"

@interface SEvaAll () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * arr;//列表
    NSInteger  page;
    NSString * model_label_id;//标签ID
    SHouseInfor_top * top;
    SEvaTop *underLineTop;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (nonatomic, strong) SAAPIHelper *apiHelper;
@end

@implementation SEvaAll

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = [NSString stringWithFormat:@"全部评价(%@)",_inforComment_num];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SEvaAllCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SEvaAllCell"];
    
    model_label_id = @"";
    page = 1;
    [self initRefresh];
    [self showModel];
    
    if (![_overType isEqualToString:@"线下商铺"]) {
        top = [[SHouseInfor_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 300)];
        _mTable.tableHeaderView = top;
        MJWeakSelf;
        top.SHouseInfor_top_choice = ^(NSString *label_id) {
            model_label_id = label_id;
            page = 1;
            [weakSelf showModel];
        };
    }else{
        self.apiHelper = [SAAPIHelper new];
        [self.mTable.mj_header beginRefreshing];
        arr = [NSMutableArray array];
        underLineTop = [[SEvaTop alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
        _mTable.tableHeaderView = underLineTop;
    }
}
- (void)initRefresh
{
    __weak SEvaAll * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([_overType isEqualToString:@"线下商铺"]){
            [MBProgressHUD showMessage:nil toView:self.view];
            [blockSelf.apiHelper refreshOfflineStoreCommentListWithMerchant_id:blockSelf.merchant_id
                                                                    completion:^(BOOL isSuccess, NSString *message, id result) {
                                                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                        [blockSelf.mTable.mj_header endRefreshing];
                                                                        if (isSuccess) {
                                                                            [arr removeAllObjects];
                                                                            [blockSelf.mTable.mj_footer resetNoMoreData];
                                                                            [blockSelf reloadDataWithModel:result];
                                                                        }else{
                                                                            [MBProgressHUD showSuccess:message toView:blockSelf.view];
                                                                        }
                                                                    }];
        }else{
            page = 1;
            [blockSelf showModel];
        }
    }];
    _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([_overType isEqualToString:@"线下商铺"]){
            [MBProgressHUD showMessage:nil toView:blockSelf.view];
            [blockSelf.apiHelper loadMoreOfflineStoreCommentListWithMerchant_id:blockSelf.merchant_id
                                                                     completion:^(BOOL isSuccess, NSString *message, id result) {
                                                                         [MBProgressHUD hideHUDForView:blockSelf.view animated:YES];
                                                                         if (isSuccess) {
                                                                            [blockSelf.mTable.mj_footer endRefreshing];
                                                                             [blockSelf reloadDataWithModel:result];
                                                                         }else{
                                                                             [blockSelf.mTable.mj_footer endRefreshingWithNoMoreData];
                                                                             [MBProgressHUD showSuccess:message toView:blockSelf.view];
                                                                         }
                                                                     }];
        }else{
            page++;
            [blockSelf showModel];
        }
    }];
}

-(void)reloadDataWithModel:(NSArray *)result{
    UBShopDetailCommentModel *model = (UBShopDetailCommentModel *)result;
    self.title = [NSString stringWithFormat:@"全部评价(%@)",model.data.count];
   
    [arr addObjectsFromArray:model.data.list];
    
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已有 %@ 条评价    ",@(arr.count)]];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,[@(arr.count) stringValue].length)];
    underLineTop.num.attributedText = AttributedStr;
    
    [_mTable reloadData];
}
- (void)showModel {
    if ([_overType isEqualToString:@"线下商铺"]) {
        return;
    }
    
    SCarBuyCommentList * list = [[SCarBuyCommentList alloc] init];
    list.car_id = _car_id;
    list.label_id = model_label_id;
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sCarBuyCommentListSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SCarBuyCommentList * list = (SCarBuyCommentList *)data;
        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:list.data.comment_list];
            [_mTable.mj_footer resetNoMoreData];
        } else {
            if (list.data.comment_list.count) {
                
                [arr addObjectsFromArray:list.data.comment_list];
                [_mTable.mj_footer endRefreshing];
                
            } else {
                
                [_mTable.mj_footer endRefreshingWithNoMoreData];
            }
        }
        if (list.data.label_list.count % 2 == 0) {
            top.frame = CGRectMake(0, 0, ScreenW, 70 + list.data.label_list.count/2 * 50);
        } else {
            top.frame = CGRectMake(0, 0, ScreenW, 70 + (list.data.label_list.count/2 + 1) * 50);
        }
        for (int i = 0; i < [list.data.composite integerValue]; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 12, 15, 15)];
            [top.starView addSubview:imageView];
            
            imageView.image = [UIImage imageNamed:@"星星黄"];
        }
        top.starView_num.text = [NSString stringWithFormat:@"%zd",[list.data.composite integerValue]];
        top.num_label.text = [NSString stringWithFormat:@"外观内饰%@分 空间舒适%@分 操控性能%@分 油耗动力%@分",list.data.exterior,list.data.space,list.data.controllability,list.data.consumption];
        [top showModel:list.data.label_list andNow:model_label_id andType:@"SCarBuyCommentList"];
        
        dispatch_async(dispatch_get_main_queue(),^{
            top.mCollect_HHH.constant = top.mCollect.contentSize.height;
            top.frame = CGRectMake(0, 0, ScreenW, 80 + top.mCollect.contentSize.height);
            _mTable.tableHeaderView = top;
            
        });
        
        [_mTable.mj_header endRefreshing];
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
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
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCarBuyCommentList * list = arr[indexPath.section];

    NSInteger content_num = 0;
    NSInteger thisContent_num = 0;
    if ([_overType isEqualToString:@"线下商铺"]) {
        UBShopDetailCommentModel *model = (id)list;
        if (model.picture.count == 0) {
            thisContent_num = 0;
        } else {
            thisContent_num = 90; //115
        }
        content_num += 25;  //星高度 间距
        if (SWNOTEmptyStr(list.content)) {
            CGSize size = [[NSString stringWithFormat:@"%@",list.content] boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            content_num += size.height + 10;
        }
        
    }else{
        NSMutableArray * label_arr = [[NSMutableArray alloc] init];
        for (SCarBuyCommentList * list_sub in list.label_arr) {
            [label_arr addObject:list_sub.label];
        }
        CGSize size = [[NSString stringWithFormat:@"%@\n\n标签：%@",list.content,[label_arr componentsJoinedByString:@"、"]] boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        content_num = size.height + 10;
        if (list.pictures_arr.count == 0) {
            thisContent_num = 0;
        } else {
            thisContent_num = 70;
        }
    }
    
    
    return 55 + content_num + thisContent_num + 10 + 35;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEvaAllCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SEvaAllCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SCarBuyCommentList * list = arr[indexPath.section];
    
    [cell.head_pic sd_setImageWithURL:[NSURL URLWithString:list.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.nickname.text = list.nickname;
    if ([_overType isEqualToString:@"线下商铺"]) {
        UBShopDetailCommentModel *model = (id)list;
        cell.content.text = model.content;
        
        cell.create_time.text = model.start_time;
        cell.starView.hidden = NO;
        [cell showModel:model.picture andType:@"UBShopDetailCommentModel"];
        if (model.picture.count == 0) {
            cell.thisContent.hidden = YES;
            cell.thisContent_TopHHH.constant = 0;
            cell.thisContent_HHH.constant = 0;
            cell.timeTop_HHH.constant = 0;
        } else {
            cell.thisContent.hidden = NO;
            cell.thisContent_TopHHH.constant = 0;
            cell.thisContent_HHH.constant = 60;
            cell.timeTop_HHH.constant = 45;
        }
        
        for (UIImageView *imgV in cell.starView.subviews) {
            //
            
        }
        for (int i = 0; i < cell.starView.subviews.count; i++) {
            UIImageView *imgV = cell.starView.subviews[i];
            if (i < model.star) {
                imgV.image = [UIImage imageNamed:@"评价黄星"];
            }else{
                imgV.image = [UIImage imageNamed:@"评价白星"];
            }
        }
        
        
        CGSize size = [[NSString stringWithFormat:@"%@",model.content] boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        cell.content_HHH.constant = size.height + 10;
    }else{
        if (list.pictures_arr.count == 0) {
            cell.thisContent.hidden = YES;
            cell.thisContent_TopHHH.constant = 0;
            cell.thisContent_HHH.constant = 0;
        } else {
            cell.thisContent.hidden = NO;
            cell.thisContent_TopHHH.constant = 10;
            cell.thisContent_HHH.constant = 60;
        }
        NSMutableArray * label_arr = [[NSMutableArray alloc] init];
        for (SCarBuyCommentList * list_sub in list.label_arr) {
            [label_arr addObject:list_sub.label];
        }
        cell.content.text = [NSString stringWithFormat:@"%@\n\n标签：%@",list.content,[label_arr componentsJoinedByString:@"、"]];
        cell.create_time.text = list.create_time;
        [cell showModel:list.pictures_arr andType:@"SCarBuyCommentList"];
        
        CGSize size = [[NSString stringWithFormat:@"%@\n\n标签：%@",list.content,[label_arr componentsJoinedByString:@"、"]] boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        cell.content_HHH.constant = size.height + 10;
    }
    
    
    return cell;
}
@end

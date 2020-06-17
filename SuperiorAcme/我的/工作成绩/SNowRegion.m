//
//  SNowRegion.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SNowRegion.h"
#import "SNowRegion_Top.h"
#import "SNowRegion_leftCell.h"
#import "SNowRegion_rightCell.h"
#import "SNowRegion_searchCell.h"
#import "SAddressGetRegion.h"
#import "BMChineseSort.h"//城市排序算法

@interface SNowRegion () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray * city_arr;
    NSMutableArray * indexArray;
    NSMutableArray * letterResultArr;
    NSMutableArray * seachArr;
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UITableView *mTable_sub;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mSub_TopHHH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mSub_downHHH;
@property (weak, nonatomic) IBOutlet UITableView *searchTab;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@end

@implementation SNowRegion

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _searchView.layer.masksToBounds = YES;
    _searchView.layer.cornerRadius = 15;
    
    SNowRegion_Top * top = [[SNowRegion_Top alloc] init];
    _mTable.tableHeaderView = top;
    top.SNowRegion_Top_myChoice = ^(NSString *name) {
        [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"当前选择名称"];
        if (self.SNowRegion_choice) {
            self.SNowRegion_choice();
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SNowRegion_leftCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SNowRegion_leftCell"];
    
    _searchTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_searchTab registerNib:[UINib nibWithNibName:@"SNowRegion_searchCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SNowRegion_searchCell"];
    
    _mTable_sub.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable_sub registerNib:[UINib nibWithNibName:@"SNowRegion_rightCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SNowRegion_rightCell"];
    _mTable_sub.scrollEnabled = NO;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"] forKey:@"当前选择名称"];
    }
    
    //获取城市列表
    SAddressGetRegion * reg = [[SAddressGetRegion alloc] init];
    reg.region_id = @"";
    [reg sAddressGetRegionSuccess:^(NSString *code, NSString *message, id data) {
        if ([code isEqualToString:@"1"]) {
            SAddressGetRegion * reg = (SAddressGetRegion *)data;
            city_arr = reg.data.city;
            indexArray = [BMChineseSort IndexWithArray:city_arr Key:@"region_name"];
            letterResultArr = [BMChineseSort sortObjectArray:city_arr Key:@"region_name"];
            [top showModel:reg.data.hot_list];
            top.frame = CGRectMake(0, 0, ScreenW, 40 + 150 + 100 + (reg.data.hot_list.count%3 + 1) * 50);
            [_mTable reloadData];
            [_mTable_sub reloadData];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
    _searchTab.hidden = YES;
    _searchTF.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"] == nil) {
//        self.title = [NSString stringWithFormat:@"当前-%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"]];
//    } else {
//        self.title = [NSString stringWithFormat:@"当前-%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"当前选择名称"]];
//    }
    self.title = @"城市选择";
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
    if (tableView == _mTable_sub) {
        return 1;//右侧区数
    }
    if (tableView == _searchTab) {
        return 1;//右侧区数
    }
    return indexArray.count;//左侧区数
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _mTable_sub) {
        return indexArray.count;//右侧行数
    }
    if (tableView == _searchTab) {
        return seachArr.count;//右侧行数
    }
    return [[letterResultArr objectAtIndex:section] count];//左侧行数
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _mTable_sub) {
        return 0.01;
    }
    if (tableView == _searchTab) {
        return 0.01;
    }
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _mTable_sub) {
        return nil;
    }
    if (tableView == _searchTab) {
        return nil;
    }
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    header.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UILabel * abc = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 30)];
    [header addSubview:abc];
    abc.text = indexArray[section];
    abc.textColor = WordColor;
    abc.font = [UIFont systemFontOfSize:13];
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _mTable_sub) {
        return (ScreenH - 64 - 50)/indexArray.count;
    }
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _mTable_sub) {
        SNowRegion_rightCell * cell = [_mTable_sub dequeueReusableCellWithIdentifier:@"SNowRegion_rightCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.thisContent.text = indexArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    }
    if (tableView == _mTable) {
        SNowRegion_leftCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SNowRegion_leftCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        SAddressGetRegion * list = [[letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.thisTitle.text = list.region_name;
        
        return cell;

    }
    SNowRegion_searchCell * cell = [_searchTab dequeueReusableCellWithIdentifier:@"SNowRegion_searchCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.thisView.text = seachArr[indexPath.row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _mTable) {
        SAddressGetRegion * list = [[letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:list.region_name forKey:@"当前选择名称"];
        if (self.SNowRegion_choice) {
            self.SNowRegion_choice();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (tableView == _mTable_sub) {
        [_mTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
    if (tableView == _searchTab) {
        [[NSUserDefaults standardUserDefaults] setObject:seachArr[indexPath.row] forKey:@"当前选择名称"];
        if (self.SNowRegion_choice) {
            self.SNowRegion_choice();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _searchTab.hidden = NO;
    seachArr = [[NSMutableArray alloc] init];
    [_searchTab reloadData];

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    seachArr = [[NSMutableArray alloc] init];
    for (SAddressGetRegion * list in city_arr) {
        if (!([list.region_name rangeOfString:textField.text].location == NSNotFound)) {
            [seachArr addObject:list.region_name];
        }
    }
    [_searchTab reloadData];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        _searchTab.hidden = YES;
    } else {
        seachArr = [[NSMutableArray alloc] init];
        for (SAddressGetRegion * list in city_arr) {
            if (!([list.region_name rangeOfString:textField.text].location == NSNotFound)) {
                [seachArr addObject:list.region_name];
            }
        }
        [_searchTab reloadData];
    }
    return YES;
}
@end

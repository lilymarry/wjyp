//
//  WAMineFriend.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/15.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMineFriend.h"
#import "WAMineFriendTopView.h"
#import "WAMineFriendCel.h"
#import "MAMineActivtyView.h"
#import "WAMineFriendHelpSuccessView.h"
#import "WAPrice.h"
//倒计时
#import "OYCountDownManager.h"

#import "WAMineMyWaList.h"
#import "WAInRoom.h"
@interface WAMineFriend ()<UITableViewDelegate,UITableViewDataSource>
{
    WAMineFriendTopView *top;
    WAMineFriendHelpSuccessView   *help;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tabBottomHHH;

@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation WAMineFriend

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WAMineFriendCel" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMineFriendCel"];
    [self createSMineTopView];
    [self createNav];
 
     [kCountDownManager start];
    if ( [_type isEqualToString:@"1"]) {
        _tabBottomHHH.constant=-TAB_BAR_HEIGHT-15;
    }
    else
    {
          _tabBottomHHH.constant=0;
        UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lefthBtn.frame = CGRectMake(0, 0, 44, 30);
        UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
        self.navigationItem.leftBarButtonItem = leftBtnItem;
        [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
        lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
        
        [lefthBtn setBackgroundColor:[UIColor clearColor]];
        [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
  
    UIButton * right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 44, 30);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    right.layer.masksToBounds = YES;
    right.layer.cornerRadius = 10;
    right.layer.borderWidth = 0.1;
    right.layer.borderColor =[UIColor clearColor].CGColor;
    
    [right setTitle:@"活动细则" forState:UIControlStateNormal];
    // [right setTitleEdgeInsets:UIEdgeInsetsMake(0,ScreenW-15, 0, 0)];
    [right setTitleColor:[UIColor colorWithRed:252/255.0 green:32/255.0 blue:35/255.0 alpha:1] forState:UIControlStateNormal];
    [right setBackgroundColor:[UIColor colorWithRed:254/255.0 green:218/255.0 blue:111/255.0 alpha:1]];
    [right addTarget:self action:@selector(ActivtyClick) forControlEvents:UIControlEventTouchUpInside];
    right.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    //   right.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20);
    
    
    
    

    
}
-(void)viewWillAppear:(BOOL)animated
{
        adjustsScrollViewInsets_NO(_mTable, self);
    
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        //透明
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self scrollViewDidScroll:_mTable];
    

    
    
}
-(void)viewDidAppear:(BOOL)animated
{
//    adjustsScrollViewInsets_NO(_mTable, self);
//
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    //透明
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self scrollViewDidScroll:_mTable];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar lt_reset];
    
}
- (void)createSMineTopView {
    top = [[WAMineFriendTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1154)];
    [top.helpBtn addTarget:self action:@selector(helpPress) forControlEvents:UIControlEventTouchUpInside];
    __weak typeof(self) weakSelf = self;
    top.block = ^(int imaTag) {
        [weakSelf seeUser:imaTag];
    };
    _mTable.tableHeaderView = top;
    [kCountDownManager reload];
    
}
-(void)seeUser:(int)imaTag
{
    WAMineMyWaList *money=[[WAMineMyWaList alloc]init];
  
    money.isUser=YES;
    [self.navigationController pushViewController:money animated:YES];
}
- (void)createNav {
    
    
    
}
-(void)lefthBtnClick
{
    BOOL isExit=NO;
    for(UIViewController *temp in self.navigationController.viewControllers) {
        if([temp isKindOfClass:[WAInRoom class]]){
            isExit=YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }
        
    }
    if(isExit==NO)
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}
-(void)helpPress
{
   help = [[WAMineFriendHelpSuccessView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [help.priceBtn addTarget:self action:@selector(toPricePress) forControlEvents:UIControlEventTouchUpInside];
    [self.view.window addSubview:help];
}
-(void)toPricePress
{

    [help removeView];
    WAPrice *pirce=[[WAPrice alloc]init];
    [self.navigationController pushViewController:pirce animated:YES];
   
}
-(void)ActivtyClick
{
    MAMineActivtyView   *he = [[MAMineActivtyView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
    [self.view.window addSubview:he];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 10;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    // if (section == 2) {
//    return 10;
//    // }
//    // return 0.01;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WAMineFriendCel * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMineFriendCel" forIndexPath:indexPath];
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = navigationColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 50) {
        CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        
        
    }
    
    //获取tableView当前的y偏移
    CGFloat contentOffsety  = scrollView.contentOffset.y;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
        _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=200-64){
        _mTable.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    
   
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

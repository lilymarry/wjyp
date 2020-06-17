//
//  WAPrice.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/16.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAPrice.h"
#import "WAPriceCell.h"
#import "WAPriceTopView.h"
#import "WAGetPriceView.h"

@interface WAPrice ()<UITableViewDelegate,UITableViewDataSource>
{
    WAPriceTopView *top;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation WAPrice

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WAPriceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAPriceCell"];
    [self createSMineTopView];
}
-(void)viewDidAppear:(BOOL)animated
{
    adjustsScrollViewInsets_NO(_mTable, self);
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //透明
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self scrollViewDidScroll:_mTable];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar lt_reset];
    
}
- (void)createSMineTopView {
    top = [[WAPriceTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW,ScreenW/46*19+ScreenW/207*191+40+30)];
     __weak typeof(self) weakSelf = self;
    top.topBtnBlock = ^(NSString *name) {
        [weakSelf topBtnEvent:name];
    };
    _mTable.tableHeaderView = top;
    
}
-(void)topBtnEvent:(NSString *)name
{
    WAGetPriceView *view=[[WAGetPriceView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        NSDictionary *attributes = @{
                        NSForegroundColorAttributeName:[UIColor redColor], NSStrokeColorAttributeName:[UIColor whiteColor],
                                     NSStrokeWidthAttributeName:@-3};
        NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"抽中了%@",name] attributes:attributes];
        [ view.nameLab setAttributedText:attributeText];
      [self.view.window addSubview:view];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WAPriceCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAPriceCell" forIndexPath:indexPath];
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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

@end

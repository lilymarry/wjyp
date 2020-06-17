//
//  SAcademy_NewContent.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAcademy_NewContent.h"
#import "SNBannerView.h"
#import "SCollectBookCell.h"
#import "CQPlaceholderView.h"
#import "SAcademyAcademyIndex.h"

@interface SAcademy_NewContent () <SNBannerViewDelegate,CQPlaceholderViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CQPlaceholderView * placeholderView;
    NSArray * thisArr;
}
@end

@implementation SAcademy_NewContent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SAcademy_NewContent" owner:self options:nil];
        [self addSubview:_thisView];
        
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mTable registerNib:[UINib nibWithNibName:@"SCollectBookCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SCollectBookCell"];
        
        
        placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
        [_mTable addSubview:placeholderView];
        placeholderView.hidden = YES;
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    if (self.SAcademy_NewContent_ShowModelAgain) {
        self.SAcademy_NewContent_ShowModelAgain();
    }
}
- (void)showModel:(NSArray *)arr andBanner:(NSArray *)bannerArr{
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    
    UIView * top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*400 + 10)];
    _mTable.tableHeaderView = top;
    top.backgroundColor = [UIColor groupTableViewBackgroundColor];
    SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*400) delegate:self model:bannerArr URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
    [top addSubview:banner];
    
    thisArr = arr;
    [_mTable reloadData];
}
- (void)bannerView:(SNBannerView *)bannerView didSelectImageIndex:(NSInteger)index {
    if (self.SAcademy_NewContent_bannerView) {
        self.SAcademy_NewContent_bannerView();
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return thisArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCollectBookCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCollectBookCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.choiceBtn.hidden = YES;
    cell.headerImage_WWW.constant = 10;
    cell.line_WWW.constant = 10;
    
    SAcademyAcademyIndex * list = thisArr[indexPath.row];
    [cell.logo sd_setImageWithURL:[NSURL URLWithString:list.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.thisTitle.text = list.title;
    cell.page_views_collect_num.text = [NSString stringWithFormat:@"%@人收藏     %@人浏览",list.collect_num,list.page_views];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SAcademyAcademyIndex * list = thisArr[indexPath.row];
    if (self.SAcademy_NewContent_infor) {
        self.SAcademy_NewContent_infor(list.academy_id);
    }
}
@end

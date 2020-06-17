//
//  QGoodsInfor_first_header3Reusa.m
//  SuperiorAcme
//
//  Created by GYM on 2017/10/27.
//  Copyright © 2017年 GYM. All rights reserved.
//
#import "QGoodsInfor_first_header3Reusa.h"
#import "SOnlineShop_ClassInfoList_more_footerCell.h"
#import "QGoodsInfor_first_header3_evaCollect.h"
#import "SGoodsGoodsInfo.h"
#import "attr_tableCell.h"
#import "SGoodsGoodsInfo.h"
#import "SLimitBuyLimitBuyInfo.h"
#import "SGroupBuyGroupBuyInfo.h"
#import "SPreBuyPreBuyInfo.h"
#import "SIntegralBuyIntegralBuyInfo.h"
#import "SgiftDetailModel.h"
@interface QGoodsInfor_first_header3Reusa() <UICollectionViewDelegate,UICollectionViewDataSource,WKNavigationDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray * thisArr;
    QGoodsInfor_first_header3_evaCollect * coll;
    BOOL over;
    NSArray * this_attrArr;
    NSString * thisType;
    
    int i;
}
@end
@implementation QGoodsInfor_first_header3Reusa

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    i=0;
    _oneBtn.layer.masksToBounds = YES;
    _oneBtn.layer.cornerRadius = 17.5;
    _oneBtn.layer.borderWidth = 0.5;
    _oneBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    _twoBtn.layer.masksToBounds = YES;
    _twoBtn.layer.cornerRadius = 17.5;
    _twoBtn.layer.borderWidth = 0.5;
    _twoBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
   
    
    
    _collocationR.layer.masksToBounds = YES;
    _collocationR.layer.cornerRadius = 3;
    _songR.layer.masksToBounds = YES;
    _songR.layer.cornerRadius = _songR.frame.size.width/2;
    _delPriceR.layer.masksToBounds = YES;
    _delPriceR.layer.cornerRadius = 3;
    
    
    UICollectionViewFlowLayout * mFlowLayout;
    mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 15;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 15;//用于控制单元格之间最小 行间距
    mFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    mFlowLayout.itemSize = CGSizeMake(80, 80);//设置单元格的宽和高
    mFlowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);//各分区上下左右空白区域大小
    
    [_evaCollect setCollectionViewLayout:mFlowLayout];
    //隐藏滚轴
    _evaCollect.showsHorizontalScrollIndicator = NO;
    _evaCollect.delegate = self;
    _evaCollect.dataSource = self;
    //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
    [_evaCollect registerNib:[UINib nibWithNibName:@"SOnlineShop_ClassInfoList_more_footerCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShop_ClassInfoList_more_footerCell"];
    
    coll = [[QGoodsInfor_first_header3_evaCollect alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 100)];
    [_collocationView addSubview:coll];
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    _wk_web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0) configuration:wkWebConfig];
    _wk_web.userInteractionEnabled = YES;
    _wk_web.navigationDelegate = self;
    _wk_web.scrollView.scrollEnabled = NO;
    [_thisWk_web addSubview:_wk_web];
    
    _imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    _imageBtn.hidden = YES;
//    [_thisWk_web addSubview:_imageBtn];
//    [_imageBtn addTarget:self action:@selector(imageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _attr_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_attr_table registerNib:[UINib nibWithNibName:@"attr_tableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"attr_tableCell"];
    _attr_table.delegate = self;
    _attr_table.dataSource = self;
}
- (void)showModel:(NSArray *)arr {
    thisArr = arr;
    [_evaCollect reloadData];
}
- (void)showModelBrr:(NSArray *)brr {
    [coll showModel:brr andType:@""];
}
- (void)wk_web:(NSString *)wk_webHTML {
    [_wk_web loadHTMLString:wk_webHTML baseURL:nil];
}
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (over == YES) {
        return;
    }
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        
        
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
//        NSLog(@"图文详情高度:%f",heightStr.floatValue);
        over = YES;
        _wk_web.frame = CGRectMake(0, 0, ScreenW, heightStr.floatValue + 15);
        _imageBtn.frame = CGRectMake(0, 0, ScreenW, heightStr.floatValue + 15);
        if (self.QGoodsInfor_first_header3Reusa_HTML) {
            self.QGoodsInfor_first_header3Reusa_HTML(heightStr.floatValue);
        };
        
    }];
    
//    static  NSString * const jsGetImages =
//    @"function getImages(){\
//    var objs = document.getElementsByTagName(\"img\");\
//    var imgScr = '';\
//    for(var i=0;i<objs.length;i++){\
//    imgScr = imgScr + objs[i].src + '+';\
//    };\
//    return imgScr;\
//    };";
//
//    [webView evaluateJavaScript:jsGetImages completionHandler:nil];
//    [webView evaluateJavaScript:@"getImages()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//
//        NSArray *urlArray = [NSMutableArray arrayWithArray:[result componentsSeparatedByString:@"+"]];
//        //urlResurlt 就是获取到得所有图片的url的拼接；mUrlArray就是所有Url的数组
//        NSLog(@"--%@",urlArray);
//    }];

}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return thisArr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShop_ClassInfoList_more_footerCell * mCell = [_evaCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShop_ClassInfoList_more_footerCell" forIndexPath:indexPath];
    mCell.thisPrice.hidden = YES;
    mCell.thisPriceGround.hidden = YES;
    
    SGoodsGoodsInfo * infor = thisArr[indexPath.row];
    
    [mCell.thisImage sd_setImageWithURL:[NSURL URLWithString:infor.path] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    return mCell;
}

- (IBAction)down_oneBtn:(UIButton *)sender {
    if (self.QGoodsInfor_first_header3Reusa_downOneBtn) {
        self.QGoodsInfor_first_header3Reusa_downOneBtn();
    }
}
- (IBAction)down_twoBtn:(UIButton *)sender {
    if (self.QGoodsInfor_first_header3Reusa_downTwoBtn) {
        self.QGoodsInfor_first_header3Reusa_downTwoBtn();
    }
}
- (IBAction)down_threeBtn:(UIButton *)sender {
    if (self.QGoodsInfor_first_header3Reusa_downThreeBtn) {
        self.QGoodsInfor_first_header3Reusa_downThreeBtn();
    }
}
- (void)showAttrModel:(NSArray *)attr_arr andType:(NSString *)type{
    this_attrArr = attr_arr;
    thisType = type;
    [_attr_table reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return this_attrArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic=this_attrArr[section];
    NSArray *arr=dic[@"list"];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel * headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 50)];
    [headerView addSubview:headerTitle];
    headerTitle.textColor = WordColor;
    headerTitle.font = [UIFont systemFontOfSize:14];
    NSDictionary *dic=this_attrArr[section];
    headerTitle.text = dic[@"tittle"];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    attr_tableCell * cell = [_attr_table dequeueReusableCellWithIdentifier:@"attr_tableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary * infor = this_attrArr[indexPath.section];
    if (thisType == nil) {
        SGoodsGoodsInfo * infor_sub = infor[@"list"][indexPath.row];
        cell.attr_name.text = infor_sub.attr_name;
        cell.attr_value.text = infor_sub.attr_value;
    }
    if ([thisType isEqualToString:@"限量购"]) {
        SLimitBuyLimitBuyInfo * infor_sub = infor[@"list"][indexPath.row];
        cell.attr_name.text = infor_sub.attr_name;
        cell.attr_value.text = infor_sub.attr_value;
        
        
    }
    if ([thisType isEqualToString:@"拼单购"]) {
        SGroupBuyGroupBuyInfo * infor_sub = infor[@"list"][indexPath.row];
        cell.attr_name.text = infor_sub.attr_name;
         cell.attr_value.text = infor_sub.attr_value;
        
    }
    if ([thisType isEqualToString:@"无界预购"]) {
        SPreBuyPreBuyInfo * infor_sub = infor[@"list"][indexPath.row];
        cell.attr_name.text = infor_sub.attr_name;
         cell.attr_value.text = infor_sub.attr_value;
      
    }
    if ([thisType isEqualToString:@"无界商店"]) {
        SIntegralBuyIntegralBuyInfo * infor_sub = infor[@"list"][indexPath.row];
        cell.attr_name.text = infor_sub.attr_name;
        cell.attr_value.text = infor_sub.attr_value;
      
    }
    if ([thisType isEqualToString:@"赠品专区"]) {
        SgiftDetailModel * infor_sub = infor[@"list"][indexPath.row];
        cell.attr_name.text = infor_sub.attr_name;
        cell.attr_value.text = infor_sub.attr_value;
        
    }
    return cell;
}
#pragma mark - 看图
- (void)imageBtnClick {
    if (self.QGoodsInfor_first_header3Reusa_showImage) {
        self.QGoodsInfor_first_header3Reusa_showImage();
    }
}
@end

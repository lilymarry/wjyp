//
//  SLotInfor_newTwoView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/16.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLotInfor_newTwoView.h"
#import "SOnlineShop_ClassInfoList_more_footerCell.h"
#import "SAuctionAuctionInfo.h"
@interface SLotInfor_newTwoView() <UICollectionViewDelegate,UICollectionViewDataSource,WKNavigationDelegate>
{
    NSArray * thisArr;
    BOOL over;
}
@end
@implementation SLotInfor_newTwoView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    _wk_web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0) configuration:wkWebConfig];
    _wk_web.userInteractionEnabled = NO;
    _wk_web.navigationDelegate = self;
    _wk_web.backgroundColor = [UIColor yellowColor];
    [_thisWk_web addSubview:_wk_web];
}
- (void)showModel:(NSArray *)arr {
    thisArr = arr;
    [_evaCollect reloadData];
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
        _wk_web.frame = CGRectMake(0, 0, ScreenW, heightStr.floatValue);
        if (self.QGoodsInfor_first_header3Reusa_HTML) {
            self.QGoodsInfor_first_header3Reusa_HTML(heightStr.floatValue);
        };
        
    }];
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
    
    SAuctionAuctionInfo * infor = thisArr[indexPath.row];
    
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
@end

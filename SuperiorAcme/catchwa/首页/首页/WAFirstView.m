//
//  WAFirstView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/2.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAFirstView.h"
#import "WAFirstListCell.h"
#import "WAFirstViewTopView.h"
#import "WAFirstNavView.h"
#import "DCCycleScrollView.h"
#import "WAfirstItemListView.h"
#import "WAFirstFocus.h"
#import "WACatchList.h"
#import "WANewPersonPriceView.h"
#import "WADailySginIn1.h"
#import "WASignInSuccessView.h"
#import "WAInRoom.h"
#import "GCDSocketManager.h"
#import "GetRoomListModel.h"
#import "EnterRoomModel.h"

#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"
#define NAVBAR_CHANGE_POINT 50

#define K_MAIN_VIEW_SCROLL_HEIGHT 30.0f
#define K_MAIN_VIEW_SCROLL_TEXT_TAG 300

#define K_MAIN_VIEW_TEME_INTERVAL 0.35  //计时器间隔时间(单位秒)
#define K_MAIN_VIEW_SCROLLER_SPACE 20.0f   //每次移动的距
#define K_MAIN_VIEW_SCROLLER_LABLE_WIDTH 18.0f //单个字符宽度(与你设置的字体大小一致)
#define K_MAIN_VIEW_SCROLLER_LABLE_MARGIN 20.0f //前后间隔距离
#define K_MAIN_VIEW_SCROLLER_SLEEP_INTERVAL 0//停留时间

@interface WAFirstView ()<UICollectionViewDelegate,UICollectionViewDataSource,DCCycleScrollViewDelegate>
{
    WAFirstViewTopView *top;
    WAFirstNavView *navView;
    WADailySginIn1 * header2;
    NSMutableArray *dataArr;
    
    NSTimer           *timer;
    UIScrollView      *scrollViewText;
    NSArray *nameSign_news;
    NSArray  *bannerArr;
}

@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) DCCycleScrollView *banner;
@property (nonatomic,strong) NSArray *imageArr;
@property (strong, nonatomic)IBOutlet  UICollectionView *mCollection;
@property (assign,nonatomic) NSInteger page;
@property (nonatomic ,strong) NSArray *arrData;

@end

@implementation WAFirstView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    [self refreshAndLoadMoreMethod];
    
}
- (void)refreshAndLoadMoreMethod{
    _mCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    [_mCollection.mj_header beginRefreshing];
    
    _mCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getData];
    }];
    
}
-(void)getData
{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    GetRoomListModel *model=[[GetRoomListModel alloc] init];
    
    model.p=[NSString stringWithFormat:@"%d",(int)self.page];

    [model getRoomListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data,NSDictionary *dic_new) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            GetRoomListModel *model=(GetRoomListModel *)data;
            if (self->_page==1) {
                [self->dataArr removeAllObjects];
                self->dataArr =[NSMutableArray arrayWithArray:model.data.list];
            }
            else
            {
                [self->dataArr addObjectsFromArray:model.data.list];
            }
      
            
          //  nameSign_news=model.data.turntable.sign_news;
            self->_imageArr=[NSArray arrayWithArray:model.data.banner];
            [self.banner removeFromSuperview];
            DCCycleScrollView *banner = [DCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, 218) shouldInfiniteLoop:YES imageGroupsModels:self->_imageArr URLAttributeName:@"picture"];
            
            banner.autoScrollTimeInterval = 3;
            banner.autoScroll = YES;
            banner.isZoom = YES;
            banner.itemSpace = 0;
            banner.imgCornerRadius = 10;
            banner.itemWidth = self.view.frame.size.width - 100;
            banner.delegate = self;
            //隐藏pageControl
            banner.pageControl.hidden = NO;
            
            self.banner = banner;
            [self->top.bannerView addSubview: self.banner];
            
            [top getData:model.data.sx];
            
            bannerArr=model.data.banner;
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        [self->_mCollection reloadData];
        [self->_mCollection.mj_footer endRefreshing];
        [self->_mCollection.mj_header endRefreshing];
        
   
        
    } andFailure:^(NSError * _Nonnull error) {
        [self->_mCollection.mj_footer endRefreshing];
        [self->_mCollection.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
    
}

//初始化数据
-(void) initScrollView{
    //文字滚动
    [self initScrollText];
    
    //开启滚动
    [self startScroll];
    
}
-(void)stopScrollText
{
    [timer invalidate];
    timer=nil;
}

//文字滚动初始化
-(void) initScrollText{
    
    [scrollViewText removeFromSuperview];
    
    //获取滚动条
    scrollViewText = (UIScrollView *)[self.view viewWithTag:K_MAIN_VIEW_SCROLL_TEXT_TAG];
    if(!scrollViewText){
        scrollViewText = [[UIScrollView alloc] initWithFrame:navView.view_scroll.frame];
        scrollViewText.showsHorizontalScrollIndicator = NO;   //隐藏水平滚动条
        scrollViewText.showsVerticalScrollIndicator = NO;     //隐藏垂直滚动条
        scrollViewText.scrollEnabled = NO;                    //禁用手动滑动
        
        //横竖屏自适应
        scrollViewText.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollViewText.tag = K_MAIN_VIEW_SCROLL_TEXT_TAG;
        [scrollViewText setBackgroundColor:[UIColor clearColor]];
        
        //给滚动视图添加事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerViewClick:)];
        [scrollViewText addGestureRecognizer:tapGesture];
        
        //添加到当前视图
        [navView.view_scroll addSubview:scrollViewText];
    }else{
        //清除子控件
        for (UIView *view in [scrollViewText subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (self.arrData) {
        
        CGFloat offsetX = 0 ,i = 0, h = 30;
        
        //设置滚动文字
        UIButton *btnText = nil;
        NSString *strTitle = [[NSString alloc] init];
        
        for (GetRoomListModel *model in self.arrData) {
            
          //  strTitle =[NSString stringWithFormat:@"%@抓到了%@",model.nickname,model.goods_name] ;
            
         
            NSString *goodsName=model.goods_name;
            if (model.goods_name.length==0||model.goods_name==nil) {
                goodsName=@"";
            }
            strTitle =[NSString stringWithFormat:@"%@抓到了%@",model.nickname,goodsName] ;
            
            btnText = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnText setFrame:CGRectMake([self getTitleLeft:i],
                                         (K_MAIN_VIEW_SCROLL_HEIGHT - h) / 2,
                                         strTitle.length * K_MAIN_VIEW_SCROLLER_LABLE_WIDTH,
                                         h)];
            
            
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.head_pic] options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                UIImage *targetImage = [self imageWithClipImage:image scaleToSize:CGSizeMake(20, 20)];
                [btnText setImage:targetImage forState:UIControlStateNormal];
            }];
            
            [btnText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [btnText setTitle:strTitle forState:UIControlStateNormal];
            btnText.titleLabel.font = [UIFont systemFontOfSize: 12.0];
            
            //横竖屏自适应
            btnText.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            offsetX += btnText.frame.origin.x;
            
            //设置为 NO,否则无法响应点击事件
            btnText.userInteractionEnabled = NO;
            
            btnText.tag=i;
            
            //添加到滚动视图
            [scrollViewText addSubview:btnText];
            
            
            i++;
            
            
        }
        
        //设置滚动区域大小
        [scrollViewText setContentSize:CGSizeMake(offsetX, 0)];
    }
}

-(UIImage *)imageWithClipImage:(UIImage *)image scaleToSize:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //1.开启跟原始图片一样大小的上下文
    UIGraphicsBeginImageContextWithOptions(scaledImage.size, NO, 0);
    //2.设置一个圆形裁剪区域
    //2.1绘制一个圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, scaledImage.size.width, scaledImage.size.height)];
    //2.2.把圆形的路径设置成裁剪区域
    [path addClip];//超过裁剪区域以外的内容都给裁剪掉
    //3.把图片绘制到上下文当中(超过裁剪区域以外的内容都给裁剪掉)
    [scaledImage drawAtPoint:CGPointZero];
    //4.从上下文当中取出图片
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 滚动处理/
//开始滚动
-(void) startScroll{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:K_MAIN_VIEW_TEME_INTERVAL target:self selector:@selector(setScrollText) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer  forMode:NSRunLoopCommonModes];
    
}
//滚动处理
-(void) setScrollText{
    
    [UIView animateWithDuration:K_MAIN_VIEW_TEME_INTERVAL * 2 animations:^{
        CGRect rect;
        CGFloat offsetX = 0.0,width = 0.0;
        
        for (UIButton *btnText in self->scrollViewText.subviews) {
            
            rect = btnText.frame;
            offsetX = rect.origin.x - K_MAIN_VIEW_SCROLLER_SPACE;
            width = [btnText.titleLabel.text length] * K_MAIN_VIEW_SCROLLER_LABLE_WIDTH;
            
            btnText.frame = CGRectMake(offsetX, rect.origin.y, rect.size.width, rect.size.height);
            
            //    NSLog(@"offsetX:%f",offsetX);
        }
        
        if (offsetX < -width){
            [UIView setAnimationsEnabled:NO];
            [self initScrollText];
        }else
            [UIView setAnimationsEnabled:YES];
    }];
    
}
#pragma mark - 动态获取左边位置
-(float) getTitleLeft:(CGFloat) i {
    float left = i * K_MAIN_VIEW_SCROLLER_LABLE_MARGIN;
    
    if (i > 0) {
        for (int j = 0; j < i; j ++) {
            GetRoomListModel *model=[self.arrData objectAtIndex:j];
            NSString *goodsName=model.goods_name;
            if (model.goods_name.length==0||model.goods_name==nil) {
                goodsName=@"";
            }
            NSString *   strTitle =[NSString stringWithFormat:@"%@抓到了%@",model.nickname,goodsName] ;
            left += [strTitle length] * K_MAIN_VIEW_SCROLLER_LABLE_WIDTH;
        }
    }
    
    return left;
}

#pragma mark 抓中记录
-(void)btnNewsClick:(UIButton *) sender{
    
    //UIButton *but=sender;
   // GetRoomListModel *model= self.arrData[but.tag];
    //NSLog(@"dsddesd %@",model.goods_name);
    
    WACatchList *focus=[[WACatchList alloc]init];
    focus.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:focus animated:YES];
    
}

-(void)scrollerViewClick:(UITapGestureRecognizer*)gesture{
    
    CGPoint touchPoint = [gesture locationInView:scrollViewText];
    
    for (UIButton *btn in scrollViewText.subviews) {
        
        if ([btn.layer.presentationLayer hitTest:touchPoint]) {
            [self btnNewsClick:btn];
            break;
        }
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    adjustsScrollViewInsets_NO(_mCollection, self);
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //透明
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self scrollViewDidScroll:_mCollection];
    
 
    
}
-(void)viewDidAppear:(BOOL)animated
{
    GetRoomListModel *model=[[GetRoomListModel alloc] init];
    
    model.p=@"1";
    
    [model getRoomListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data,NSDictionary *dic_new) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            GetRoomListModel *model=(GetRoomListModel *)data;
            
            [self stopScrollText];
            self.arrData=[NSArray arrayWithArray:model.data.victory];
            [self initScrollView];
            
            nameSign_news=model.data.turntable.sign_news;
#pragma mark 新人奖励
            
            if ([dic_new[@"is_new"] intValue]==0) {
                WANewPersonPriceView * header = [[WANewPersonPriceView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                header.titleLab.text=dic_new[@"rewardStr"];
                [self.view.window addSubview:header];
            }
            
            
#pragma mark 每日签到
         if ([model.data.turntable.check intValue]==1) {
                if (!header2) {
                    header2 = [[WADailySginIn1 alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                    
                    __weak typeof(self) weakSelf = self;
                    header2.priceBtnBlock = ^(NSInteger type, BOOL is_Repeat) {
                       [weakSelf topBtnEvent:type isrepeat:is_Repeat ];
                    };
                    [header2 getData:nameSign_news];
                    [self.view.window addSubview:header2];
                }
         }
            
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        

        
        [self->_mCollection reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
      
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
  
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar lt_reset];
    [self stopScrollText];
}

- (void)createUI {
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
    _mCollection.collectionViewLayout = mFlowLayout;
    
  //  _mCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-TAB_BAR_HEIGHT) collectionViewLayout:mFlowLayout];
    
    _mCollection.backgroundColor = [UIColor whiteColor];
    _mCollection.delegate = self;
    _mCollection.dataSource = self;
    _mCollection.showsVerticalScrollIndicator = NO;
    _mCollection.showsHorizontalScrollIndicator = NO;
    _mCollection.alwaysBounceVertical = YES;
  //  [self.view addSubview:_mCollection];
    
    
    //Cell
    [_mCollection registerNib:[UINib nibWithNibName:@"WAFirstListCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WAFirstListCell"];
    
    
    top = [[WAFirstViewTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW,320)];
   [_mCollection addSubview:top];
    
    
    
    navView = [[WAFirstNavView alloc] initWithFrame:CGRectMake(40,0, ScreenW-40, 30)];
    self.navigationItem.titleView = navView;
    navView.backgroundColor = [UIColor clearColor];
  //  [navView.btn_exit addTarget:self action:@selector(btn_exitClick) forControlEvents:UIControlEventTouchUpInside];
  //  [navView.btn_guanzhu addTarget:self action:@selector(btn_guanzhuClick) forControlEvents:UIControlEventTouchUpInside];
    
    // [navView.btn_topContent addTarget:self action:@selector(btn_topContentClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view setBackgroundColor:navigationColor];
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 30);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    [lefthBtn setBackgroundColor:[UIColor clearColor]];
    [lefthBtn addTarget:self action:@selector(btn_exitClick) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 退出
-(void)btn_exitClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 关注
-(void)btn_guanzhuClick
{
    // [MBProgressHUD showError:@"关注" toView:self.view];
    WAFirstFocus *focus=[[WAFirstFocus alloc]init];
    focus.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:focus animated:YES];
}
#pragma mark 抓中记录
-(void)btn_topContentClick
{
    WACatchList *focus=[[WACatchList alloc]init];
    focus.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:focus animated:YES];
}
//#pragma mark 每日更新
//-(void)oneBtnClick:(id)sender
//{
//    UIButton *but=(UIButton *)sender;
//    WAfirstItemListView *view=[[WAfirstItemListView alloc]init];
//    view.hidesBottomBarWhenPushed=YES;
//    view.type=[NSString stringWithFormat:@"%d",(int) but.tag-1000];
//    [self.navigationController pushViewController:view animated:YES];
//    
//}
#pragma mark 签到成功
-(void)topBtnEvent:(NSInteger)num  isrepeat:(BOOL)isrepeat
{
    if (isrepeat==NO) {
        [header2 removeFromSuperview];
        WASignInSuccessView *he = [[WASignInSuccessView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        [he getData: nameSign_news[num]];
       
        [self.view.window addSubview:he];
    }
    
}

#pragma mark cycleScrollView delegate
/*
-(void)cycleScrollView:(DCCycleScrollView *)cycleScrollView currentPageIndex:(NSInteger)index
{
    //设置当前页
    self.pageControl.currentPage = index;
}
 */

//点击图片的代理
-(void)cycleScrollView:(DCCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    GetRoomListModel * home = bannerArr[index];
    if (home.merchant_id != nil && ![home.merchant_id isEqualToString:@""] && ![home.merchant_id isEqualToString:@"0"]) {
       
        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
        infor.merchant_id = home.merchant_id;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    if (home.goods_id != nil && ![home.goods_id isEqualToString:@""] && ![home.goods_id isEqualToString:@"0"]) {
      
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = home.goods_id;
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (home.href != nil && ![home.href isEqualToString:@""] && ![home.href isEqualToString:@"0"]) {
     
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"广告链接";
        infor.code_Url = home.href;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
}


#pragma mark UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArr.count;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5+20);
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WAFirstListCell *mCell = [_mCollection dequeueReusableCellWithReuseIdentifier:@"WAFirstListCell" forIndexPath:indexPath];
    mCell.ima_focus.hidden=YES;
    GetRoomListModel *model=dataArr[indexPath.row] ;
    mCell.lab_name.text=model.name;
    mCell.moneyLab.text=model.price;
    
    if ([model.status_ming isEqualToString:@"热抓中"]) {
        [mCell.lab_type setBackgroundColor:[UIColor colorWithRed:254/255.0 green:73/255.0 blue:157/255.0 alpha:1]];
    }
    else
    {
        [mCell.lab_type setBackgroundColor:[UIColor colorWithRed:140/255.0 green:210/255.0 blue:67/255.0 alpha:1]];
    }
    mCell.lab_type.text=model.status_ming;
    
    [mCell.ima_headIcon sd_setImageWithURL:[NSURL URLWithString:model.room_pic]
                          placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    return mCell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section==0) {
        return UIEdgeInsetsMake(320, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GetRoomListModel *model=dataArr[indexPath.row] ;
    if ( model.mac.length!=0) {
    [MBProgressHUD showMessage:nil toView:self.view];
     EnterRoomModel *room=   [[EnterRoomModel  alloc]init];
        room.id=model.id;
        [room EnterRoomModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
            if ([code intValue]==200) {
                [[GCDSocketManager sharedSocketManager]connectToServer:@"192.168.0.4" port:@"7771" complete:^(NSString * _Nonnull result) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    if ([result isEqualToString:@"1"]) {
                        WAInRoom *inroom=[[WAInRoom alloc]init];
                        inroom.hidesBottomBarWhenPushed=YES;
                        inroom.id=model.id;
                        inroom.mac=model.mac;
                        
                        [self.navigationController pushViewController:inroom animated:YES];
                    }
                    else{
                        [MBProgressHUD showError:@"房间连接失败，请稍后再试" toView:self.view];
                    }

                }];
            }
            else
            {  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
               [MBProgressHUD showError:message toView:self.view];
            }


        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];

        }];

    }
    else{
        [MBProgressHUD showError:@"房间编号为空" toView:self.view];

    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = navigationColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];

    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];

    }
//    //获取tableView当前的y偏移
//    CGFloat contentOffsety  = scrollView.contentOffset.y;
//    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
//    if (contentOffsety<=(350-64)&&contentOffsety>=0) {
//        if (KIsiPhoneX) {
//             _mCollection.contentInset = UIEdgeInsetsMake(-54, 0, 0, 0);
//        }
//        else
//        {
//        _mCollection.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
//        }}
//    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
//    else if(contentOffsety>=(350-64)){
//        _mCollection.contentInset  = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
    
//    //获取tableView当前的y偏移
//    CGFloat contentOffsety  = scrollView.contentOffset.y;
//    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
//    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
//        _mCollection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
//    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
//    else if(contentOffsety>=200-64){
//        _mCollection.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
//    }
}
@end

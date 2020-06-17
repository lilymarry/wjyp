//
//  WAInRoom.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/11.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAInRoom.h"
#import "WAInRoomTopView.h"
#import "WAInRoomCell.h"
#import "AShare.h"
#import "WAMoney.h"
#import "WAInRoomPlayerList.h"
#import "WAInRoomNavTopView.h"
#import "WARoomGoods.h"
#import "WARoomCatchFailView.h"
#import "WARoomCatchSuccessView.h"
#import "WANotEnoughMoneyView.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
//#import "WAUserCenterModel.h"
#import "GCDSocketManager.h"
#import "FocusListModel.h"
#import "RoomDataModel.h"
#import "StartGameModel.h"
#import "CatchResultModel.h"
#import "ChangeRoomStatus.h"
#import "SNBannerView.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"
#import "WAMineFriend.h"
@interface WAInRoom ()<UITableViewDelegate,UITableViewDataSource,GCDAsyncSocketDelegate,SNBannerViewDelegate>
//IJKMediaUrlOpenDelegate
{
    
    WAInRoomTopView *top;
    WAInRoomNavTopView *navView;
    BOOL isShow;
    float lastContentOffset;
    
    GCDSocketManager *manager;
    
    NSString *userYinLiang;
    NSString * priceStatus;  //1 余额充足  0余额不足
    NSString * nowStatus;   // 1 用户游戏中  0 无人占用
    
    UIButton * collectBtn;
    NSString * collectStr;
    RoomDataModel *shareData;
    
    NSString *resultStr;//抓中结果
    
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    
    WARoomCatchFailView   *failView;
    WARoomCatchSuccessView *successView;
    
    NSArray *bannerArr;
    NSArray *gDetailsArr;
    NSString *logId;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property(atomic,strong) NSURL *url;
@property(atomic, retain) id<IJKMediaPlayback> player;

@end

@implementation WAInRoom

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WAInRoomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAInRoomCell"];
    
    [self createSMineTopView];
    [self createNav];

    NSString *str =[NSString stringWithFormat:@"{\"cmd\":\"enter_room\",\"mac\":\"%@\"}",_mac];
    [self sendData:str];
    
    [self getRoomDataModel];
}
   
-(void)getRoomDataModel
{
    [MBProgressHUD showMessage:nil toView:self.view];
    RoomDataModel *model=[[RoomDataModel alloc]init];
    model.id=_id;
    [model RoomDataModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            RoomDataModel *model=(RoomDataModel *)data;
            top.room_id_lab.text=[NSString stringWithFormat:@"房间%@",model.data.listA.cid];
            top.spentLab.text=[NSString stringWithFormat:@"%@",model.data.listA.price];
            top.priceLab.text=[NSString stringWithFormat:@"%@",model.data.listA.coin];
            priceStatus=model.data.listA.priceStatus;
            
            nowStatus= model.data.RoomPeople.nowStatus;
            if ([nowStatus intValue]==1) {
                navView.view1.hidden=NO;
                [navView.head1 sd_setImageWithURL:[NSURL URLWithString:model.data.RoomPeople.nowPeople.headPath]];
                navView.nowLab1.text=[NSString stringWithFormat:@"%@\n游戏中",model.data.RoomPeople.nowPeople.nickname];
                
            }
            else
            {
                navView.view1.hidden=YES;
                
                
            }
            navView.nowLab2.text=[NSString stringWithFormat:@"%@人\n在房间",model.data.RoomPeople.peopleNum];
            NSArray *pepleArr=model.data.RoomPeople.headPic;
            if (pepleArr.count>0) {
                if (pepleArr.count==1) {
                    RoomDataModel *subModel=pepleArr[0];
                    [navView.head2 sd_setImageWithURL:[NSURL URLWithString:subModel.head_pic]];
                }
                
                else if (pepleArr.count==2) {
                    RoomDataModel *subModel=pepleArr[0];
                    [navView.head2 sd_setImageWithURL:[NSURL URLWithString:subModel.head_pic]];
                    
                    RoomDataModel *subModel1=pepleArr[1];
                    [navView.head3 sd_setImageWithURL:[NSURL URLWithString:subModel1.head_pic]];
                }
                else  if (pepleArr.count==3) {
                    RoomDataModel *subModel=pepleArr[0];
                    [navView.head2 sd_setImageWithURL:[NSURL URLWithString:subModel.head_pic]];
                    
                    RoomDataModel *subModel1=pepleArr[1];
                    [navView.head3 sd_setImageWithURL:[NSURL URLWithString:subModel1.head_pic]];
                    
                    RoomDataModel *subModel2=pepleArr[2];
                    [navView.head4 sd_setImageWithURL:[NSURL URLWithString:subModel2.head_pic]];
                }
            }
            collectStr=model.data.status;
            if ([model.data.status intValue]==0) {
                [ collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
            }
            else
            {
                [ collectBtn setImage:[UIImage imageNamed:@"已收藏"] forState:UIControlStateNormal];
            }
            
            shareData=model.data.toShare;
            
            [top getData:model.data.listB];
            
            SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(10, 0, ScreenW-20,144) delegate:self model:model.data.ads URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
            [top.bannerView addSubview:banner];
            bannerArr = model.data.ads;
            gDetailsArr =model.data.gDetails;
            
        }
        [_mTable reloadData];
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        
    }] ;
}
#pragma mark - 轮播广告
- (void)bannerView:(SNBannerView *)bannerView didSelectImageIndex:(NSInteger)index {
    RoomDataModel * home = bannerArr[index];
    if (home.merchant_id != nil && ![home.merchant_id isEqualToString:@""] && ![home.merchant_id isEqualToString:@"0"]) {
        
        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
        infor.merchant_id = home.merchant_id;
        
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    if (home.goods_id != nil && ![home.goods_id isEqualToString:@""] && ![home.goods_id isEqualToString:@"0"]) {
        
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = home.goods_id;
        info.overType = NULL;
        
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (home.href != nil && ![home.href isEqualToString:@""] && ![home.href isEqualToString:@"0"]) {
        
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"广告链接";
        infor.code_Url = home.href;
        
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    
}
-(void)sendData:(NSString *)cmdStr
{
    
    const char *string =[cmdStr UTF8String];
    Byte *byte = malloc(sizeof(3+strlen(string)));
    byte[0] = 0xda;
    byte[1] =(Byte) strlen(string)/256;
    byte[2] =(Byte) strlen(string)%256;
    
    NSMutableData *mutData=[[NSMutableData alloc]init];
    [mutData appendBytes:byte length:3];
    [ mutData appendData:[cmdStr dataUsingEncoding:NSUTF8StringEncoding]];
    [[GCDSocketManager sharedSocketManager]sendMessage:mutData complete:^(NSData * _Nonnull data) {
        Byte * testByte=(Byte *)[data  bytes];
        NSMutableString *str=[NSMutableString string];
        for(int i = 1;i<[data length]-1;i++)
        {
            [str appendString:[NSString stringWithFormat:@"%c",testByte[i]]];
            
        }
    
        NSRange range = [str rangeOfString:@"game_ret"];
        
        if (range.location != NSNotFound) {
            
            
            NSString *str3 =[str substringFromIndex:range.location+range.length+8];
            resultStr=str3;
            
            if ([str3 intValue]==0) {
                failView = [[WARoomCatchFailView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                [failView.twoBtn setTitle:@"再来一次(10)" forState:UIControlStateNormal];
                [failView.twoBtn addTarget:self action:@selector(repeatBtnPress) forControlEvents:UIControlEventTouchUpInside];
                
                [failView.exitBtn addTarget:self action:@selector(exitPress) forControlEvents:UIControlEventTouchUpInside];
                [failView.oneBtn addTarget:self action:@selector(exitPress) forControlEvents:UIControlEventTouchUpInside];
                [self.view.window addSubview:failView];
                
            }
            else
            {
                successView = [[WARoomCatchSuccessView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                [successView.repeatBtn setTitle:@"再来一次(10)" forState:UIControlStateNormal];
                [successView.repeatBtn addTarget:self action:@selector(repeatBtnPress) forControlEvents:UIControlEventTouchUpInside];
                [successView.exitBtn addTarget:self action:@selector(exitPress) forControlEvents:UIControlEventTouchUpInside];
                [successView.helpBtn addTarget:self action:@selector(helpBtnPress) forControlEvents:UIControlEventTouchUpInside];
                [self.view.window addSubview:successView];
                
            }
            
            [countDownTimer invalidate];
            top.timeBtn.hidden=YES;
            secondsCountDown = 10;//6秒倒计时
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            
            [self sendCatchResult:str3];
            
            _mTable.scrollEnabled=YES;
          
            self->top.twoView.hidden=YES;
            self->top.oneView.hidden=NO;
            self->top.moreBtn.hidden=NO;
          //  [self getRoomDataModel];
 
        }
    }];
}
-(void)timeFireMethod{
    //倒计时-1
    secondsCountDown--;
    //修改倒计时标签现实内容
    if ([resultStr intValue]==0) {
        [failView.twoBtn setTitle:[NSString stringWithFormat:@"再来一次(%d)",secondsCountDown] forState:UIControlStateNormal];
    }
    else   if ([resultStr intValue]==1)
    {
        [successView.repeatBtn setTitle:[NSString stringWithFormat:@"再来一次(%d)",secondsCountDown] forState:UIControlStateNormal];
    }
    else
    {
        [top.timeBtn setTitle:[NSString stringWithFormat:@"%ds",secondsCountDown] forState:UIControlStateNormal];
 
    }
    
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        if ([resultStr intValue]==0) {
            failView.oneBtnWW.constant=200;
            failView.twoBtnWW.constant=0;
            failView.twoBtn.hidden=YES;
            
            [self exitPress];
            
        }
        else   if ([resultStr intValue]==1) {
            
            successView.helpBtnWW.constant=200;
            successView.repeatBtnww.constant=0;
            successView.repeatBtn.hidden=YES;
            
            [self exitPress];
            
        }
        else{
            top.timeBtn.hidden=YES ;
            [self sendData:@"{\"cmd\":\"operation\",\"type\":4}"];
            
        }
    }
}
-(void)repeatBtnPress
{
    if ([resultStr intValue]==0) {
        [failView removeFromSuperview];
    }
    else
    {
        [successView removeFromSuperview];
    }
    [countDownTimer invalidate];
    
    [self startCatch];
    
}
-(void)exitPress
{
    if ([resultStr intValue]==0) {
        [failView removeFromSuperview];
    }
    else
    {
        [successView removeFromSuperview];
    }
    
    ChangeRoomStatus *room=[[ChangeRoomStatus alloc]init];
    room.cid=_id;
    room.type=@"1";
    [room ChangeRoomStatusSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        if ([code intValue]==200) {
               navView.view1.hidden=YES;
        }
      NSLog(@"%@",code);
    } andFailure:^(NSError * _Nonnull error) {

    }];
    
    
}
-(void)helpBtnPress
{
    if ([resultStr intValue]==0) {
        [failView removeFromSuperview];
    }
    else
    {
        [successView removeFromSuperview];
    }
    ChangeRoomStatus *room=[[ChangeRoomStatus alloc]init];
    room.cid=_id;
    room.type=@"1";
    [room ChangeRoomStatusSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        WAMineFriend *list=[[WAMineFriend alloc]init];
        list.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:list animated:YES];
    } andFailure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)sendCatchResult:(NSString *)result
{
  
    CatchResultModel *model=[[CatchResultModel alloc]init];
    model.mode=result;
    model.logId=logId;
    [model CatchResultModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        NSLog(@"sendCatchResult: %@",message);
    } andFailure:^(NSError * _Nonnull error) {
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *version= [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
        adjustsScrollViewInsets_NO(_mTable, self);
    }
  
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //透明
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self scrollViewDidScroll:_mTable];
    [self installMovieNotificationObservers];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar lt_reset];
    [self.player shutdown];
    
    [self sendData:@"{\"cmd\":\"exit_room\"}"];
    
    [[GCDSocketManager sharedSocketManager]cutOffSocket];
    [self removeMovieNotificationObservers];
    
    [countDownTimer invalidate];
    
    //退出房间
    ChangeRoomStatus *room=[[ChangeRoomStatus alloc]init];
    room.cid=_id;
    room.type=@"2";
    [room ChangeRoomStatusSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        NSLog(@"%@",code);
        
    } andFailure:^(NSError * _Nonnull error) {
        
    }];
    
}
- (void)createSMineTopView {
   
    if (KIsiPhoneX) {
     
        if (@available(iOS 11.0, *)) {
        top = [[WAInRoomTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH+115+16+144-[UIApplication sharedApplication] .delegate.window.safeAreaInsets.bottom-24)];
        top.MainCatchViewHHH.constant=ScreenH-[UIApplication sharedApplication] .delegate.window.safeAreaInsets.bottom-24;
        } else {

        }


    }
    else
    {
        top = [[WAInRoomTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH+115+16+144)];
        
        top.MainCatchViewHHH.constant=ScreenH;
        
    }
    
    top.twoView.hidden=YES;
    top.oneView.hidden=NO;
    
    [top.moreBtn addTarget:self action:@selector(topBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [top.startBtn addTarget:self action:@selector(startCatch) forControlEvents:UIControlEventTouchUpInside];
    [top.shareBtn addTarget:self action:@selector(toShare) forControlEvents:UIControlEventTouchUpInside];
    
    [top.chargBtn addTarget:self action:@selector(toChargeMoney) forControlEvents:UIControlEventTouchUpInside];
    
    [top.startCatchBtn addTarget:self action:@selector(toCatch) forControlEvents:UIControlEventTouchUpInside];
    
    [top.cameraBtn addTarget:self action:@selector(tochangeCamera) forControlEvents:UIControlEventTouchUpInside];
    
    top.cameraBtn .selected=YES;
    
    [self getMoviePlayerController: [NSString stringWithFormat:@"rtmp://pili-publish.aoquzhuwawa.dx1ydb.com/aoquwawaji003/%@_1",_mac]];
    
    
    __weak typeof(self) weakSelf = self;
    top.tapOrientaBlock = ^(NSInteger type) {
        [weakSelf tapOrientation:type];
    };
    
    _mTable.tableHeaderView = top;
    
}
-(void)tochangeCamera
{
    top.cameraBtn .selected=! top.cameraBtn .selected;
    NSString *url;
    if (top.cameraBtn .selected) {
        url= [NSString stringWithFormat:@"rtmp://pili-publish.aoquzhuwawa.dx1ydb.com/aoquwawaji003/%@_1",_mac];
    }
    else
    {
        url=   [NSString stringWithFormat:@"rtmp://pili-publish.aoquzhuwawa.dx1ydb.com/aoquwawaji003/%@_2",_mac];
    }
    [self.player shutdown];
    [self.player.view removeFromSuperview];
    
    [self getMoviePlayerController:url];
    
    
}
-(void)getMoviePlayerController:(NSString *)url
{
#ifdef DEBUG
    [IJKFFMoviePlayerController setLogReport:YES];
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_DEBUG];
#else
    [IJKFFMoviePlayerController setLogReport:NO];
    [IJKFFMoviePlayerController setLogLevel:k_IJK_LOG_INFO];
#endif
    
    [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];
    // [IJKFFMoviePlayerController checkIfPlayerVersionMatch:YES major:1 minor:0 micro:0];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setFormatOptionValue:@"ijktcphook" forKey:@"http-tcp-hook"];
    
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url] withOptions:options];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = top.videoView.frame;
    
    self.player.scalingMode = IJKMPMovieScalingModeAspectFill;
    self.player.shouldAutoplay = YES;
    
    self.player.view.backgroundColor=[UIColor clearColor];
    
    [top.videoView addSubview:self.player.view];
    
    [self.player prepareToPlay];
}
-(void)tapOrientation:(NSInteger )typed
{
    
    NSString * str=[NSString stringWithFormat:@"{\"cmd\":\"operation\",\"type\":%d}",(int)typed];
    
    [self sendData:str];
    
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 30);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    [lefthBtn setBackgroundColor:[UIColor clearColor]];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(0, 0, 35, 35);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
    [collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    collectBtn.layer.masksToBounds = YES;
    collectBtn.layer.cornerRadius = collectBtn.frame.size.width/2;
    collectBtn.layer.borderWidth = 0.1;
    collectBtn.layer.borderColor =[UIColor clearColor].CGColor;
    collectBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
    [collectBtn setBackgroundColor: [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
    [collectBtn addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     UIButton *  rightBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
     rightBtn_sub.frame = CGRectMake(0, 0, 35, 30);
     rightBtn_sub.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
     rightBtn_sub.titleLabel.textAlignment = NSTextAlignmentCenter;
     rightBtn_sub.layer.masksToBounds = YES;
     rightBtn_sub.layer.cornerRadius = rightBtn_sub.frame.size.width/2;
     rightBtn_sub.layer.borderWidth = 0.1;
     rightBtn_sub.layer.borderColor =[UIColor clearColor].CGColor;
     NSString *str3 =@"更换";
     NSString *str4 =@"房间";
     NSMutableAttributedString * AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str3,str4]];
     [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0 , str3.length+str4.length+1)];
     [rightBtn_sub setAttributedTitle:AttributedStr1 forState:UIControlStateNormal];
     rightBtn_sub.titleLabel.font = [UIFont systemFontOfSize: 10.0];
     [rightBtn_sub setBackgroundColor: [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
     UIBarButtonItem * rightBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:rightBtn_sub];
     rightBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-25);
     [rightBtn_sub addTarget:self action:@selector(exChangeRoom) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.rightBarButtonItems = @[rightBtnItem,rightBtnItem_sub];
     */
    self.navigationItem.rightBarButtonItems = @[rightBtnItem];
    navView = [[WAInRoomNavTopView alloc] initWithFrame:CGRectMake(0,0, 180, 40)];
    [navView.playerListBtn addTarget:self action:@selector(playerList) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = navView;
    navView.backgroundColor = [UIColor clearColor];
    
}


#pragma 返回
-(void)lefthBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark 收藏
-(void)collectBtnClick
{
    [MBProgressHUD showMessage:nil toView:self.view];
    FocusListModel *model=[[FocusListModel alloc]init];
    model.cid=_id;
    if ([collectStr intValue]==1) {
        model.status=@"0";
    }
    else
    {
        model.status=@"1";
    }
    [model AddFocusModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:message toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([code intValue] ==200) {
                [self getRoomDataModel];
            }
        });
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
    
}
#pragma  mark 更换房间
-(void)exChangeRoom
{
    [MBProgressHUD showError:@"更换房间" toView:self.view];
}
#pragma mark 玩家列表
-(void)playerList
{
    WAInRoomPlayerList *list =[[WAInRoomPlayerList alloc]init];
    list.cid=_id;
    [self.navigationController pushViewController:list animated:YES];
    
}
#pragma mark 点击更多
-(void)topBtnEvent
{
    isShow=YES;
    _mTable.scrollEnabled=YES;
    
    [_mTable setContentOffset:CGPointMake(0,ScreenH-NAVIGATION_BAR_HEIGHT) animated:YES];
    
}

#pragma mark 抓取页视图
-(void)startCatch
{
   // [self getRoomDataModel];
    //余额不足
    if ([priceStatus intValue]==0) {
        WANotEnoughMoneyView *enough=[[WANotEnoughMoneyView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        __weak typeof(self) weakSelf = self;
        enough.topBtnBlock = ^{
            WAMoney *money=[[WAMoney alloc]init];
            [self.navigationController pushViewController:money animated:YES];
        };
        [weakSelf.view.window addSubview:enough];
    }
    else
    {

        StartGameModel *model=[[StartGameModel alloc]init];
        model.id=_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [model startGameModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([code intValue]==200) {
        
             
               [_mTable setContentOffset:CGPointMake(0,0) animated:YES];
               _mTable.scrollEnabled=NO;
                
                StartGameModel *model=(StartGameModel *)data;
                if ( [model.data.status intValue]==1) {
                    
                    navView.view1.hidden=NO;
                    [navView.head1 sd_setImageWithURL:[NSURL URLWithString:model.data.nowUser.head_pic]];
                    navView.nowLab1.text=[NSString stringWithFormat:@"%@\n游戏中",model.data.nowUser.nickname];
                    top.priceLab.text=[NSString stringWithFormat:@"余额%@两",model.data.silver];
                    logId=model.data.logId;
                    top.twoView.hidden=NO;
                    top.oneView.hidden=YES;
                    top.moreBtn.hidden=YES;
                    
                  [self sendData:@"{\"cmd\":\"start_game\"}"];
                    resultStr=@"3";
                    top.timeBtn.hidden=NO;
                    [top.timeBtn setTitle:@"60s" forState:UIControlStateNormal];
                    secondsCountDown = 59;
                    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                    
                }
                else
                {
                    [MBProgressHUD showSuccess:message toView:self.view];

                }
            }
            else
            {
                [MBProgressHUD showSuccess:message toView:self.view];
            }
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
}
#pragma mark 开始抓取
-(void)toCatch
{
    [self sendData:@"{\"cmd\":\"operation\",\"type\":4}"];
    
}
#pragma mark 分享
-(void)toShare
{
    AShare * shareVC = [[AShare alloc] init];
    shareVC.thisUrl = shareData.url;
    shareVC.thisImage = shareData.pic;
    shareVC.thisTitle = shareData.title;
    shareVC.thisContent = shareData.content;
    shareVC.thisType = shareData.Shapetype;
    shareVC.id_val = shareData.id;
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:shareVC animated:YES completion:nil];
    shareVC.AShare_back = ^{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    };
}
#pragma mark 充钱
-(void)toChargeMoney
{
    WAMoney *money=[[WAMoney alloc]init];
    money.presentingView=NO;
    [self.navigationController pushViewController:money animated:YES];
}
#pragma mark tableViewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return gDetailsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WAInRoomCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAInRoomCell" forIndexPath:indexPath];
    
    RoomDataModel *model=gDetailsArr[indexPath.row];
    
    [cell.heaImaView sd_setImageWithURL:[NSURL URLWithString:model.goods_pic]
                       placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    cell.nameLab.text=model.goods_name;
    cell.numlab.text=[NSString stringWithFormat:@"需抓中%@次",model.num];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  239 ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WARoomGoods *he = [[WARoomGoods alloc] initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH)];
    
    [self.view.window addSubview:he];
}
#pragma mark scrollViewdelegate
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
     NSString *version= [UIDevice currentDevice].systemVersion;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
        if (KIsiPhoneX) {
             _mTable.contentInset = UIEdgeInsetsMake(-88, 0, 0, 0);
        }
        else
        {
            if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
                _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }
            else
            {
                _mTable.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);

            }
       }
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=200-64){
        if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
              _mTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        }
        else
        {
            _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    lastContentOffset = scrollView.contentOffset.y;
}
- (void)loadStateDidChange:(NSNotification*)notification
{
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
        {
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            [MBProgressHUD showError:@"视频加载错误" toView:self.view];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
        }
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

#pragma mark Install Movie Notifications

/* Register observers for the various movie object notifications. */
-(void)installMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

#pragma mark Remove Movie Notification Handler
/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}

@end

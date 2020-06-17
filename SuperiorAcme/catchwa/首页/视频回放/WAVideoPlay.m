//
//  WAVideoPlay.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAVideoPlay.h"
#import "AShare.h"
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
#import "AppDelegate.h"
#import <Masonry.h>
@interface WAVideoPlay ()
@property (nonatomic, strong) SelVideoPlayer *player;
@end

@implementation WAVideoPlay

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"视频回放"];
    [self CreatNavigationBar];
    
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkNetWork:) name:@"monitorNetworking" object:nil];
    
    [self monitorNetworking];
    
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = YES;
    configuration.supportedDoubleTap = YES;
    configuration.shouldAutorotate = YES;
    configuration.repeatPlay = NO;
    configuration.statusBarHideState = SelStatusBarHideStateFollowControls;
    configuration.sourceUrl = [NSURL URLWithString:_playUrl];
    //@"http://200024424.vod.myqcloud.com/200024424_709ae516bdf811e6ad39991f76a4df69.f20.mp4"
    configuration.videoGravity = SelVideoGravityResizeAspect;
    
    _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(0, 100, ScreenW, 300) configuration:configuration];
    [self.view addSubview:_player];
    [_player _pauseVideo];
    
    
}

-(void)checkNetWork:(NSNotification *)Info
{
    NSDictionary *dic=Info.object;
    if ([dic[@"key"]isEqualToString:@"2"]) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"处于非WIFI,是否继续播放" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self->_player _playVideo];
            
        }];
        [alertVC addAction:cancelAction];
        [alertVC addAction:OKAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}
-(void)CreatNavigationBar{
    
    UIBarButtonItem * rightBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStyleDone target:self action:@selector(toShare)];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
}
-(void)toShare
{
    AShare * shareVC = [[AShare alloc] init];
   
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:shareVC animated:YES completion:nil];
    shareVC.AShare_back = ^{
    
    };
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_player _deallocPlayer];
}
#pragma mark - ------------- 监测网络状态 -------------
- (void)monitorNetworking
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"网络不可达");
                break;
            case 1:
            {
                NSLog(@"GPRS网络");
                [[NSNotificationCenter defaultCenter]postNotificationName:@"monitorNetworking" object:@{@"key":@"2"}];
            }
                break;
            case 2:
            {
                NSLog(@"wifi网络");
                [self->_player _playVideo];
            }
                break;
            default:
                break;
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
         }else{
             UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络已关闭，请打开网络" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 
             }];
            
             [alertVC addAction:OKAction];
             [self presentViewController:alertVC animated:YES completion:nil];
        }
    }];
}
@end

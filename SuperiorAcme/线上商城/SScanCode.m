//
//  SScanCode.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SScanCode.h"
#import "ScanerView.h"
#import "SMessageInfor.h"
#import "SlineDetailWebController.h"
#import "SPayForMerchantController.h"
@interface SScanCode () <AVCaptureMetadataOutputObjectsDelegate,CAAnimationDelegate>
{
    NSString * QRCodeString;//扫描结果
}

//@property (nonatomic, strong) VFCenterTool * centerTool;

//! 扫码区域动画视图
@property (strong, nonatomic)  ScanerView *scanerView;

//AVFoundation
//! AV协调器
@property (strong,nonatomic) AVCaptureSession           *session;
//! 取景视图
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *previewLayer;


@end

@implementation SScanCode

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    self.scanerView.alpha = 0;
    //设置扫描区域边长
    self.scanerView.scanAreaEdgeLength = [[UIScreen mainScreen] bounds].size.width - 2 * 50;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"扫一扫";
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
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!self.session){
        
        //添加镜头盖开启动画
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.type = @"cameraIrisHollowOpen";
        animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        animation.delegate = self;
        [self.view.layer addAnimation:animation forKey:@"animation"];
        
        //初始化扫码
        [self setupAVFoundation];
        
        //调整摄像头取景区域
        self.previewLayer.frame = self.view.bounds;
        
        //调整扫描区域
        AVCaptureMetadataOutput *output = self.session.outputs.firstObject;
        //        //根据实际偏差调整y轴
        CGRect rect = CGRectMake((self.scanerView.scanAreaRect.origin.y + 20) / HEIGHT(self.scanerView),
                                 self.scanerView.scanAreaRect.origin.x / WIDTH(self.scanerView),
                                 self.scanerView.scanAreaRect.size.height / HEIGHT(self.scanerView),
                                 self.scanerView.scanAreaRect.size.width / WIDTH(self.scanerView));
        output.rectOfInterest = rect;
    } else {
        
        _scanerView = [[ScanerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//        self.scanerView.alpha = 0;
        self.scanerView.scanAreaEdgeLength = [[UIScreen mainScreen] bounds].size.width - 2 * 50;
        [self.view addSubview:_scanerView];
        //开始扫码
        [self.session startRunning];
    }
}

//! 动画结束回调
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    
    [MBProgressHUD hideHUDForView:self.view];
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.scanerView.alpha = 1;
                     }];
}

//! 初始化扫码
- (void)setupAVFoundation{
    //创建会话
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    //获取摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if(input) {
        [self.session addInput:input];
    } else {
        //出错处理
        //        SNLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"请在手机【设置】-【隐私】-【相机】选项中，允许【%@】访问您的相机",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];

        }]];
        [self presentViewController:alertController animated:YES completion:nil];

        return;
    }
    
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [self.session addOutput:output];
    
    //设置扫码类型
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,  //条形码
                                   AVMetadataObjectTypeEAN13Code,
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeCode128Code];
    
    //    //设置扫码类型
    //    output.metadataObjectTypes = @[AVMetadataObjectTypeUPCECode,
    //                                   AVMetadataObjectTypeCode39Code,
    //                                   AVMetadataObjectTypeCode39Mod43Code,
    //                                   AVMetadataObjectTypeEAN13Code,
    //                                   AVMetadataObjectTypeEAN8Code,
    //                                   AVMetadataObjectTypeCode93Code,
    //                                   AVMetadataObjectTypeCode128Code,
    //                                   AVMetadataObjectTypePDF417Code,
    //                                   AVMetadataObjectTypeQRCode,
    //                                   AVMetadataObjectTypeAztecCode,
    //                                   AVMetadataObjectTypeInterleaved2of5Code,
    //                                   AVMetadataObjectTypeITF14Code,
    //                                   AVMetadataObjectTypeDataMatrixCode];
    
    //设置代理，在主线程刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //创建摄像头取景区域
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    if ([self.previewLayer connection].isVideoOrientationSupported)
        [self.previewLayer connection].videoOrientation = AVCaptureVideoOrientationPortrait;
    
    //开始扫码
    [self.session startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjects Delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    for (AVMetadataMachineReadableCodeObject *metadata in metadataObjects) {
        //        NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        //        QRCodeString = [[NSString alloc] initWithCString:[metadata.stringValue cStringUsingEncoding:enc] encoding:NSUTF8StringEncoding];
        QRCodeString = metadata.stringValue;
        //声音
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"scan.wav" withExtension:nil];
        SystemSoundID soundID = 0;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        AudioServicesPlaySystemSound(soundID);
        [self.session stopRunning];
        
    
        NSData *jsonData = [QRCodeString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
       if (dic == nil)
        {
            //注册 或者 直接访问URL
            NSString *url = @"";
            NSString *title = @"";
            NSRange range = [QRCodeString rangeOfString:@"User/mentorship"];
            if (range.location != NSNotFound) {
                title = @"拜师码";
                if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    SLand * land = [[SLand alloc] init];
                    UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                    [UIApplication sharedApplication].delegate.window.rootViewController = landNav;
                } else {
                    NSString *token = [[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token;
                    url = [NSString stringWithFormat:@"%@/token/%@", QRCodeString, token];
                }
            } else {
                NSRange range = [QRCodeString rangeOfString:@"Wap/OfflineStore/confirmation/stage_merchant_id"];
                if (range.location != NSNotFound) {
                    //商家码去付款
                    SPayForMerchantController * payvc = [[SPayForMerchantController alloc] init];
                    payvc.url = QRCodeString;
                    [self.navigationController pushViewController:payvc animated:YES];
                    return;
                } else {
               
                    url = QRCodeString;
                }
            }
                    SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
                    conter.fag=@"2";
                    conter.urlStr=url;
                    [self.navigationController pushViewController:conter animated:YES];
                    [_scanerView removeFromSuperview];
      
        }
  
        
//        NSLog(@"%@",QRCodeString);
//        NSRange range = [QRCodeString rangeOfString:@"pay_money/pm_id"];
//        if (range.location == NSNotFound)
//        {
//            SMessageInfor * infor = [[SMessageInfor alloc] init];
//            infor.type = @"二维码";
//            infor.code_Url = QRCodeString ;
//            [self.navigationController pushViewController:infor animated:YES];
//            [_scanerView removeFromSuperview];
//            
//        }else {
//            
//            SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
//            conter.fag=@"2";
//            conter.urlStr=QRCodeString;
//              [self.navigationController pushViewController:conter animated:YES];
//            [_scanerView removeFromSuperview];
//            
//        }
      
//        NSString *regex = @"^[0-9]*$";
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//        if ([predicate evaluateWithObject:QRCodeString] != YES) {
//            [UIView animateWithDuration:0.3 animations:^{
//                [MBProgressHUD showError:@"无界优品二维码有误" toView:self.view];
//
//            } completion:^(BOOL finished) {
//                //开始扫码
//                [self.session startRunning];
//            }];
//
//        } else {
////            PHomeInforVC * infor = [[PHomeInforVC alloc] init];
////            infor.shop_id = QRCodeString;
////            infor.hidesBottomBarWhenPushed = YES;
////            [self.navigationController pushViewController:infor animated:YES];
//        }
        
        //        if (QRCodeString.length) {
        //            __weak typeof(self) weakSelf = self;
        //            [self alertWithtitle:nil message:@"是否绑定代理关系?" cancelButtonTitle:@"取消" othersButtonTitles:@[@"确认"] handler:^(NSString *actionTitle) {
        //                if ([actionTitle isEqualToString:@"确认"]) {
        //                    [MBProgressHUD showMessage:nil toView:weakSelf.view];
        //                    weakSelf.centerTool.m_id = [VFUserTool shareUserTool].user.data.m_id;
        //                    weakSelf.centerTool.s_id = QRCodeString;
        //                    [weakSelf.centerTool sweepSuccess:^(id success) {
        //                        VFSweep * sweep = (VFSweep *)success;
        //                        if ([sweep.flag isEqualToString:@"success"]) {
        //                            [MBProgressHUD showSuccess:sweep.message toView:weakSelf.view];
        //                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //                                [weakSelf.navigationController popViewControllerAnimated:YES];
        //                            });
        //                        } else {
        //                            [MBProgressHUD showError:sweep.message toView:weakSelf.view];
        //                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //                                [weakSelf.session startRunning];
        //                            });
        //                        }
        //                    } failure:^(NSString *errorDescribtion) {
        //                        [MBProgressHUD showError:errorDescribtion toView:weakSelf.view];
        //                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //                            [weakSelf.session startRunning];
        //                        });
        //                    }];
        //                } else {
        //                    [weakSelf.session startRunning];
        //                }
        //            }];
        //        } else {
        //            [MBProgressHUD showError:@"扫描结果错误" toView:self.view];
        //        }
        //二维码
        //        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
        //            [self.session stopRunning];
        
        //            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"二维码"
        //                                                        message:metadata.stringValue
        //                                                       delegate:self
        //                                              cancelButtonTitle:@"OK"
        //                                              otherButtonTitles: nil];
        //            [av show];
        
        //            break;
        //条形码
        //        }else{
        //            [self.session stopRunning];
        
        //            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"条形码"
        //                                                        message:metadata.stringValue
        //                                                       delegate:self
        //                                              cancelButtonTitle:@"OK"
        //                                              otherButtonTitles: nil];
        //            [av show];
        
        //            break;
        //        }
    }
}

- (ScanerView *)scanerView {
    if (!_scanerView) {
        _scanerView = [[ScanerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        [self.view addSubview:_scanerView];
    }
    return _scanerView;
}

@end

//
//  NotificationService.m
//  JpushTest
//
//  Created by 天津沃天科技 on 2018/10/12.
//  Copyright © 2018年 GYM. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVSpeechSynthesis.h>
#import <MediaPlayer/MediaPlayer.h>

#import "NotificationService.h"

#import "JPushNotificationExtensionService.h"
//#import "PrintOderModel.h"
#import "SEPrinterManager.h"

#import "AFNetworking.h"
#import <AudioToolbox/AudioToolbox.h>

@interface NotificationService ()<AVSpeechSynthesizerDelegate>
@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@property (nonatomic, strong) NSDictionary *printData;
@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    self.bestAttemptContent.sound =  [UNNotificationSound defaultSound];
   // NSLog(@"AAAA %@", self.bestAttemptContent.userInfo);
    
    NSDictionary *dic=self.bestAttemptContent.userInfo;
    _printData=dic;

    if ([dic[@"sound"]intValue]==1) {
         [self syntheticVoice: dic[@"title"]];
//
//        if (@available(iOS 12.1, *)) {
//            if ([dic[@"module"]isEqualToString:@"stage_order"]) {
//            //播放固定音频(实质是自定义铃声)
//            NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"caf"];
//            NSURL *soundURL = [NSURL fileURLWithPath:soundFilePath];
//            SystemSoundID soundID;
//            AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundID);
//            AudioServicesPlaySystemSound(soundID);
//            }
//        }else{
//            //播放合成音效
//            [self syntheticVoice: dic[@"title"]];
//        }
    }
    if ([dic[@"module"]isEqualToString:@"stage_order_auto"]||[dic[@"module"]isEqualToString:@"stage_order_hand"]) {

    if ([dic[@"module"]isEqualToString:@"stage_order_auto"]) {
        NSDictionary *data=dic[@"data_print"];
        [self printOrderSN:data[@"order_sn"] merchant_id:data[@"merchant_id"]];
    }
    if([dic[@"module"]isEqualToString:@"stage_order_hand"])
    {
           [self lineBluePrint];
    }
    }
  
   [self apnsDeliverWith:request];
    
    
    //    NSURLSession * session = [NSURLSession sharedSession];
    //    NSString * attachmentPath = self.bestAttemptContent.userInfo[@"url"];
    //    //if exist
    //    if (attachmentPath ) {
    //        //download
    //        NSURLSessionTask * task = [session dataTaskWithURL:[NSURL URLWithString:attachmentPath] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    //            if (data) {
    //                NSString * localPath = [NSString stringWithFormat:@"%@/myAttachment.png", NSTemporaryDirectory()];
    //                if ([data writeToFile:localPath atomically:YES]) {
    //                    UNNotificationAttachment * attachment = [UNNotificationAttachment attachmentWithIdentifier:@"myAttachment" URL:[NSURL fileURLWithPath:localPath] options:nil error:nil];
    //                    self.bestAttemptContent.attachments = @[attachment];
    //                }
    //            }
    //            [self apnsDeliverWith:request];
    //        }];
    //        [task resume];
    //    }else{
    //        [self apnsDeliverWith:request];
    //    }
}

- (void)apnsDeliverWith:(UNNotificationRequest *)request {
    
    [JPushNotificationExtensionService jpushSetAppkey:@"8ca752e9c56ad02dc93990f9"];
    [JPushNotificationExtensionService jpushReceiveNotificationRequest:request with:^ {
        NSLog(@"apns upload success");
        self.contentHandler(self.bestAttemptContent);
    }];
}

- (void)serviceExtensionTimeWillExpire {
    self.contentHandler(self.bestAttemptContent);
}
- (void)syntheticVoice:(NSString*)string {//  语音合成
    
    
    AVSpeechSynthesizer * synthsizer = [[AVSpeechSynthesizer alloc] init];
    synthsizer.delegate = self;
    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc] initWithString:string];//需要转换的文本
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//国家语言
    utterance.rate = 0.5f;//声速
    utterance.volume = 1;
//    //修改播放时的音量 根据自己的需要来定
//    MPMusicPlayerController* musicController = [MPMusicPlayerController applicationMusicPlayer];
//    ////0.0~1.0
//    musicController.volume = 0.7;
    [synthsizer speakUtterance:utterance];
}

#pragma mark ----AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"----开始播放");
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance{
    NSLog(@"---完成播放");
}
-(void)printOrderSN:(NSString *)order_sn  merchant_id:(NSString *)merchant_id
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer.timeoutInterval = 60.0;
    //设置响应内容的类型
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.www.wujiemall.com"];
    NSString *token=[userDefaults objectForKey:@"token"];
   
    if (token.length>0) {
        [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        
    } else {
        [session.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];
    }
  
    NSString *Url_header=[userDefaults objectForKey:@"Url_header"];
    
    NSString *urlstr=[NSString stringWithFormat:@"http://%@.wujiemall.com/index.php/Api/Index/index",Url_header];
    
    [session POST:urlstr parameters:@{@"order_sn":order_sn,@"merchant_id":merchant_id} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic=(NSDictionary *)responseObject;
        if ([dic[@"code"] intValue]==1) {
             [self lineBluePrint];
        }
        else
        {
            NSLog(@"请求失败");
        }
        NSLog(@"请求成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];

}
//连接蓝牙
-(void)lineBluePrint
{
    //NSString  *uuid=  [SEPrinterManager UUIDStringForLastPeripheral];
    SEPrinterManager *_manager = [SEPrinterManager sharedInstance];
    [_manager startScanPerpheralTimeout:10 Success:^(NSArray<CBPeripheral *> *perpherals,BOOL isTimeout) {
        NSLog(@"perpherals:%@",perpherals);
        if (perpherals.count>0) {
             [self PrintWithperpherals:perpherals[0]];
        }
        
    } failure:^(SEScanError error) {
        NSLog(@"error:%ld",(long)error);
    }];
}
-(void)PrintWithperpherals:(CBPeripheral *)peripheral
{
    NSLog(@"打印");

    [[SEPrinterManager sharedInstance] fullOptionPeripheral:peripheral completion:^(SEOptionStage stage, CBPeripheral *perpheral, NSError *error) {
        if (stage == SEOptionStageSeekCharacteristics) {
           
            int inte= [ self->_printData[@"data_print"][@"receipt"] intValue];
            
            if (inte>0) {
                for (int i=0; i<inte; i++) {
                    HLPrinter *printer = [self getPrinter];
                    NSData *mainData = [printer getFinalData];
                    [[SEPrinterManager sharedInstance] sendPrintData:mainData completion:nil];
                }
            }
            else
            {
                HLPrinter *printer = [self getPrinter];
                NSData *mainData = [printer getFinalData];
                [[SEPrinterManager sharedInstance] sendPrintData:mainData completion:nil];
        
            }
        }
    }];
}
- (HLPrinter *)getPrinter
{
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    HLPrinter *printer = [[HLPrinter alloc] init];
    [printer appendText:destDateString alignment:HLTextAlignmentLeft];
    
    
    [printer appendSeperatorLine];
    NSArray *q1= _printData[@"data_print"][@"q1"];
    for (int i=0; i<q1.count; i++) {
    
        [printer appendText:q1[i][@"desc"] alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    }
    
    
    [printer appendSeperatorLine];
    NSArray *q2= _printData[@"data_print"][@"q2"];
    for (int i=0; i<q2.count; i++) {
        
        [printer appendText:q2[i][@"desc"] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    }
    
    
    [printer appendSeperatorTittleLine:@"菜品"];
    NSArray *ginfo= _printData[@"data_print"][@"ginfo"];
    for (int i=0; i<ginfo.count; i++) {
         [printer appendText:ginfo[i][@"goods_name"] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
        
        float price= [ginfo[i][@"shop_price"] floatValue]*[ginfo[i][@"goods_num"] intValue];
        
        [printer appendLeftText:@"" middleText:[NSString stringWithFormat: @"x%@",ginfo[i][@"goods_num"]] rightText:[NSString stringWithFormat:@"%.2f",price] isTitle:NO];
      
    }
    
    
    [printer appendSeperatorTittleLine:@"其他费用"];
    NSArray *q3= _printData[@"data_print"][@"q3"];
    for (int i=0; i<q3.count; i++) {
        
        [printer appendText:q3[i][@"desc"] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    }
     [printer appendText:_printData[@"data_print"][@"total_price"] alignment:HLTextAlignmentRight fontSize:HLFontSizeTitleSmalle];
    
    
    
    [printer appendSeperatorLine];
    [printer appendText:_printData[@"data_print"][@"receiver_address"] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendText:_printData[@"data_print"][@"receiver"] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendText:_printData[@"data_print"][@"receiver_phone"] alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    
    if ([_printData[@"data_print"][@"qr_url"] length]>0) {
        [printer appendQRCodeWithInfo:_printData[@"data_print"][@"qr_url"]];
    }
    [printer appendSeperatorLine];
    [printer appendNewLine];
    [printer appendNewLine];
    [printer appendNewLine];
    
    /*
     [printer appendText:@"位图方式二维码" alignment:HLTextAlignmentCenter];
     [printer appendQRCodeWithInfo:@"www.baidu.com"];
     
     [printer appendSeperatorLine];
     [printer appendText:@"指令方式二维码" alignment:HLTextAlignmentCenter];
     [printer appendQRCodeWithInfo:@"www.baidu.com" size:10];
     
     [printer appendFooter:nil];
     */
    //  [printer appendImage:[UIImage imageNamed:@"ico180"] alignment:HLTextAlignmentCenter maxWidth:300];
    
    // 你也可以利用UIWebView加载HTML小票的方式，这样可以在远程修改小票的样式和布局。
    // 注意点：需要等UIWebView加载完成后，再截取UIWebView的屏幕快照，然后利用添加图片的方法，加进printer
    // 截取屏幕快照，可以用UIWebView+UIImage中的catogery方法 - (UIImage *)imageForWebView
    
    return printer;
}

@end

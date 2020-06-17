//
//  PDGUserProtcolView.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "PDGUserProtcolView.h"
#import <WebKit/WebKit.h>

#define ISBROWSED @"ISBROWSED"

@interface PDGUserProtcolView()<WKNavigationDelegate>

@property (nonatomic, strong)WKWebView *webView;

@property (weak, nonatomic) IBOutlet UIImageView *webView_bgV;

@property (weak, nonatomic) IBOutlet UIImageView *headerImgV;

//@property (nonatomic,strong) UIImageView *pdgContentImgV;

@end

@implementation PDGUserProtcolView

+(instancetype)instancePDGProtcolView{
//    if (SWNOTEmptyStr([[NSUserDefaults standardUserDefaults] valueForKey:ISBROWSED])) {
//        return nil;
//    }
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.alpha = 0;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.30];
    
    self.sureBtn.layer.cornerRadius = 4.0;
    self.sureBtn.clipsToBounds = YES;
    
    WKWebView *webView = [[WKWebView alloc] init];
    webView.userInteractionEnabled = YES;
    webView.navigationDelegate = self;
    webView.opaque = false;
    webView.backgroundColor = [UIColor clearColor];
    [self addSubview:_webView = webView];
    
    CGFloat scale_w = (ScreenW / 414.0);
    CGFloat scale_h = ScreenH / 736.0;
    CGFloat gap =  scale_w * 62;
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.webView_bgV);
        make.width.mas_equalTo(ScreenW - gap * 2);
        make.top.mas_equalTo(self.headerImgV.mas_bottom).offset(10 * scale_h);
        make.bottom.mas_equalTo(self.sureBtn.mas_top).offset(-45 * scale_h);
    }];
    
}

-(void)configerData:(id)data{
    
    if (SWNOTEmptyArr(data)) {

        NSString *htmlStr = [(NSArray *)data componentsJoinedByString:@","];
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"," withString:@"<br>"];
        NSAttributedString *att = [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];

        //富文本转换为html(最后相当于整个网页代码，会有css等)
        NSDictionary *dic = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,                 NSCharacterEncodingDocumentAttribute:@(NSUnicodeStringEncoding)};
        NSData *data = [att dataFromRange:NSMakeRange(0, att.length) documentAttributes:dic error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUnicodeStringEncoding];


        [_webView loadHTMLString:str baseURL:nil];
    }
    
//    if ([data isKindOfClass:[NSURL class]]) {
//        [_webView loadRequest:[NSURLRequest requestWithURL:data]];
//    }else if ([(NSString *)data hasPrefix:@"http"]){
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:data]]];
//    }else{
//        if (data) {
//            [_webView loadHTMLString:data baseURL:nil];
//        }else{
//            NSLog(@"data为空!!!");
//        }
//    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"%@加载完毕",[self class]);
    
    // 改变网页字体大小
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '80%'" completionHandler:nil];
    
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 1;
    }completion:^(BOOL finished) {
        [[TimerHelper new] createTimerWithTime:5 Btn:self.sureBtn];
    }];
}

- (IBAction)sureBtnAction:(UIButton *)sender {
    [self missView];
    
    if (self.block) {
        self.block();
    }
//    if (SWNOTEmptyStr([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token)) {
//        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:ISBROWSED];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
}

- (void)missView{
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

#pragma mark - 倒计时

@interface TimerHelper()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation TimerHelper

- (void)createTimerWithTime:(int)time Btn:(UIButton *)btn{
    self.btn = btn;
    [self createTimerWithTime:time];
}

- (void)createTimerWithTime:(int)time{
    
    //block内部 如果对当前对象的强引用属性修改 应该使用__weak typeof(self)weakSelf 修饰  避免循环调用
    __weak typeof(self)weakSelf = self;
    //设置倒计时时间
    //通过检验发现，方法调用后，timeout会先自动-1，所以如果从15秒开始倒计时timeout应该写16
    
    //__block 如果修饰指针时，指针相当于弱引用，指针对指向的对象不产生引用计数的影响
    __block int timeout = time + 1;
    
    __block UIButton *tmpBtn = weakSelf.btn;
    
    __block NSString *originBtnTitle = @"";
    //获取全局队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建一个定时器，并将定时器的任务交给全局队列执行(并行，不会造成主线程阻塞)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    
    // 设置触发的间隔时间
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //1.0 * NSEC_PER_SEC  代表设置定时器触发的时间间隔为1s
    //0 * NSEC_PER_SEC    代表时间允许的误差是 0s
    
    //设置定时器的触发事件
    dispatch_source_set_event_handler(timer, ^{
        
        //倒计时  刷新button上的title ，当倒计时时间为0时，结束倒计时
        
        //1. 每调用一次 时间-1s
        timeout --;
        
        //2.对timeout进行判断时间是停止倒计时，还是修改button的title
        if (timeout <= 0) {
            
            //停止倒计时，button打开交互，背景颜色还原，title还原
            
            //关闭定时器
            dispatch_source_cancel(timer);
            
            //MRC下需要释放，这里不需要
            //            dispatch_realse(timer);
            
            //button上的相关设置
            //注意: button是属于UI，在iOS中多线程处理时，UI控件的操作必须是交给主线程(主队列)
            //在主线程中对button进行修改操作
            dispatch_async(dispatch_get_main_queue(), ^{
                
                tmpBtn.userInteractionEnabled = YES;
                
                [tmpBtn setTitle:originBtnTitle forState:UIControlStateNormal];
                [tmpBtn setBackgroundImage:[UIImage imageNamed:@"pdgMissView"] forState:0];
            });
        }else {
            
            //处于正在倒计时，在主线程中刷新button上的title，时间-1秒
            dispatch_async(dispatch_get_main_queue(), ^{
                tmpBtn.userInteractionEnabled = NO;
                //根据枚举类型展示不同数据
                NSString *title = [NSString stringWithFormat:@"%ds",timeout];
//                NSString * title = [NSString stringWithFormat:@"%d秒后重新获取验证码",timeout];
//
                [tmpBtn setBackgroundImage:[UIImage imageNamed:@"pdgOnlyCycle"] forState:0];
                [tmpBtn setTitle:title forState:UIControlStateNormal];
                
            });
        }
    });
    
    dispatch_resume(timer);
}

@end

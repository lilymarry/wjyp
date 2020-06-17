//
//  SGoodsInfor_firstView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/10/26.
//  Copyright © 2017年 GYM. All rights reserved.
//
#import "SGoodsInfor_firstView.h"
#import "SNBannerView.h"
#import "UIView+customGetCurrentUIViewController.h"//获取当前视图所在的控制器的分类
#import "CountDownManager.h"
#import "CountDownLabel.h"

/*
 *引用相关类文件
 */
#import "SGoodsExplain.h"
#import "SGroupBuyGroupBuyInfo.h"

@interface SGoodsInfor_firstView () <SNBannerViewDelegate>

@property (nonatomic, strong) UIView * tipMsgView;
@property (nonatomic, strong) UILabel * tipMsgLabel;

@property (nonatomic, strong) NSMutableArray * tipMsgArray;

/*
 *规则标题
 */
@property (nonatomic, copy) NSString * titleStr;

/*
 *活动规则
 */
@property (nonatomic, copy) NSArray * activiryTextArr;

@property (nonatomic, strong) CountDownManager * countDownManager;
@property (weak, nonatomic) IBOutlet CountDownLabel *lasTime;


@property (nonatomic, strong) NSMutableDictionary * textWidthDict;
@property (weak, nonatomic) IBOutlet UILabel *SeeMoreLabel;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *SeeMoreGesture;

@end


@implementation SGoodsInfor_firstView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SGoodsInfor_firstView" owner:self options:nil];
        [self addSubview:_thisView];
        
  
        _songR.layer.masksToBounds = YES;
        _songR.layer.cornerRadius = _songR.frame.size.width/2;
        _priceInterBtn.layer.masksToBounds = YES;
        _priceInterBtn.layer.cornerRadius = 3;
        _priceInterBtn.layer.borderWidth = 0.5;
        _priceInterBtn.layer.borderColor = [UIColor redColor].CGColor;
        
        _proBlue.layer.masksToBounds = YES;
        _proBlue.layer.cornerRadius = 3;
        _proBlue.layer.borderWidth = 0.5;
        _proBlue.layer.borderColor = MyBlue.CGColor;
        
        _indexLab.layer.masksToBounds = YES;
        _indexLab.layer.cornerRadius = 3;
        _indexLab.layer.borderWidth = 1;
        _indexLab.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _actionGround.layer.masksToBounds = YES;
        _actionGround.layer.cornerRadius = 3;
        
        UILongPressGestureRecognizer *goodsNameLongGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(goodsNameCopy:)];
        _goods_name.userInteractionEnabled = YES;
        [_goods_name addGestureRecognizer:goodsNameLongGesture];
        
        self.lasTime.TextBackGroundColor = [UIColor colorWithRed:255.0/255 green:38.0/255 blue:0 alpha:0.8];
        self.lasTime.TextBackGroundCornerRadius = 5;
        self.lasTime.TextColor = [UIColor colorWithRed:255.0/255 green:38.0/255 blue:0 alpha:0.8];
        
        
        /*
         *监听团购界面退出的通知
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuitGroupBuy:) name:@"QuitGroupBuy" object:nil];
        /*
         *监听通过直接支付跳转到的拼团订单列表退出时通知
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuitGroupBuy:) name:@"QuitGroupBuyOrderListFromPay" object:nil];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}


/*
 *视图返回上一级界面的通知回调方法
 */
-(void)QuitGroupBuy:(NSNotification *)noti{
    [self.countDownManager StopTimer];
    self.countDownManager = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除通知观察者
}

/*
 *用于设置进度条在体验拼单中的显示
 */
-(void)setGroup_buy_type_status:(NSString *)group_buy_type_status{
    _group_buy_type_status = group_buy_type_status;
    if ([group_buy_type_status isEqualToString:@"1"]) {
        _proBlue_num.hidden = YES;
        _proBlue_leftNum.hidden = YES;
        _proBlue_rigthNum.hidden = YES;
        _proBlueHeightCons.constant = 3;
        _proBlue.layer.cornerRadius = _proBlueHeightCons.constant * 0.5;
        _proBlue.layer.borderWidth = 0;
        _proBlue.layer.borderColor = [UIColor whiteColor].CGColor;
        _proBlue.layer.masksToBounds = YES;
    }
}
- (void)goodsNameCopy:(UILongPressGestureRecognizer *)sender {
    UIAlertController *alertCTL = [UIAlertController alertControllerWithTitle:@"是否复制以下内容?" message:_goods_name.text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
        pastboard.string = @"";
    }];
    UIAlertAction *affirmAlert = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
        pastboard.string = _goods_name.text;
    }];
    [alertCTL addAction:cancelAlert];
    [alertCTL addAction:affirmAlert];
    UIViewController *vc = [UIView getCurrentUIViewController:self];
    if (vc) [vc presentViewController:alertCTL animated:TRUE completion:nil];
}
/*
 *通过模型数据,设置要显示的信息
 */
-(void)setInforData:(SGroupBuyGroupBuyInfo *)inforData{
    _inforData = inforData;

    
    if ([inforData.group_type isEqualToString:@"1"]) {
        
        //显示体验拼单的活动规则
        SGroupBuyGroupBuyInfo * memoInfo = inforData.group.firstObject;
        self.activiryTextArr = memoInfo.memo;
        
        self.lasTime.hidden = NO;
        /*
         *拼单体验商品的查看更多的提示label和手势的可见与可用的设置
         *默认是不可用和不可见的
         */
        self.SeeMoreLabel.hidden = NO;
        self.SeeMoreGesture.enabled = YES;
        
        long long startTime = memoInfo.sys_time.longLongValue;
        long long finishTime = memoInfo.end_time.longLongValue;
        long long durationTime = finishTime - startTime;
        [self showCountDownTimeWithDurationTime:durationTime];
        
    }else{
        self.lasTime.hidden = YES;
        self.SeeMoreLabel.hidden = YES;
        self.SeeMoreGesture.enabled = NO;
    }
    
    
}

-(void)showCountDownTimeWithDurationTime:(long long)durationTime{
    /*
     *开始倒计时
     */
    if (!self.countDownManager) {
        self.countDownManager = [[CountDownManager alloc] initWithShowLabel:self.lasTime andCountDownTime:durationTime andTimeFormate:@"HH:mm:ss:SS"];
    }
    __weak typeof(self) WeakSelf = self;
    //倒计时更新
    _countDownManager.updateTimeBlock = ^(NSString *updateStr, BOOL isDelay) {
        
        WeakSelf.lasTime.text = [NSString stringWithFormat:@" 剩余 %@ 结束 ",updateStr];

    };
    //倒计时结束
    _countDownManager.timerFinishCountDownBlock = ^(NSString *countDownTime) {
        NSLog(@"倒计时结束");
    };
}

/*
 *处理从服务器获取的活动规则信息以及展示
 */
-(void)setActiviryTextArr:(NSArray *)activiryTextArr{
    _activiryTextArr = activiryTextArr;
    
    /*
     *修复体验拼单规则重复加载的问题
     */
    [self.tipMsgArray removeAllObjects];
    if (!self.tipMsgArray) {
         self.tipMsgArray = [NSMutableArray array];
    }
    NSString * tipMsgString = nil;
    for (int i = 0; i < activiryTextArr.count; i++) {
        NSString * str = activiryTextArr[i];
        
        /*
         *设置要展示的详细活动规则内容
         */
        if (i > 0) {
            SGroupBuyGroupBuyInfo * info = [[SGroupBuyGroupBuyInfo alloc] init];
            
            NSData * data=[str dataUsingEncoding:NSUnicodeStringEncoding];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:data options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                info.attrDesc = attrStr;
                [self.tipMsgArray addObject:info];
    /*
//            info.desc = str;
            /*
             *显示html
             */
//            __block NSData * data = nil;
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                data = [str dataUsingEncoding:NSUnicodeStringEncoding];
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:data options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//                    info.attrDesc = attrStr;
//                    [self.tipMsgArray addObject:info];
//                });
//            });
   
        }
        
        //首页展示的部分信息
        if (i < 5) {
            
            
            /*
             *保存前5个字符串的宽度,防止再次加载的时候,多次计算,实现只计算一次
             */
            if ([self.textWidthDict objectForKey:str] == nil) {
                [self.textWidthDict setObject:@([self getSizeWithStr:str Width:ScreenW Font:self.group_type_title.font.pointSize].width) forKey:str];
            }
            /*
             *限制文字显示的长度,当文字的宽度超过屏幕的一半是,只显示70%的文字,并追加...以显示有更多信息
             */
            
            NSNumber * textWidthNum = [self.textWidthDict objectForKey:str];
            if (textWidthNum.floatValue > ScreenW * 0.8) {
                str = [[str substringToIndex:str.length * 0.8] stringByAppendingString:@"..."];
            }
            
            
            if (i == 0) {
                self.titleStr = str;//展示的活动规则详情的标题
                tipMsgString = str;
            }else{
                tipMsgString = [tipMsgString stringByAppendingString:[NSString stringWithFormat:@"\n%@",str]];
            }
        }
    }
//    self.group_type_title.text = tipMsgString;
    /*
     *体验拼单商品详情页内展示的体验拼单规则的内容
     */
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[[tipMsgString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    self.group_type_title.attributedText = attrStr;
    self.group_type_title.font = [UIFont systemFontOfSize:10];
    
}

/*
 *弹出使用规则详细信息
 */
- (IBAction)showMoreTipMessage:(UITapGestureRecognizer *)sender {
    UIViewController *vc = [UIView getCurrentUIViewController:self];
    
    SGoodsExplain * explain = [[SGoodsExplain alloc] init];
    explain.isTips = YES;
    explain.modalPresentationStyle = UIModalPresentationOverFullScreen;
    explain.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [vc presentViewController:explain animated:YES completion:nil];
    [explain showModel:self.tipMsgArray andType:_overType andType:self.titleStr];
    __weak typeof(explain) WeakExplain = explain;
    explain.SGoodsExplainBack = ^{
        [WeakExplain dismissViewControllerAnimated:YES completion:nil];
    };
}

#pragma mark - 固定宽度和字体大小，获取label的frame
- (CGSize)getSizeWithStr:(NSString *)str Width:(float)width Font:(float)fontSize
{
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize tempSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attribute
                                        context:nil].size;
    return tempSize;
}
#pragma mark - 懒加载数据
-(NSMutableDictionary *)textWidthDict{
    if (!_textWidthDict) {
        _textWidthDict = [NSMutableDictionary dictionary];
    }
    return _textWidthDict;
}
@end

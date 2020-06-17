//
//  SFightGroups_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SFightGroups_top.h"
#import "CountDownLabel.h"
#import "CountDownManager.h"

@interface SFightGroups_top ()
/*
 *添加约束属性,用于隐藏掉StatusTitleLabel
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusTitleToTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusTitleToBottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusTitleHeightCons;

/*
 *添加约束属性,用于控制拼团人员个数的显示
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colonel_head_picToLeadingCons;

/*
 *添加拼团差的人数提示Label    : GroupTheRestMemberLabel
 *添加拼团剩余时间倒计时Label  : countDownLabel
 */
@property (weak, nonatomic) IBOutlet UILabel *GroupTheRestMemberLabel;
@property (weak, nonatomic) IBOutlet CountDownLabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UILabel *DelayTipLabel;

@property (weak, nonatomic) IBOutlet UIImageView *colonelTipImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colonelTipImageViewToLeadingCons;

/*
 *返回积分
 */
@property (weak, nonatomic) IBOutlet UILabel *givenIntegral;
/*
 *送积分提示文字
 */
@property (weak, nonatomic) IBOutlet UILabel *givePointTipLabel;

/*
 *倒计时对象
 */
@property (nonatomic, strong) CountDownManager * countDownManager;

/*
 *是否开始了延时倒计时
 */
@property (assign, nonatomic) BOOL isBeginDelay;

@end

@implementation SFightGroups_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SFightGroups_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _leftImage.layer.masksToBounds = YES;
        _leftImage.layer.cornerRadius = _leftImage.frame.size.width/2;
        _leftImage.layer.borderWidth = 1.0;
        _leftImage.layer.borderColor = [UIColor orangeColor].CGColor;
        
        _rightImage.layer.masksToBounds = YES;
        _rightImage.layer.cornerRadius = _leftImage.frame.size.width/2;
        _rightImage.layer.borderWidth = 1.0;
        _rightImage.layer.borderColor = MyLine.CGColor;
        
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"已拼10567件 · 成单所需2人"];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 5)];
        _thisNum.attributedText = AttributedStr;
        
        
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        
        
        
        /*
         *隐藏条StatusTtileLabel控件
         */
        _statusTitleToTopCons.constant = 8;
        _statusTitleToBottomCons.constant = 8;
        _statusTitleHeightCons.constant = 0;
        
        /*
         *送积分提示文字圆角
         */
        _givePointTipLabel.layer.cornerRadius = _givePointTipLabel.bounds.size.width * 0.5;
        _givePointTipLabel.layer.masksToBounds = YES;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuitJoinGroup:) name:@"QuitJoinGroup" object:nil];
    }
    
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

-(void)QuitJoinGroup:(NSNotification *)noti{
    [self.countDownManager StopTimer];
    self.countDownManager = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setOfferedModel:(SGroupBuyOrderOffered *)offeredModel{
    _offeredModel = offeredModel;
    
    self.givenIntegral.text = offeredModel.givenIntegral;
    
    /*
     *当拼团的成员只有团长时,只显示团长一人头像
     *当用户是团长时,不再设置显示的成员,因为在SFightGroups控制器中,已经设置过
     */
    
//    if ([offeredModel.data.is_colonel isEqualToString:@"0"]) {//不是团长的时候再判断
        if (offeredModel.data.head_pic.count > 0) {
            SGroupBuyOrderOffered * offered_member = offeredModel.data.head_pic.firstObject;
            [_rightImage sd_setImageWithURL:[NSURL URLWithString:offered_member.data.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            _rightImage.hidden = NO;
            _colonel_head_picToLeadingCons.constant = 0;
            _colonelTipImageViewToLeadingCons.constant = 0;
        }else{
            _rightImage.hidden = YES;
            _colonel_head_picToLeadingCons.constant =(_rightImage.superview.bounds.size.width - _rightImage.bounds.size.width) * 0.5;
            _colonelTipImageViewToLeadingCons.constant = _colonel_head_picToLeadingCons.constant;
        }
//    }
    
    /*
     *判断当前用户是否已经参加过当前拼团,根绝用户是否是团员的状态,设置一键参团是否可用
     */
    if (offeredModel.data.is_member.integerValue >= 1) {
        self.submitBtn.enabled = NO;
        self.submitBtn.backgroundColor = WordColor_sub_sub;
    }else{
        self.submitBtn.enabled = YES;
        self.submitBtn.backgroundColor = [UIColor colorWithRed:255.0/255 green:0 blue:0 alpha:1];
    }
    
    
    
    
    _GroupTheRestMemberLabel.attributedText = [self AttributeStringWithString:[NSString stringWithFormat:@"等待拼单, 剩余 %@ 个名额",offeredModel.data.m_short]];

    
    
    /*
     *修复重复加载数据后,倒计时时间显示不正常的问题
     */
    [self.countDownManager StopTimer];
    self.countDownManager = nil;
    
    /*
     *设置开始倒计时的时间戳
     */
    long long startLongLong = offeredModel.data.sys_time.longLongValue;
    /*
     *设置终止倒计时的时间戳
     */
    long long finishLongLong = 0;
    if (offeredModel.data.sys_time.longLongValue < offeredModel.data.end_time.longLongValue) {
        finishLongLong = offeredModel.data.end_time.longLongValue;
        _isBeginDelay = NO;
        self.DelayTipLabel.hidden = YES;
    }else{
        finishLongLong = offeredModel.data.end_true_time.longLongValue;
        _isBeginDelay = YES;
        self.DelayTipLabel.hidden = NO;
    }
    
    //判断拼单倒计时是否为正数,否则显示拼单失败!
    if (finishLongLong - startLongLong <= 0) {
        self.countDownLabel.text = @"拼单失败,未拼成!";
    }
    /*
     *开始倒计时
     */
    if (!_countDownManager) {
        _countDownManager = [[CountDownManager alloc] initWithShowLabel:self.countDownLabel andCountDownTime:(finishLongLong - startLongLong) andTimeFormate:@"HH:mm:ss:SS"];
    }
    __weak typeof(self) WeakSelf = self;
    //倒计时更新
    _countDownManager.updateTimeBlock = ^(NSString *updateStr, BOOL isDelay) {
        WeakSelf.countDownLabel.text = [NSString stringWithFormat:@" 剩余 %@ 结束",updateStr];
        if (!WeakSelf.isBeginDelay) {
            if (isDelay) {
                WeakSelf.DelayTipLabel.hidden = NO;
                WeakSelf.isBeginDelay = YES;
            }else{
                WeakSelf.DelayTipLabel.hidden = YES;
                WeakSelf.isBeginDelay = NO;
            }
        }
    };
    //倒计时结束
    _countDownManager.timerFinishCountDownBlock = ^(NSString *countDownTime) {
        if (!WeakSelf.isBeginDelay) {
            [WeakSelf.countDownManager ReStartNewCountDownWithCountDownTime:(offeredModel.data.end_true_time.longLongValue - startLongLong)];
        }else{
            //当拼单延时结束的时候,仍未拼团成功,显示拼单失败提示
            WeakSelf.countDownManager.updateTimeBlock = nil;//倒计时结束后,会再执行一遍"updateTimeBlock",会显示倒计时00:00:00的状态,这里将block设置为nil是为了显示拼单失败的提示信息
            WeakSelf.countDownLabel.text = @"拼单失败,未拼成!";
        }
    };
    
}


#pragma mark - 拼团剩余时间倒计时的显示,以及剩余可拼团人数
/*
 *富文本设置显示剩余可拼团人数
 */
-(NSMutableAttributedString *)AttributeStringWithString:(NSString *)string{
    NSString * numStr = [self StringContainNumberWith:string];
    NSRange range = [string rangeOfString:numStr];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    return attriStr;
}

//获取字符串中的数字
- (NSString * )StringContainNumberWith:(NSString *)str {
    
    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    int containNum =[[str stringByTrimmingCharactersInSet:nonDigits] intValue];
    return [NSString stringWithFormat:@"%d",containNum];
}
@end

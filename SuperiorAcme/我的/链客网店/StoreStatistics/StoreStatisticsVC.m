//
//  StoreStatisticsVC.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//  小店营收

#import "StoreStatisticsVC.h"
#import "StoreStatisticsModel.h"

@interface StoreStatisticsVC ()


/**
 数据模型
 */
@property (nonatomic, strong) StoreStatisticsModel *storeStatisticsModel;

/**
 分销商品贝塞尔路径
 */
@property (nonatomic, strong) UIBezierPath *bezierPathSale;

/**
 分销商品绘图
 */
@property (nonatomic, strong) CAShapeLayer *pathLayerSale;

/**
 普通商品贝塞尔路径
 */
@property (nonatomic, strong) UIBezierPath *bezierPathNormal;

/**
 普通商品绘图
 */
@property (nonatomic, strong) CAShapeLayer *pathLayerNormal;

/**
 统计视图均分宽度
 */
@property (nonatomic, assign) CGFloat aveWidth;

/**
 统计视图高度
 */
@property (nonatomic, assign) CGFloat statisticsLineHeight;

/**
 记录当前1级分类 1:销售额 0:净收益
 */
@property (nonatomic, assign) NSInteger typeIndex;

/**
 记录当前2级分类 1:日 2:月 0:年
 */
@property (nonatomic, assign) NSInteger subTypeIndex;

/**
 保存所有圆点的贝塞尔
 */
@property (nonatomic, strong) NSMutableArray *bezierPathArray;


/**
 保存所有圆点的绘制
 */
@property (nonatomic, strong) NSMutableArray *shapeLayerArray;


/**
 日期选择器
 */
@property (nonatomic, strong) UIDatePicker *datePicker;


/**
 日期选择器背景视图
 */
@property (nonatomic, strong) UIView *datePickerBackView;

/**
 周按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *weekButton;

/**
 月按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *monthButton;

/**
 年按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *yearButton;

/**
 周，月，年背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *timeTypeindexView;

/**
 分销商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *saleSVLabel;

/**
 普通商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *normalSVLabel;

/**
 统计视图背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *statisticsView;

/**
 7个时间段的背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *statisticsTitleView;
/**
 以下为7个时间段的标题
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel3;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel4;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel5;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel6;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel7;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineCenterX;

@end

@implementation StoreStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
   [self CreatNavBar:@[@"销售额", @"净收益"] andIsHaveRightBtn:NO andRightBtnOption:@{@"imageName":@"统计时间选择"} andDefaultHiddenForRightBtn:NO];

    //默认周为选中状态
    _weekButton.selected = YES;
    
    self.bezierPathSale = [[UIBezierPath alloc] init];
    self.pathLayerSale = [CAShapeLayer layer];
    self.bezierPathNormal = [[UIBezierPath alloc] init];
    self.pathLayerNormal = [CAShapeLayer layer];
    self.bezierPathArray = [NSMutableArray array];
    self.shapeLayerArray = [NSMutableArray array];
    
    self.storeStatisticsModel = [[StoreStatisticsModel alloc] init];
    
    //默认为销售额 和 日
    _typeIndex = 1;
    _subTypeIndex = 1;
    
    //请求数据
    [self getData:_shopId andType:@"1" andC_type:[NSString stringWithFormat:@"%ld", (long)_typeIndex] andC_base_type:[NSString stringWithFormat:@"%ld", (long)_subTypeIndex] andIsInit:YES];
}


/**
 更新UI

 @param data 数据包
 */
- (void)updateView:(NSDictionary *)data withType:(NSString *)c_type {

         NSArray *d=[self sortedArray:data[@"data"][@"dis"][@"data"]];
        NSDictionary *dic = @{@"count":data[@"data"][@"ordinate"], @"data":d};
    
        NSArray *d1=[self sortedArray:data[@"data"][@"normal"][@"data"]];
        NSDictionary *dic2 = @{@"count":data[@"data"][@"ordinate"], @"data":d1};
    
    if ([c_type isEqualToString:@"1"]) {
        _saleSVLabel.text = [NSString stringWithFormat:@"%.2f元", [data[@"data"][@"dis"][@"count"]doubleValue]];
        _normalSVLabel.text = [NSString stringWithFormat:@"%.2f元",[ data[@"data"][@"normal"][@"count"]doubleValue] ];
        
    }
    else
    {
        _saleSVLabel.text = [NSString stringWithFormat:@"%.2f余额", [data[@"data"][@"dis"][@"count"]doubleValue]];
        _normalSVLabel.text = [NSString stringWithFormat:@"%.2f积分",[ data[@"data"][@"normal"][@"count"]doubleValue] ];
    }
   
    
    [self redrawStatisticsLine:dic andDicNormal:dic2];
    
    NSArray *labelArray = @[_timeLabel1, _timeLabel2, _timeLabel3, _timeLabel4, _timeLabel5, _timeLabel6, _timeLabel7];
    
    for (int i = 1; i <= labelArray.count ; i++) {
        ((UILabel *)labelArray[i-1]).text = [NSString stringWithFormat:@"%@", data[@"data"][@"horizon"][i-1]];
        ((UILabel *)labelArray[i-1]).layer.position = CGPointMake(self.aveWidth * i, _statisticsTitleView.frame.size.height / 2);
    }
}
-(NSArray *)sortedArray:(NSDictionary *)dic
{
    NSMutableArray *arr=[NSMutableArray array];
    NSArray *keysArray = [dic allKeys];//获取所有键存到数组
    NSArray *sortedArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];//由于allKeys返回的是无序数组，这里我们要排列它们的顺序
    for (NSString *key in sortedArray) {
        NSString *value = [dic objectForKey: key];
        [arr addObject:value];
    }//遍历整
    return arr;
  
}

/**
 获取数据

 @param storeId 商店id
 @param type 请求类型
 @param c_type 1：销售额 0：净收益
 @param c_base_type 1: 日 2：月 0 ：年
 @param isInit 是否是初始化
 */
- (void)getData:(NSString *)storeId andType:(NSString *)type andC_type:(NSString *)c_type andC_base_type:(NSString *)c_base_type andIsInit:(BOOL)isInit{
    _storeStatisticsModel.storeId = storeId;
    _storeStatisticsModel.type = type;
    _storeStatisticsModel.c_type = c_type;
    _storeStatisticsModel.c_base_type = c_base_type;
    [_storeStatisticsModel getStatisticsData:^(NSDictionary *data) {
        if (isInit) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //绘制分割线
                [self drawVerticalLine:_aveWidth];
                //更新UI
                [self updateView:data withType:c_type];
            });
        } else {
            //清空和统计线相关所有图层及贝塞尔路径
            [self clearLayers];
            
            //更新UI
            [self updateView:data withType:c_type];
        }
    } andFailure:^(NSError *error) {
        
    }];
}

/**
 创建日期选择器
 */
- (void)showDatePicker {
    if (!self.datePickerBackView) {
        //创建背景
        self.datePickerBackView = [[UIView alloc] initWithFrame:self.view.frame];
        _datePickerBackView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
        [self.view addSubview:_datePickerBackView];
        
        //创建日期选择器
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 270, self.view.frame.size.width, 270)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [_datePickerBackView addSubview:_datePicker];
        
        //创建选择器上方工具条
        UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - _datePicker.frame.size.height -44, self.view.frame.size.width, 44)];
        toolView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, toolView.frame.size.width, toolView.frame.size.height)];
        titleLabel.text = @"选择日期";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
        CALayer *layerLine = [CALayer layer];
        layerLine.frame = CGRectMake(0, titleLabel.frame.size.height - 1, titleLabel.frame.size.width, 1);
        layerLine.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1].CGColor;
        [titleLabel.layer addSublayer:layerLine];
        [toolView addSubview:titleLabel];
        
        //创建取消按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1] forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        cancelBtn.frame = CGRectMake(0, 0, 50, toolView.frame.size.height);
        cancelBtn.tag = 0;
        [cancelBtn addTarget:self action:@selector(pickerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        //创建完成按钮
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1] forState:UIControlStateNormal];
        [doneBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        doneBtn.frame = CGRectMake(toolView.frame.size.width - 50, 0, 50, titleLabel.frame.size.height);
        doneBtn.tag = 1;
        [doneBtn addTarget:self action:@selector(pickerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [toolView addSubview:cancelBtn];
        [toolView addSubview:doneBtn];
        
        [_datePickerBackView addSubview:toolView];
        
    } else {
        _datePickerBackView.isHidden ? (_datePickerBackView.hidden = NO) : (_datePickerBackView.hidden = YES);
    }
}


/**
 日期选择器工具条按钮事件

 @param sender 被点击按钮
 */
- (void)pickerBtnEvent:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 0) {
        //点击取消
        _datePickerBackView.hidden = YES;
    } else {
        //点击完成
        _datePickerBackView.hidden = YES;
    }
}

/**
 点击周，月，年按钮事件

 @param sender 被点击的按钮
 */
- (IBAction)timeTypeBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSArray *arrViews = (btn.superview).subviews;
    for (UIButton *tmpBtn in arrViews) {
        if (tmpBtn.tag != btn.tag) {
            tmpBtn.selected = NO;
        } else {
            tmpBtn.selected = YES;
        }
    }
    
    //保存当前选项
    _subTypeIndex = btn.tag == 3 ? 0 : btn.tag;
    
    [UIView animateWithDuration:0.5 animations:^{
        _lineCenterX.constant = btn.frame.origin.x;
        _timeTypeindexView.layer.position = CGPointMake(btn.layer.position.x, _timeTypeindexView.layer.position.y);
    }];
    
    //请求数据
    [self getData:_shopId andType:@"1" andC_type:[NSString stringWithFormat:@"%ld", (long)_typeIndex] andC_base_type:[NSString stringWithFormat:@"%ld", (long)_subTypeIndex] andIsInit:NO];
}


/**
 绘制统计线

 @param bezierPath 贝塞尔路径对象
 @param pathLayer 绘图对象
 @param dataDic 统计数据
 @param typeIndex 分销商品 或 普通商品 类型 0为分销 1为普通
 @param aveWidth 统计视图均分宽度
 @param lineHeight 统计视图高度
 */
- (void)drawLine:(UIBezierPath *)bezierPath andPathLayer:(CAShapeLayer *)pathLayer andData:(NSDictionary *)dataDic andType:(NSInteger)typeIndex andAveWidth:(CGFloat)aveWidth andLineHeight:(CGFloat)lineHeight {
    
    [bezierPath moveToPoint:CGPointMake(0, lineHeight)];
    
    CGFloat endOrginY = 0.0f;
    for (int i = 1; i <= 7; i++) {
        CGFloat tmpH = [(dataDic[@"data"][i-1]) floatValue];
        CGFloat count = [(dataDic[@"count"]) floatValue];
        CGFloat orginY = lineHeight;
        if (tmpH > 0.0) {
            orginY = lineHeight - ((lineHeight * tmpH) / count);
        }
        [bezierPath addLineToPoint:CGPointMake(aveWidth * i, orginY)];
        if (i == 7) endOrginY = orginY;
        //绘制所有圆点
       CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        UIBezierPath *bezier = [[UIBezierPath alloc] init];
        
        [bezier addArcWithCenter:CGPointMake(_aveWidth * i, orginY) radius:3 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
//        UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(_aveWidth * i, orginY, 10, 10)];
//        lab.font=[UIFont systemFontOfSize:8];
//        [lab sizeToFit];
//        lab.text=dataDic[@"data"][i-1];
//        [self.view addSubview:lab];
        
        shapeLayer.path = bezier.CGPath;
        if (typeIndex == 0) {
           shapeLayer.fillColor = [UIColor redColor].CGColor;
        } else {
          shapeLayer.fillColor = [UIColor blueColor].CGColor;
        }
        
         [_statisticsView.layer addSublayer:shapeLayer];
        [_bezierPathArray addObject:bezier];
         [_shapeLayerArray addObject:shapeLayer];
        
    }
    [bezierPath addLineToPoint:CGPointMake(aveWidth * 8, endOrginY)];
    
    //    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    if (typeIndex == 0) {
        pathLayer.strokeColor = [UIColor redColor].CGColor;
    } else {
        pathLayer.strokeColor = [UIColor blueColor].CGColor;
    }
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.lineWidth = 1.0f;
    pathLayer.lineCap = kCALineCapRound;
    pathLayer.lineJoin = kCALineJoinRound;
    [_statisticsView.layer addSublayer:pathLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2.0;
    [pathLayer addAnimation:animation forKey:nil];
}



/**
 绘制统计视图分割线

 @param aveWidth 统计视图均分宽度
 */
- (void)drawVerticalLine:(CGFloat)aveWidth {
    for (int i = 1; i <= 7; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(aveWidth * i, 0, 1, _statisticsView.frame.size.height)];
        lineView.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:219.0/255.0 alpha:1];
        [_statisticsView addSubview:lineView];
    }
}

- (void)viewDidLayoutSubviews {
    self.aveWidth = (self.statisticsView.frame.size.width - 7) / 8.0;
    self.statisticsLineHeight = _statisticsView.frame.size.height;
}

/**
 重新绘制统计线

 @param dicSale 分销商品数据
 @param dicNormal 普通商品数据
 */
- (void)redrawStatisticsLine:(NSDictionary *)dicSale andDicNormal:(NSDictionary *)dicNormal {
    [self drawLine:self.bezierPathSale andPathLayer:self.pathLayerSale andData:dicSale andType:0 andAveWidth:_aveWidth andLineHeight:_statisticsLineHeight];
    [self drawLine:self.bezierPathNormal andPathLayer:self.pathLayerNormal andData:dicNormal andType:1 andAveWidth:_aveWidth andLineHeight:_statisticsLineHeight];
}


/**
 点击分段控制器

 @param sender 被点击的类型
 */
- (void)selectItem:(UISegmentedControl *)sender {
    //保存被点击的分段按钮下标
    _typeIndex = sender.selectedSegmentIndex == 0 ? 1 : 0;
    
    //请求数据
    [self getData:_shopId andType:@"1" andC_type:[NSString stringWithFormat:@"%ld", (long)_typeIndex] andC_base_type:[NSString stringWithFormat:@"%ld", (long)_subTypeIndex] andIsInit:NO];
}

/**
 navRightBtn的方法
 
 @param btn 点击的按钮
 */
-(void)navRightBtn:(UIButton *)btn {
    [self showDatePicker];
}

/**
 清空和统计线相关所有图层及贝塞尔路径
 */
- (void)clearLayers {
    for (CAShapeLayer *tmpLayer in _shapeLayerArray) {
        [tmpLayer removeFromSuperlayer];
    }
    _shapeLayerArray = [NSMutableArray array];
    
    for (UIBezierPath *tmpPath in _bezierPathArray) {
        [tmpPath removeAllPoints];
    }
    _bezierPathArray = [NSMutableArray array];
    
    if (self.pathLayerSale) [self.pathLayerSale removeFromSuperlayer];
    if (self.pathLayerNormal) [self.pathLayerNormal removeFromSuperlayer];
    if (self.bezierPathSale) [self.bezierPathSale removeAllPoints];
    if (self.bezierPathNormal) [self.bezierPathNormal removeAllPoints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

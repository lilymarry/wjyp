//
//  ProfitDetail.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/8.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ProfitDetail.h"
#import "ProfitDetailModel.h"
#import "ProfitDetailTopView.h"
#import "ProfitDetailCell.h"
#import "SUserUserCenter.h"
@interface ProfitDetail ()<UITableViewDelegate,UITableViewDataSource>
{
    ProfitDetailTopView *top;
    NSArray *rankArr;
    NSString *  service_head_pic;
     NSString * service_nickname ;
}
/**
贝塞尔路径
 */
@property (nonatomic, strong) UIBezierPath *bezierPathSale;

/**
商品绘图
 */
@property (nonatomic, strong) CAShapeLayer *pathLayerSale;

/**
 统计视图均分宽度
 */
@property (nonatomic, assign) CGFloat aveWidth;

/**
 统计视图高度
 */
@property (nonatomic, assign) CGFloat statisticsLineHeight;

/**
 保存所有圆点的贝塞尔
 */
@property (nonatomic, strong) NSMutableArray *bezierPathArray;


/**
 保存所有圆点的绘制
 */
@property (nonatomic, strong) NSMutableArray *shapeLayerArray;

@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation ProfitDetail


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"寄售收益";
     [self getUserCenter];
      _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
     [_mTable registerNib:[UINib nibWithNibName:@"ProfitDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ProfitDetailCell"];
    
    [self createSMineTopView];
 
    
    self.bezierPathSale = [[UIBezierPath alloc] init];
    self.pathLayerSale = [CAShapeLayer layer];

    self.bezierPathArray = [NSMutableArray array];
    self.shapeLayerArray = [NSMutableArray array];
 
    
    //默认周为选中状态
    top.weekButton.selected = YES;
    
    //请求数据
    [self getDataType:@"1" andIsInit:YES];
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [_mTable setTableFooterView:view];
    
   
    
}


/**
 更新UI
 
 @param data 数据包
 */
- (void)updateView:(NSDictionary *)data {
    
    NSArray *d=[self sortedArray:data[@"data"]];
    NSDictionary *dic = @{@"count":data[@"ordinate"], @"data":d};
    
    [self redrawStatisticsLine:dic];
    
    NSArray *labelArray = @[top.timeLabel1, top.timeLabel2, top.timeLabel3, top.timeLabel4, top.timeLabel5, top.timeLabel6,top.timeLabel7];
    
    for (int i = 1; i <= labelArray.count ; i++) {
        ((UILabel *)labelArray[i-1]).text = [NSString stringWithFormat:@"%@", data[@"horizon"][i-1]];
        ((UILabel *)labelArray[i-1]).layer.position = CGPointMake(self.aveWidth * i, top.statisticsTitleView.frame.size.height / 2);
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
- (void)getUserCenter {
    SUserUserCenter * center = [[SUserUserCenter alloc] init];
    
    [center sUserUserCenterSuccess:^(NSString *code, NSString *message, id data) {
        
        if ([code isEqualToString:@"1"]) {
            SUserUserCenter * center = (SUserUserCenter *)data;
            
            service_head_pic = center.data.head_pic;
            service_nickname = center.data.nickname;
            
              [top.headView sd_setImageWithURL:[NSURL URLWithString:center.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
                top.myNameLab.text=center.data.nickname;
            
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
            
        }
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
/**
 获取数据
 @param type 请求类型
 @param isInit 是否是初始化
 */
- (void)getDataType:(NSString *)type  andIsInit:(BOOL)isInit{
    
    
    ProfitDetailModel *model=[[ProfitDetailModel alloc]init];
    model.type=type;
    [model ProfitDetailModelModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, NSDictionary * _Nonnull data) {
       
        if (isInit) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //绘制分割线
                [self drawVerticalLine:_aveWidth];
                //更新UI
                [self updateView:data ];
            });
        } else {
            //清空和统计线相关所有图层及贝塞尔路径
            [self clearLayers];
            
            //更新UI
            [self updateView:data ];
        }
        
        if ([code intValue]==200) {
            rankArr=[NSArray arrayWithArray:data[@"rank"]];
            if ([data[@"my_rank"] count]>0) {
                NSDictionary *dic=data[@"my_rank"][0];
                
                top.mygradeLab.text=[NSString stringWithFormat:@"%@",dic[@"rank"]];
                top.myProfitLab.text=[NSString stringWithFormat:@"%@",dic[@"revenue"]];
            }
            [top.headView sd_setImageWithURL:[NSURL URLWithString:service_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
            top.myNameLab.text=service_nickname;
            
           
        }
          [_mTable reloadData];
    } andFailure:^(NSError * _Nonnull error) {
        
    }];
    
}
/**
 点击周，月，年按钮事件
 
 @param sender 被点击的按钮
 */
- (void)timeTypeBtn:(id)sender {
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
    [UIView animateWithDuration:0.5 animations:^{
 
       top.timeTypeindexView.layer.position = CGPointMake(btn.layer.position.x, top.timeTypeindexView.layer.position.y);
    }];
    
    //请求数据
    [self getDataType:[NSString stringWithFormat:@"%d", (int)btn.tag] andIsInit:NO];
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
        shapeLayer.path = bezier.CGPath;
        if (typeIndex == 0) {
            shapeLayer.fillColor = [UIColor redColor].CGColor;
        } else {
            shapeLayer.fillColor = [UIColor blueColor].CGColor;
        }
        
        [top.statisticsView.layer addSublayer:shapeLayer];
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
    [top.statisticsView.layer addSublayer:pathLayer];
    
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
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(aveWidth * i, 0, 1, top.statisticsView.frame.size.height)];
        lineView.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:219.0/255.0 alpha:1];
        [top.statisticsView addSubview:lineView];
    }
}


- (void)createSMineTopView {
    top = [[ProfitDetailTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 405)];
   // __weak typeof(self) weakSelf = self;
    [top.weekButton addTarget:self action:@selector(timeTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
      [top.yearButton addTarget:self action:@selector(timeTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [top.monthButton addTarget:self action:@selector(timeTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.aveWidth = ScreenW / 8.0;
    self.statisticsLineHeight =197;
    _mTable.tableHeaderView = top;
  
}
/**
 重新绘制统计线
 
 @param dicSale 分销商品数据

 */
- (void)redrawStatisticsLine:(NSDictionary *)dicSale {
    [self drawLine:self.bezierPathSale andPathLayer:self.pathLayerSale andData:dicSale andType:0 andAveWidth:_aveWidth andLineHeight:_statisticsLineHeight];
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

    if (self.bezierPathSale) [self.bezierPathSale removeAllPoints];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return rankArr.count;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfitDetailCell * oneCell = [tableView dequeueReusableCellWithIdentifier:@"ProfitDetailCell" forIndexPath:indexPath];
    NSDictionary *dic=rankArr[indexPath .row];
    oneCell.lab_name.text=dic[@"nickname"];
    oneCell.lab_price.text=[NSString stringWithFormat:@"¥%@",dic[@"revenue"]];
    [oneCell.ima_head sd_setImageWithURL:[NSURL URLWithString:dic[@"head_pic"]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    if (indexPath.row==0) {
        oneCell.lab_rank.hidden=YES;
        oneCell.ima_grade.hidden=NO;
        oneCell.ima_grade.image=[UIImage imageNamed:@"排行星星-1"];
    }
    else if (indexPath.row==1)
    {
        oneCell.lab_rank.hidden=YES;
        oneCell.ima_grade.hidden=NO;
        oneCell.ima_grade.image=[UIImage imageNamed:@"排行星星-2"];
    }
    else if (indexPath.row==2)
    {
        oneCell.lab_rank.hidden=YES;
        oneCell.ima_grade.hidden=NO;
        oneCell.ima_grade.image=[UIImage imageNamed:@"排行星星-3"];
    }
    else
    {
        oneCell.lab_rank.hidden=NO;
        oneCell.lab_rank.text=[NSString stringWithFormat:@"%d",(int)indexPath.row+1];
        oneCell.ima_grade.hidden=YES;
        
    }
    return oneCell;
    
}
@end

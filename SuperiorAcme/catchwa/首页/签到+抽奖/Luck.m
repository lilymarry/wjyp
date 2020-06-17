//
//  Luck.m
//  抽奖
//  fan

//  Created by 亿缘 on 2017/7/15.
//  Copyright © 2017年 亿缘. All rights reserved.
//

#import "Luck.h"
#import "UIImageView+WebCache.h"
#import "WADailySginInCell.h"
#import "GetRoomListModel.h"
#import "UserSignModel.h"
@interface Luck () {
     NSTimer *imageTimer;
    NSTimer *startTimer;
    
    int currentTime;
    int stopTime;
    UIButton *btn0;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
    UIButton *btn7;
    
    BOOL isRepeat;
}



@property (strong, nonatomic) NSMutableArray * btnArray;
@property (strong, nonatomic) UIButton * startBtn;
@property (assign, nonatomic) CGFloat time;
@property (assign,nonatomic)UIButton *temp; // 循环的上个按钮
@property (assign, nonatomic) int stopCount;
@property (strong, nonatomic) UIImageView *borderImageView;
@property (assign, nonatomic) BOOL isImage;

@end
@implementation Luck



- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView * backima=[[UIImageView alloc] initWithFrame:CGRectMake(30,30, ScreenW-60 , ScreenW-60)];;
       backima.backgroundColor=[UIColor colorWithRed:253/255.0 green:74/255.0 blue:157/255.0 alpha:1];
        
        backima.layer.masksToBounds = YES;
        backima.layer.cornerRadius = 15;
        backima.layer.borderWidth =15;
        backima.layer.borderColor =[UIColor colorWithRed:252/255.0 green:119/255.0 blue:221/255.0 alpha:1].CGColor;
        
        [self addSubview:backima];
        
        
        self.borderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, ScreenW-60 , ScreenW-60)];
        self.borderImageView.backgroundColor=[UIColor clearColor];
        
        self.borderImageView.image = [UIImage imageNamed:@"方形灯-2"];
        self.borderImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:self.borderImageView];
        
        
        self.time = 0.1;
        self.isImage = YES;
        imageTimer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(updataImage:) userInfo:nil repeats:YES];
       
    }
    return self;
}
//背景图切换
- (void)updataImage:(NSTimer *)timer {
    self.isImage = !self.isImage;
    if (self.isImage == YES) {
        self.borderImageView.image = [UIImage imageNamed:@"方形灯-2"];
    } else {
        self.borderImageView.image = [UIImage imageNamed:@"方形灯-1"];
    }
}


- (void)setImageArray:(NSMutableArray *)imageArray {
    _imageArray = imageArray;
    float width = self.frame.size.width;
    // 后面背景按钮
    for (int i = 0; i < imageArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i%3)* (width-100)/3 + 50,((i/3)* (width-100)/3)+50, (width-100)/3, (width-100)/3);
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.tag = i;
        
         GetRoomListModel *model=[_imageArray objectAtIndex:i > 4? i -1: i];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, (width-100)/3 - 20, (width-100)/3 - 20)];
        [image sd_setImageWithURL:[NSURL URLWithString:model.bgImg]
                 placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];

        if (i == 4) {
            [btn setBackgroundImage:[UIImage imageNamed:@"签到按钮"] forState:UIControlStateNormal];
            btn.layer.cornerRadius = 10;
            btn.tag = 10;
            self.startBtn = btn;
            continue;
        }
        if (i != 4) {
            [btn addSubview: image];
        }
     
        WADailySginInCell *cell=[[WADailySginInCell alloc]initWithFrame:image.frame];
        
        if ([model.type intValue]==1) {
            cell.view3.hidden=NO;
                        cell.view1.hidden=YES;
                        cell.view2.hidden=YES;

            [cell.v3_imagView sd_setImageWithURL:[NSURL URLWithString:model.prizeImg] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
           
                cell.v3_imagView.image=[self scaleToSize:image size:CGSizeMake(40, 40)];
            }];
            cell.v3_lab.text=[NSString stringWithFormat:@"%@%@",model.content,model.contentType];
        }
       else if ([model.type intValue]==2) {
            cell.view3.hidden=YES;
            cell.view1.hidden=YES;
            cell.view2.hidden=NO;
           
            cell.v2_lab.text=[NSString stringWithFormat:@"%@",model.contentType];
        }
        else if ([model.type intValue]==3)
        {
            cell.view3.hidden=YES;
            cell.view1.hidden=NO;
            cell.view2.hidden=YES;
            
            [cell.v1_imagView sd_setImageWithURL:[NSURL URLWithString:model.prizeImg] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
                cell.v1_imagView.image=[self scaleToSize:image size:CGSizeMake(40, 40)];
            }];
      
        }
        
        cell.backgroundColor=[UIColor clearColor];
        [btn addSubview:cell];
        
        
        btn.backgroundColor = [UIColor clearColor];
        switch (i) {
            case 0:
                btn0 = btn;
                break;
            case 1:
                btn1 = btn;
                break;
            case 2:
                btn2 = btn;
                break;
            case 3:
                btn3 = btn;
                break;
            case 5:
                btn4 = btn;
                break;
            case 6:
                btn5 = btn;
                break;
            case 7:
                btn6= btn;
                break;
            case 8:
                btn7 = btn;
                break;
                
            default:
                
                break;
        }
        
        [self.btnArray addObject:btn];
    }
    // 交换按钮位置
    [self TradePlacesWithBtn1:btn3 btn2:btn4];
    [self TradePlacesWithBtn1:btn4 btn2:btn7];
    [self TradePlacesWithBtn1:btn5 btn2:btn6];
    
    
}
//压缩图片为指定大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}
- (void)TradePlacesWithBtn1:(UIButton *)firstBtn btn2:(UIButton *)secondBtn {
    CGRect frame = firstBtn.frame;
    firstBtn.frame = secondBtn.frame;
    secondBtn.frame = frame;
}

- (void)btnClick:(UIButton *)btn {
    if (btn.tag == 10) {
        UserSignModel *model=[[UserSignModel alloc]init];
        [model UserSignModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            @try {
                  _stopCount = 0;
                if ([code intValue]==200) {
                    UserSignModel *model=( UserSignModel * )data;
                    _stopCount = [model.data.position intValue];
     
                    if ([model.data.sign.type intValue]==2) {
                        isRepeat=YES;
                    }
                    else
                    {
                        isRepeat=NO;
                    }
                    
                    //点击开始抽奖
                    
                    currentTime = 0;
                    self.time = 0.1;
                    stopTime = 7+8*self.circleNum + self.stopCount;
                    [self.startBtn setEnabled:NO];
                    startTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(start:) userInfo:nil repeats:YES];
                    
                }
                else
                {
                    if (message.length>0) {
                        [MBProgressHUD showSuccess:message toView:self.superview];
                        [self.startBtn setEnabled:NO];
                    }
                    else
                    {
                        [MBProgressHUD showSuccess:@"数据有误" toView:self.superview];
                        [self.startBtn setEnabled:NO];
                    }
                   
                }
            } @catch (NSException *exception) {

            } @finally {

            }

        } andFailure:^(NSError * _Nonnull error) {

            [MBProgressHUD hideAllHUDsForView:self.superview animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.superview];

        }];


       
    }
}

- (void)setCircleNum:(int)circleNum{
    _circleNum = circleNum;
}

- (void)start:(NSTimer *)timer {
    if (self.temp ) {
        self.temp.backgroundColor = [UIColor clearColor];
    }
    UIButton *oldBtn = [self.btnArray objectAtIndex:currentTime % self.btnArray.count];
    oldBtn.backgroundColor = [UIColor orangeColor];
    self.temp = oldBtn;
   
    NSLog(@"currentTime= %d,stopTime= %d",currentTime ,stopTime );
    // 停止循环
    if (currentTime > stopTime) {
            [timer invalidate];
            [self.startBtn setEnabled:YES];
            [self stopWithCount:currentTime%self.btnArray.count];
            return;
    }
    // 一直循环
    if (currentTime > stopTime - 6) {
        
        self.time += 0.1;
        [timer invalidate];
        startTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(start:) userInfo:nil repeats:YES];
    }
     currentTime++;
}



- (void)stopWithCount:(NSInteger)count {
  
    
      NSLog(@"count= %ld",(long)count );
    if ([self.delegate respondsToSelector:@selector(luckViewDidStopWithArrayCount:is_Repeat:)]) {
            [self.delegate luckViewDidStopWithArrayCount:count is_Repeat:isRepeat];
        }
  
}


@end

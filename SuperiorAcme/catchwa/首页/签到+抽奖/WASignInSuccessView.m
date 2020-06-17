//
//  WASignInSuccessView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WASignInSuccessView.h"

@interface WASignInSuccessView ()
@property (weak, nonatomic) IBOutlet UIButton *OKBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIImageView *contentIma;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;



@end

@implementation WASignInSuccessView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WASignInSuccessView" owner:self options:nil];
        [self addSubview:_thisView];
        _OKBtn.layer.masksToBounds = YES;
        _OKBtn.layer.cornerRadius = 15;
        _OKBtn.layer.borderWidth = 5;
        _OKBtn.layer.borderColor =[UIColor clearColor].CGColor;
  
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}


- (IBAction)surePress:(id)sender {
    
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
-(void)getData:(GetRoomListModel *)model
{
    if ([model.type intValue]==1) {
        
        
        [_contentIma sd_setImageWithURL:[NSURL URLWithString:model.prizeImg] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            _contentIma.image=[self scaleToSize:image size:CGSizeMake(40, 40)];
        }];
        _nameLab.text=[NSString stringWithFormat:@"%@%@",model.content,model.contentType];
         _titleLab.text=@"签到成功";
    }
   
    else if ([model.type intValue]==3)
    {
        [_contentIma sd_setImageWithURL:[NSURL URLWithString:model.prizeImg] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
           _contentIma.image=[self scaleToSize:image size:CGSizeMake(40, 40)];
          
        }];
        _titleLab.text=@"继续努力";
        _nameLab.text=@"";
    }
    
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

@end

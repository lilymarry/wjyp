//
//  SGoodsInforPosterPlay.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/31.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SGoodsInforPosterPlay.h"

@implementation SGoodsInforPosterPlay
{
    UIImageView *mageView;
    UILongPressGestureRecognizer *longPressGest;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
     
        mageView=[[UIImageView alloc ] initWithFrame:self.bounds];
        [mageView setUserInteractionEnabled:YES];
        mageView.contentMode = UIViewContentModeScaleToFill;
        mageView.clipsToBounds = YES;
        mageView.autoresizesSubviews = YES;
        mageView.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
 
        [self addSubview:mageView];
     
        if (!longPressGest ) {
            longPressGest= [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressView:)];
            longPressGest.delegate=self;
            //longPressGest.minimumPressDuration = 3;//**********
            [mageView addGestureRecognizer:longPressGest];
        }
    }
    return self;
}
-(void)longPressView:(UILongPressGestureRecognizer *)longPressGest{
    
    if (longPressGest.state==UIGestureRecognizerStateBegan) {
        UIImageWriteToSavedPhotosAlbum(mageView.image, self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
    }
}
- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    [MBProgressHUD showSuccess:@"已成功保存到相册!" toView:[UIApplication sharedApplication].delegate.window];
}
-(void)reloadView
{
    [mageView sd_setImageWithURL:[NSURL URLWithString:_img]
                            placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}
@end

//
//  SSetShopIntroduceCell.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

#define MaxInPutTextLength 500
#import "SSetShopIntroduceCell.h"

@interface SSetShopIntroduceCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *shopIntroduceTextView;
@property (weak, nonatomic) IBOutlet UILabel *restInputWordLabel;
@end

@implementation SSetShopIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextViewEditStatus:) name:@"EditSelect" object:nil];
}
-(void)changeTextViewEditStatus:(NSNotification *)noti{
    BOOL selected = [noti.userInfo[@"EditSelect"] boolValue];
    if (selected) {
        self.shopIntroduceTextView.editable = YES;
        self.shopIntroduceTextView.selectable = YES;
    }else{
        self.shopIntroduceTextView.editable = NO;
        self.shopIntroduceTextView.selectable = NO;
        [self.shopIntroduceTextView resignFirstResponder];
        
        if (self.textViewEndEditBlock) {
            self.textViewEndEditBlock(self.shopIntroduceTextView.text);
        }
    }
}

-(void)setShopDesc:(NSString *)shopDesc{
    _shopDesc = shopDesc;
    self.shopIntroduceTextView.text = shopDesc;
    self.restInputWordLabel.text = [NSString stringWithFormat:@"%lu/%d",shopDesc.length,MaxInPutTextLength];
}

-(void)textViewDidChange:(UITextView *)textView{
    self.restInputWordLabel.text = [NSString stringWithFormat:@"%lu/%d",textView.text.length,MaxInPutTextLength];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

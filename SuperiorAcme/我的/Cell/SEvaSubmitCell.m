//
//  SEvaSubmitCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaSubmitCell.h"
#import "RatingBar.h"
#import "HRelease_imageView.h"

@interface SEvaSubmitCell () <UITextViewDelegate>
{
    NSMutableArray * imageArr;
}
@end

@implementation SEvaSubmitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 15;
    _submitBtn.layer.borderWidth = 1.0;
    _submitBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

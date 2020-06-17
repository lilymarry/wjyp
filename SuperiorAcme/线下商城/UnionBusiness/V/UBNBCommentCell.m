//
//  UBNBCommentCell.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBNBCommentCell.h"

@interface UBNBCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIView *starView;

@end

@implementation UBNBCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setNickname:(NSString *)nickname{
    self.userNameLab.text = nickname;
}

-(void)setStart_time:(NSString *)start_time{
    self.timeLab.text = start_time;
}

-(void)setStar:(NSInteger)star{
    
    for (int i = 0; i < star; i++) {
       UIImageView* imgV = self.starView.subviews[i];
        if (i < star) {
            imgV.image = [UIImage imageNamed:@"评价黄星"];
        }else{
            imgV.image = [UIImage imageNamed:@"评价白星"];
        }
    }
    
}

- (void)setHead_pic:(NSString *)head_pic{
    [self.userImgV sd_setImageWithURL:[NSURL URLWithString:head_pic]
                     placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

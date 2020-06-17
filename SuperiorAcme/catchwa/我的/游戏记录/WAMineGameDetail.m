//
//  WAMineGameDetail.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMineGameDetail.h"
#import "WAMineGameDetailApply.h"
#import "CommonHelp.h"
#import "WAVideoPlay.h"
@interface WAMineGameDetail ()
@property (weak, nonatomic) IBOutlet UIView *view_back;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headImaView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;

@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *resultLab;
@property (strong, nonatomic) IBOutlet UILabel *roomNumLab;

@end

@implementation WAMineGameDetail

- (void)viewDidLoad {
    [super viewDidLoad];
//    _view_back.layer.masksToBounds = YES;
//    _view_back.layer.cornerRadius = 15;
//    _view_back.layer.borderWidth = 0.1;
//    _view_back.layer.borderColor =[UIColor groupTableViewBackgroundColor].CGColor;
    
    self.title=@"游戏详情";
    
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.layer.cornerRadius = 15;
    _sureBtn.layer.borderWidth = 0.1;
    _sureBtn.layer.borderColor =[UIColor clearColor].CGColor;
    
    _headImaView.layer.masksToBounds = YES;
    _headImaView.layer.cornerRadius = _headImaView.frame.size.width/2;
    _headImaView.layer.borderWidth = 0.1;
    _headImaView.layer.borderColor =[UIColor clearColor].CGColor;
    
    [ _headImaView sd_setImageWithURL:[NSURL URLWithString:_model.room_pic]
                         placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    _nameLab.text=[NSString stringWithFormat:@"%@",_model.name];
    if ([_model.mode intValue]==0) {
       _resultLab.text=[NSString stringWithFormat:@"抓取失败"];
        [_resultLab setTextColor:[UIColor
                                      colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];
    }
    else{
        _resultLab.text=[NSString stringWithFormat:@"抓取成功"];
        [_resultLab setTextColor:navigationColor];
    }
    _timeLab.text=[CommonHelp timeWithTimeIntervalString:_model.update_time andFormatter:@"YYYY-MM-dd"];
    
    _roomNumLab.text=[NSString stringWithFormat:@"%d",[_model.roomid intValue]];
    
    if ([_model.mode intValue]!=0) {
        _sureBtn.hidden=YES;
    }
    
    
}
- (IBAction)sureBtnPress:(id)sender {
    WAMineGameDetailApply *apply=[[WAMineGameDetailApply alloc]init];
    apply.idStr=_model.id;
    [self.navigationController pushViewController:apply animated:YES];
}
- (IBAction)playVideo:(id)sender
{
    if (_model.video_url.length>0) {
        WAVideoPlay *play=[[WAVideoPlay alloc]init];
        play.playUrl=_model.video_url;
        [self.navigationController pushViewController:play animated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"视频无效，请稍后" toView:self.view];
    }
}


@end

//
//  UBTypeEntryHeadView.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/21.
//  Copyright © 2018年 GYM. All rights reserved.
//

#define UIColorHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#import "UBTypeEntryHeadView.h"
#import "SNBannerView.h"
//#import <Masonry.h>

@interface UBTypeEntryHeadView()

@property (weak, nonatomic) IBOutlet UIButton *firstLevelBtn;

@property (weak, nonatomic) SNBannerView *banner;

@end

@implementation UBTypeEntryHeadView


+(instancetype)instanceWithXIB{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (void)setTypeModel:(UBTypeModel *)typeModel{
    _typeModel = typeModel;
    [self.firstLevelBtn setTitle:_typeModel.type forState:0];
}


-(void)reloadDataWithDatas:(NSArray *)datas index:(NSInteger)index{
    [self.titles removeAllObjects];
    [self.titles insertObject:@"全部" atIndex:0];
    for (UBTypeModel *model in datas) {
        [self.titles addObject:model.type];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.segControl reload:self.titles selectIndex:index animated:NO];
    });
   
}

-(void)reloadBannerData:(id)data{
    if (SWNOTEmptyArr(data)) {
         [_banner removeFromSuperview];
          SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 240*2/3.0) delegate:nil model:data URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
        [self.bannerView addSubview:_banner = banner];
    }
}

#pragma mark - Action

- (IBAction)firstLevelBtnClick:(UIButton *)sender {
    if (self.firstLevelBtnBlock) {
        self.firstLevelBtnBlock(self.typeModel);
    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _segControl = [[DZMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_secondLevalView.frame), 240 / 6.0 - 0.5)];
    [self.secondLevalView addSubview:_segControl];
    _segControl.itemAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorHex(0x333333)};
    
    _segControl.itemSelectAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
    //    self.segmentedControl.delegate = self;
   // _segControl.backgroundColor = [UIColor blueColor];
    _segControl.sliderHeight = 1.5;
    
    _firstLevelBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI); ;
    UIButton *btn = _firstLevelBtn;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(btn.imageView.frame.size.width + 5), 0, (btn.imageView.frame.size.width + 5))];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (btn.titleLabel.frame.size.width), 0, -(btn.titleLabel.frame.size.width))];
}

-(NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

@end

//
//  UBTypePopUpView.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/22.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBTypePopUpView.h"
#import "UBTypePopCell.h"
#import "UBTypeEntryModel.h"

@interface UBTypePopUpView()

@property (weak, nonatomic) IBOutlet UIButton *firstLevelBtn;
@property (nonatomic, strong) NSMutableArray *secondLevelTitles;
@property (nonatomic, assign) NSInteger firstLevelSelectRow;

@end


@implementation UBTypePopUpView

- (IBAction)fitstLevelBtnAction:(UIButton *)sender {
    if (self.popViewClickBlock){
        UBTypeModel *firstLevelModel = _firstLevelDatas[_firstLevelSelectRow];
        self.popViewClickBlock(firstLevelModel, nil,nil);
    }
    [self missView];
}

-(void)missView{
    [UIView animateWithDuration:.35
                     animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Delegate && dataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UBTypePopCell *cell = [tableView dequeueReusableCellWithIdentifier:[UBTypePopCell cellIdentifier] forIndexPath:indexPath];
    
    if ([tableView isEqual:_firstLevelTableView]) {
        UBTypeModel *model = _firstLevelDatas[indexPath.row];
        
        [cell.logo sd_setImageWithURL:[NSURL URLWithString:model.cate_img]
                     placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        cell.contentLab.text = model.type;
        cell.contentView.backgroundColor = model.isClick ? [UIColor whiteColor] : [[UIColor grayColor] colorWithAlphaComponent:.1];
        
    }else if ([tableView isEqual:_secondLevelTableView]){
        cell.contentLab.text = self.secondLevelTitles[indexPath.row];
    }
    [cell cellSettingWithShowType:[tableView isEqual:_firstLevelTableView] ? UBTypePopCellStyle_img_lab : UBTypePopCellStyle_lab_underLine];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual:_firstLevelTableView]) {
        return _firstLevelDatas.count;
    }
    
    return self.secondLevelTitles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_firstLevelTableView]) {
        if (self.firstLevelDidSelectRowBlcok) {
            _firstLevelSelectRow = indexPath.row;
            UBTypeModel *model = _firstLevelDatas[indexPath.row];
            self.firstLevelDidSelectRowBlcok(model);
        }
    }else if ([tableView isEqual:_secondLevelTableView]){
//        [self fitstLevelBtnAction:nil];
        if (self.popViewClickBlock) {
            UBTypeModel *firstLevelModel = _firstLevelDatas[_firstLevelSelectRow];
            if (indexPath.row == 0) {  //只传一级
                self.popViewClickBlock(firstLevelModel, nil,nil);
            }else{
                 UBTypeEntryModel *entryModel = (id)_secondLevelDatas;
                UBTypeModel *secondLevelModel =  entryModel.nums[indexPath.row - 1]; //去掉全部
                self.popViewClickBlock(firstLevelModel, secondLevelModel,indexPath.row);
            }
        }
        [self missView];
    }
    
}

-(void)setFirstLevelDatas:(NSMutableArray *)firstLevelDatas
{
    _firstLevelDatas = firstLevelDatas;
    [self dealWithFirstLevelSingleClick];
}

-(void)dealWithFirstLevelSingleClick{
    for (int i = 0; i < _firstLevelDatas.count; i++) {
        UBTypeModel *model = _firstLevelDatas[i];
        if ([model.rec_type_id isEqualToString:_typeModel.rec_type_id]) {
            //第一次进入时 自动调取数据
            if(!_firstLevelSelectRow && !SWNOTEmptyArr(self.secondLevelTitles)){
                if (self.firstLevelDidSelectRowBlcok) {
                    self.firstLevelDidSelectRowBlcok(model);
                }
            }
            _firstLevelSelectRow = i;
            model.isClick = YES;
        }else{
            model.isClick = NO;
        }
    }
    
    [self.firstLevelTableView reloadData];
}

- (void)setTypeModel:(UBTypeModel *)typeModel{
    _typeModel = typeModel;
    [self.firstLevelBtn setTitle:_typeModel.type forState:0];
}

-(void)setSecondLevelDatas:(NSMutableArray *)secondLevelDatas{
    if (SWNOTEmptyArr(self.secondLevelTitles)) {
        [self.secondLevelTitles removeAllObjects];
    }
    
    NSString *formartStr = [NSString stringWithFormat:@"全部%@",_typeModel.type];
    [self.secondLevelTitles insertObject:formartStr atIndex:0];
    
    _secondLevelDatas = secondLevelDatas;
    UBTypeEntryModel *model = (id)secondLevelDatas;
    for (UBTypeModel *typeModel in model.nums) {
        [self.secondLevelTitles addObject:typeModel.type];
    }
    [_secondLevelTableView reloadData];
    
    [self dealWithFirstLevelSingleClick];
}

-(NSMutableArray *)secondLevelTitles{
    if (!_secondLevelTitles) {
        _secondLevelTitles = [NSMutableArray array];
    }
    return _secondLevelTitles;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    UIButton *btn = _firstLevelBtn;
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(btn.imageView.frame.size.width + 5), 0, (btn.imageView.frame.size.width + 5))];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (btn.titleLabel.frame.size.width), 0, -(btn.titleLabel.frame.size.width))];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.25];
    
    [UBTypePopCell xibWithCollectionView:_firstLevelTableView];
    [UBTypePopCell xibWithCollectionView:_secondLevelTableView];
    
    [self tableViewSetting:_firstLevelTableView];
    [self tableViewSetting:_secondLevelTableView];
}

- (void)tableViewSetting:(UITableView *)tableView{
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 100;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = 0;
}

+(instancetype)instanceWithXIB{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                         owner:nil
                                       options:nil].lastObject;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

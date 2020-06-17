//
//  LuckHandList.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/12/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "luckHandList.h"
#import "SGroupBuyHandList.h"
#import "SGroupBuyLuckHandListCell.h"
@interface LuckHandList ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (assign,nonatomic) NSInteger page;
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, strong) SGroupBuyHandList * user_info;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation LuckHandList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"手气值排行榜";
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
   // flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //_collectionView.pagingEnabled = YES;
   // _collectionView.showsHorizontalScrollIndicator = NO;
   // _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

   
    
     [_collectionView registerNib:[UINib nibWithNibName:@"SGroupBuyLuckHandListCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SGroupBuyLuckHandListCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footerView"];
     [self.view addSubview:_collectionView];
    self.page=1;
    [self getData];
    
}
-(void)getData
{
   
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    SGroupBuyHandList *model=[[SGroupBuyHandList alloc] init];
    
    model.a_id = _a_id ? _a_id : @"0";
    
   
    model.p=[NSString stringWithFormat:@"%d",(int)self.page];
 
    [model SGroupBuyHandListSuccess:^(NSString * code, NSString * message, id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        SGroupBuyHandList *infor=(SGroupBuyHandList *)data;
        if ([code isEqualToString:@"1"]) {
            _user_info=infor.data.user_info;
            self.dataArr =[NSArray arrayWithArray:infor.data.rank_list];
        
        [_collectionView reloadData];
      
        
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
       
    }];
    
}

//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ( _user_info!=nil) {
        return 2;
    }
    return 1;
    
  
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ( _user_info!=nil) {
        if (section==0) {
            return 1;
        }
        else
        {
        return _dataArr.count;
        }
        
    
}
    return _dataArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake(ScreenW, 50);
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SGroupBuyLuckHandListCell * oneCell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"SGroupBuyLuckHandListCell" forIndexPath:indexPath];
    SGroupBuyHandList * infor;
    if (_user_info!=nil) {
        if (indexPath.section==0) {
            infor=_user_info;
        }
        else
        {
            infor = _dataArr[indexPath.row];
        }
    }
    else
    {
       infor = _dataArr[indexPath.row];
    }
    oneCell.lab_name.text=infor.user_name;
    oneCell.lab_price.text=infor.user_count;
    [oneCell.ima_head sd_setImageWithURL:[NSURL URLWithString:infor.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    if ([infor.rank isEqualToString:@"1"]) {
        oneCell.lab_rank.hidden=YES;
        oneCell.ima_grade.hidden=NO;
        oneCell.ima_grade.image=[UIImage imageNamed:@"手气-1"];
    }
    else if ([infor.rank isEqualToString:@"2"])
    {
        oneCell.lab_rank.hidden=YES;
        oneCell.ima_grade.hidden=NO;
        oneCell.ima_grade.image=[UIImage imageNamed:@"手气-2"];
    }
    else if ([infor.rank isEqualToString:@"3"])
    {
        oneCell.lab_rank.hidden=YES;
        oneCell.ima_grade.hidden=NO;
        oneCell.ima_grade.image=[UIImage imageNamed:@"手气-3"];
    }
    else
    {
        oneCell.lab_rank.hidden=NO;
        oneCell.lab_rank.text=infor.rank;
        oneCell.ima_grade.hidden=YES;
        
    }
    return oneCell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {ScreenW,30};
    return size;
//    if ( _user_info!=nil) {
//      CGSize size = {ScreenW,30};
//        return size;
//    }
//    else
//    {
//        CGSize size = {0.01,0.01};
//        return size;
//    }
}
#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
     UICollectionReusableView *reusableview = nil;
     if (kind == UICollectionElementKindSectionHeader)
     {
          UICollectionReusableView * footer = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footerView" forIndexPath:indexPath];
         UILabel * footer_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
         [footer addSubview:footer_title];
         [footer_title setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
         footer_title.font = [UIFont systemFontOfSize:14];
         footer_title.textColor = WordColor_sub;
         footer_title.textAlignment = NSTextAlignmentLeft;
         reusableview = footer;
     }
     return reusableview;
}
@end

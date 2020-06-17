//
//  WAfirstItemListView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAfirstItemListView.h"
#import "WAFirstListCell.h"
#import "WAfirstItemListModel.h"
#import "GCDSocketManager.h"
#import "WAInRoom.h"
#import "EnterRoomModel.h"
@interface WAfirstItemListView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *dataArr;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollection;
@property (assign,nonatomic) NSInteger page;
@end

@implementation WAfirstItemListView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self refreshAndLoadMoreMethod];
}
- (void)refreshAndLoadMoreMethod{
    _mCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    [_mCollection.mj_header beginRefreshing];
    
    _mCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getData];
    }];
    
}
-(void)getData
{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    WAfirstItemListModel *model=[[WAfirstItemListModel alloc] init];
    
    model.per=[NSString stringWithFormat:@"%d",(int)self.page];
    model.clumn=_clumn;
    model.status=_status;
    
    [model WAfirstItemListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            WAfirstItemListModel *model=(WAfirstItemListModel *)data;
            if (self->_page==1) {
                [self->dataArr removeAllObjects];
                self->dataArr =[NSMutableArray arrayWithArray:model.data.list];
            }
            else
            {
                [self->dataArr addObjectsFromArray:model.data.list];
            }
           
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
        [self->_mCollection.mj_footer endRefreshing];
        [self->_mCollection.mj_header endRefreshing];
        
        [self->_mCollection reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
        [self->_mCollection.mj_footer endRefreshing];
        [self->_mCollection.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}
- (void)createUI {
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
    _mCollection.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollection.showsHorizontalScrollIndicator = NO;
    _mCollection.showsVerticalScrollIndicator = NO;
    
    
    //Cell
    [_mCollection registerNib:[UINib nibWithNibName:@"WAFirstListCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WAFirstListCell"];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArr.count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 );
    
    
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WAFirstListCell *mCell = [_mCollection dequeueReusableCellWithReuseIdentifier:@"WAFirstListCell" forIndexPath:indexPath];
    mCell.ima_focus.hidden=YES;
    WAfirstItemListModel *model=dataArr[indexPath.row] ;
    mCell.lab_name.text=model.name;
    mCell.moneyLab.text=model.price;

    if ([model.status_ming isEqualToString:@"热抓中"]) {
        [mCell.lab_type setBackgroundColor:[UIColor colorWithRed:254/255.0 green:73/255.0 blue:157/255.0 alpha:1]];
    }
    else
    {
        [mCell.lab_type setBackgroundColor:[UIColor colorWithRed:140/255.0 green:210/255.0 blue:67/255.0 alpha:1]];
    }
    mCell.lab_type.text=model.status_ming;

    [mCell.ima_headIcon sd_setImageWithURL:[NSURL URLWithString:model.room_pic]
                          placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    return mCell;

}

#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WAfirstItemListModel *model=dataArr[indexPath.row] ;
    if ( model.mac.length!=0) {
        [MBProgressHUD showMessage:nil toView:self.view];
        EnterRoomModel *room=   [[EnterRoomModel  alloc]init];
        room.id=model.id;
        [room EnterRoomModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
            if ([code intValue]==200) {
                [[GCDSocketManager sharedSocketManager]connectToServer:@"192.168.0.4" port:@"7771" complete:^(NSString * _Nonnull result) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    if ([result isEqualToString:@"1"]) {
                        WAInRoom *inroom=[[WAInRoom alloc]init];
                        inroom.hidesBottomBarWhenPushed=YES;
                        inroom.id=model.id;
                        inroom.mac=model.mac;
                        
                        [self.navigationController pushViewController:inroom animated:YES];
                    }
                    else{
                        [MBProgressHUD showError:@"房间连接失败，请稍后再试" toView:self.view];
                    }
                    
                }];
            }
            else
            {
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [MBProgressHUD showError:message toView:self.view];
            }
            
            
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            
        }];
        
        
    }
    else{
        [MBProgressHUD showError:@"房间编号为空" toView:self.view];
        
    }
}
@end

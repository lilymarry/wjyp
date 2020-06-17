//
//  WAFirstFocus.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAFirstFocus.h"
#import "FocusListModel.h"
#import "WAFirstListCell.h"
#import "FocusListModel.h"
#import "GCDSocketManager.h"
#import "WAInRoom.h"
#import "EnterRoomModel.h"
@interface WAFirstFocus ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    bool select;
    NSMutableArray *dataArr;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollection;

@property (weak, nonatomic) IBOutlet UIView *noDataView;

@end

@implementation WAFirstFocus

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self.navigationItem setTitle:@"我的收藏"];
    
    select=YES;
    
    [self CreatNavigationBar];
    [self getData];
    
}
-(void)getData{
     [MBProgressHUD showMessage:nil toView:self.view];
    FocusListModel *model=[[FocusListModel alloc]init];
    [model FocusListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            FocusListModel *model=(FocusListModel  *)data;
            dataArr =[NSMutableArray arrayWithArray:model.data];
            if (dataArr.count>0) {
                _mCollection.hidden=NO;
                _noDataView.hidden=YES;
            }
            else
             {
                _mCollection.hidden=YES;
                _noDataView.hidden=NO;
            }
            
            [_mCollection reloadData];
        }
        else
        {
      
            [MBProgressHUD showError:message toView:self.view];
        }
        
 
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
-(void)CreatNavigationBar{
  
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"保存" forState:UIControlStateSelected];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(editFocusMessage:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
}
-(void)editFocusMessage:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        select=NO;
    }
    else
    {
         select=YES;
    }
    [_mCollection reloadData];
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
    
    mCell.ima_focus.hidden=select;
    FocusListModel *model=dataArr[indexPath.row] ;
    mCell.lab_name.text=model.name;
    mCell.moneyLab.text=model.price;
    
    mCell.lab_type.hidden=NO;
    if ([model.status isEqualToString:@"0"]) {
        [mCell.lab_type setBackgroundColor:[UIColor colorWithRed:254/255.0 green:73/255.0 blue:157/255.0 alpha:1]];
        mCell.lab_type.text=@"热抓中";
    }
    else
    {
        [mCell.lab_type setBackgroundColor:[UIColor colorWithRed:140/255.0 green:210/255.0 blue:67/255.0 alpha:1]];
         mCell.lab_type.text=@"有空闲";
    }

    [mCell.ima_headIcon sd_setImageWithURL:[NSURL URLWithString:model.room_pic]
                          placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    [mCell.ima_focus addTarget:self action:@selector(touchDelect:) forControlEvents:UIControlEventTouchUpInside];
    mCell.ima_focus.tag=indexPath.row;
 
    return mCell;
}
- (void)touchDelect:(UIButton *)but {
    
  
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除关注的房间吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
   
        [MBProgressHUD showMessage:nil toView:self.view];
        FocusListModel *model=[[FocusListModel alloc]init];
        FocusListModel *List=dataArr[but.tag] ;
        model.cid=List.cid;
       
        model.status=@"0";
       
        [model AddFocusModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:message toView:self.view];
            if ([code intValue] ==200) {
                [self getData];
            }
            
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    FocusListModel *model=dataArr[indexPath.row] ;
    if ( model.mac.length!=0) {
        [MBProgressHUD showMessage:nil toView:self.view];
        EnterRoomModel *room=   [[EnterRoomModel  alloc]init];
        room.id=model.cid;
        [room EnterRoomModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        if ([code intValue]==200) {
                [[GCDSocketManager sharedSocketManager]connectToServer:@"192.168.0.4" port:@"7771" complete:^(NSString * _Nonnull result) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    if ([result isEqualToString:@"1"]) {
                        WAInRoom *inroom=[[WAInRoom alloc]init];
                        inroom.hidesBottomBarWhenPushed=YES;
                        inroom.id=model.cid;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

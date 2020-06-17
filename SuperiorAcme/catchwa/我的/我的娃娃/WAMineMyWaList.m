//
//  MAMineMyWaList.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMineMyWaList.h"
#import "WAMineMyWaListDetail.h"
#import "WAMineMyWaListCell.h"
#import "MyWAWATitleModel.h"
#import "MyWAWAListModel.h"
#import "CommonHelp.h"
#import "HeWaWaModel.h"
#import "WAInRoom.h"
#import "WAFirstListCell.h"
//倒计时
#import "OYCountDownManager.h"
@interface WAMineMyWaList ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString *type;
    NSArray *dataArr;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIView *line0;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topHHH;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHHH;
@property (strong, nonatomic) IBOutlet UIImageView *headImaView;
@property (strong, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;

@property (strong, nonatomic) IBOutlet UILabel *contentLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentLabHH;

@end

@implementation WAMineMyWaList

- (void)viewDidLoad {
    [super viewDidLoad];
    type=@"1";
    
    [self createUI];
    
   adjustsScrollViewInsets_NO(_mCollection, self);
    if (KIsiPhoneX) {
        _topHHH.constant=94;
    }
    else
    {
        _topHHH.constant=74;
    }
    if (_isUser) {
         _backView.hidden=YES;
         _backViewHHH.constant=0;
          self.title=@"TA的娃娃";
        [self getlistData];
    }
    else
    {
        _backView.hidden=NO;
        _backViewHHH.constant=90;
          self.title=@"我的娃娃";
        [self getMainData];
        [self getMylistData];
    }
    
    [self createNav];
    // 启动倒计时管理
    [kCountDownManager start];
    
}
- (void)createNav {
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setBackgroundColor:[UIColor clearColor]];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)lefthBtnClick
{
    BOOL isExit=NO;
    for(UIViewController *temp in self.navigationController.viewControllers) {
        if([temp isKindOfClass:[WAInRoom class]]){
            isExit=YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }
        
    }
    if(isExit==NO)
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}
-(void)getMainData
{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    MyWAWATitleModel *model=[[MyWAWATitleModel alloc] init];
    [model MyWAWATitleModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            
            MyWAWATitleModel *model=( MyWAWATitleModel *)data;
            [_segment setTitle:[NSString stringWithFormat:@"寄存中(%@)",model.data.count.deposit] forSegmentAtIndex:0];
            [_segment setTitle:[NSString stringWithFormat:@"待邮寄商品(%@)",model.data.count.wait] forSegmentAtIndex:1];
             [_segment setTitle:[NSString stringWithFormat:@"已发货商品(%@)",model.data.count.already] forSegmentAtIndex:2];
             [_segment setTitle:[NSString stringWithFormat:@"已兑换银两(%@)",model.data.count.exchange] forSegmentAtIndex:3];
           
            [_headImaView sd_setImageWithURL:[NSURL URLWithString:model.data.details.head_pic]
                                 placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
            _nameLab.text=model.data.details.nickname;
            _numLab.text=[NSString stringWithFormat:@"共抓中%@个",model.data.details.nums];
          
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
 
    } andFailure:^(NSError * _Nonnull error) {
      
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
}
-(void)getMylistData
{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    MyWAWAListModel *model=[[MyWAWAListModel alloc] init];
    model.type=type;
    [model MyWAWAListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            MyWAWAListModel *model=(MyWAWAListModel*)data;
            dataArr=[NSArray arrayWithArray:model.data.deposit];
            if ([type isEqualToString:@"1"]) {
              //   _contentLab.text=[NSString stringWithFormat:@"  %@",model.data.details];
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"温馨提示:%@",model.data.details]];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:navigationColor range:NSMakeRange(0,5)];
                
               _contentLab.attributedText = AttributedStr;
                _contentLabHH.constant=21;
                 _contentLab.hidden=NO;
                _backViewHHH.constant=90;
                //倒计时
                [kCountDownManager reload];
            }
            else
            {
                _contentLabHH.constant=0;
                _contentLab.hidden=YES;
                _backViewHHH.constant=60;
            }
           
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
        [self->_mCollection reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
}
-(void)getlistData
{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    HeWaWaModel *model=[[HeWaWaModel alloc] init];
    model.user_id=_user_id;
    [model HeWaWaModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            HeWaWaModel *model=(HeWaWaModel*)data;
            dataArr=[NSArray arrayWithArray:model.data.listDetails];
            if (model.data.userDetails.count>0||model.data.userDetails!=nil) {
                HeWaWaModel *subModel=model.data.userDetails[0];
                [_headImaView sd_setImageWithURL:[NSURL URLWithString:subModel.head_pic]
                                placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
                _nameLab.text=subModel.nickname;
                _numLab.text=[NSString stringWithFormat:@"共抓中%@个",subModel.cnum];
            }
            
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
        [self->_mCollection reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
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
    [_mCollection registerNib:[UINib nibWithNibName:@"WAMineMyWaListCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WAMineMyWaListCell"];
    
   
      [_mCollection registerNib:[UINib nibWithNibName:@"WAFirstListCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WAFirstListCell"];
    _segment.tintColor = [UIColor clearColor];
    //定义选中状态的样式selected，类型为字典
    NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                               NSForegroundColorAttributeName:[UIColor colorWithRed:245/255.0 green:70/255.0 blue:151/255.0 alpha:1]};
    //定义未选中状态下的样式normal，类型为字典
    NSDictionary *normal = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                             NSForegroundColorAttributeName:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]};
    
    //通过setTitleTextAttributes: forState: 方法来给test控件设置文字内容的格式
    [_segment setTitleTextAttributes:normal forState:UIControlStateNormal];
    [_segment setTitleTextAttributes:selected forState:UIControlStateSelected];
    
    //设置test初始状态下的选中下标
    _segment.selectedSegmentIndex = 0;
    
    _line0.frame=CGRectMake(20, 50, ScreenW/4-40, 1);
    
    _headImaView.layer.masksToBounds = YES;
    _headImaView.layer.cornerRadius = _headImaView.frame.size.width/2;
    _headImaView.layer.borderWidth = 0.1;
    _headImaView.layer.borderColor =[UIColor clearColor].CGColor;
    
    
}

-(IBAction)change:(UISegmentedControl *)sender{
    
    if (sender.selectedSegmentIndex == 0) {
        
    _line0.frame=CGRectMake(20, 50, ScreenW/4-40, 1);
        type=@"1";
        
    }
   else if (sender.selectedSegmentIndex == 1) {
        
       _line0.frame=CGRectMake( ScreenW/4+20, 50, ScreenW/4-40, 1);
        type=@"2";
    }
  else  if (sender.selectedSegmentIndex == 2) {
        
       _line0.frame=CGRectMake( ScreenW/2+20, 50, ScreenW/4-40, 1);
        type=@"3";
    }
    else {
       type=@"4";
     _line0.frame=CGRectMake(ScreenW/4*3+20, 50, ScreenW/4-40, 1);
    }
    [self getMylistData];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArr.count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5+40 );
    
    
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
 
    if (!_isUser) {
    WAMineMyWaListCell *mCell = [_mCollection dequeueReusableCellWithReuseIdentifier:@"WAMineMyWaListCell" forIndexPath:indexPath];
    MyWAWAListModel *model=dataArr[indexPath.item];

      
      mCell.roomNameLab.text=model.roomName;
         mCell.roomId.text=model.roomId;
        if (model.roomId.length==0) {
             mCell.roomId.hidden=YES;
        }
      [mCell.headIma sd_setImageWithURL:[NSURL URLWithString:model.goods_img]
                         placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        if ([type isEqualToString:@"1"]) {
             mCell.goods_nameLab.text=model.goods_name;
            mCell.num_lab.text=[NSString stringWithFormat:@"%@/%@",model.GraspingNum,model.catcherNum ];
             mCell.num_lab.hidden=NO;
            mCell.changeNumLab.text=[NSString stringWithFormat:@" 可兑换银两%@ ",model.exchange_price];
            mCell.changeNumLab.hidden=NO;
            //mCell.timeLab.text=model.maturityTime;
             mCell.timeLab.hidden=NO;
            mCell.start_time=model.maturityTime;
            
        }
        else
        {
            mCell.goods_nameLab.text=model.goodsName;
            mCell.timeLab.hidden=YES;
            mCell.changeNumLab.hidden=YES;
            mCell.num_lab.hidden=YES;
            
        }
      

    
       
         return mCell;
    }
    else
    {
        HeWaWaModel *model=dataArr[indexPath.item];
         WAFirstListCell *mCell = [_mCollection dequeueReusableCellWithReuseIdentifier:@"WAFirstListCell" forIndexPath:indexPath];
        mCell.lab_name.text=model.name;
        [mCell.ima_headIcon sd_setImageWithURL:[NSURL URLWithString:model.room_pic]
                              placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        mCell.ima_yuanbao.hidden=YES;
        mCell.ima_yuanbaoWW.constant=0;
        
        mCell.lab_type.hidden=YES;
        mCell.videoBtn.hidden=NO;
        mCell.videoBtn.tag=indexPath.item;
        mCell.moneyLab.text=[CommonHelp timeWithTimeIntervalString:model.create_time andFormatter:@"YYYY.MM.dd HH:mm:ss"] ;
        [mCell.moneyLab setTextColor:[UIColor lightGrayColor]];
        [mCell.videoBtn addTarget:self action:@selector(videoBtnPress:) forControlEvents:UIControlEventTouchUpInside];
         return mCell;
        
    }
   
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isUser) {
        //寄存中 和已发货 可点击
        if ([type isEqualToString:@"1"]||[type isEqualToString:@"3"]) {
            
      
        WAMineMyWaListDetail *detail=[[WAMineMyWaListDetail alloc]init];
        detail.listModel=dataArr[indexPath.item];
        [self.navigationController pushViewController:detail animated:YES];
        }}
    
}
-(void)videoBtnPress:(UIButton *)but
{
  //   HeWaWaModel *model=dataArr[but.tag];
   [MBProgressHUD showError:@"视频无效" toView:self.view];
    
}
@end

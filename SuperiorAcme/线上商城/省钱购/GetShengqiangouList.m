//
//  GetShengqiangouList.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "GetShengqiangouList.h"
#import "GetShengqiangouModel.h"
#import "GetShengqiangouListCell.h"
#import "ShengqiangouTitleModel.h"
@interface GetShengqiangouList ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString *sort_type;
    UITextField *textField;
    NSString  *name;
    NSString *type;
    UIScrollView      *scrollViewText;
    NSArray *titleData;
    UIButton *selectBtn;
}
@property (strong, nonatomic) IBOutlet UIButton *taobaoBtn;
@property (strong, nonatomic) IBOutlet UIButton *pingDuoduoBtn;
@property (strong, nonatomic) IBOutlet UILabel *taobaoLab;
@property (strong, nonatomic) IBOutlet UILabel *pingduoduoLab;

@property (strong, nonatomic) IBOutlet UIView *pingduoduoView;
@property (strong, nonatomic) IBOutlet UIButton *youhuiBtn;
@property (strong, nonatomic) IBOutlet UIButton *xiaoliangBtn;
@property (strong, nonatomic) IBOutlet UIButton *jiageBtn;
@property (strong, nonatomic) IBOutlet UIButton *yongquanBtn;

@property (strong, nonatomic) IBOutlet UIView *taobaoView;
@property (strong, nonatomic) IBOutlet UIButton *t_youhuiBtn;
@property (strong, nonatomic) IBOutlet UIButton *t_xiaoliangBtn;
@property (strong, nonatomic) IBOutlet UIButton *t_zongheBtn;

@property (strong, nonatomic) IBOutlet UICollectionView *mCollection;

@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (assign,nonatomic) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArr;
@end

@implementation GetShengqiangouList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _taobaoBtn.selected=YES;
    _taobaoLab.hidden=NO;
    _taobaoView.hidden=NO;
    _t_zongheBtn.selected=YES;
    type=@"1";
    
    
    _pingduoduoLab.hidden=YES;
    _pingDuoduoBtn.selected=NO;
    _pingduoduoView.hidden=YES;
    sort_type=@"999";
    
    [self createNav];
    
    [_mCollection registerNib:[UINib nibWithNibName:NSStringFromClass([GetShengqiangouListCell class]) bundle:nil] forCellWithReuseIdentifier:@"GetShengqiangouListCell"];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    ShengqiangouTitleModel *model=[[ShengqiangouTitleModel alloc]init];
    [model ShengqiangouTitleModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
            ShengqiangouTitleModel *model=(ShengqiangouTitleModel *)data;
            titleData=model.data;
            if (titleData.count>0) {
                for  ( ShengqiangouTitleModel *list in titleData ) {
                    if ([list.is_default intValue]==1) {
                         name=list.name;
                    }
                }
                if (name.length==0) {
                    ShengqiangouTitleModel *list=titleData[0];
                    name=list.name;
                }
                textField.text=name;
                
            }
            [self initScrollText];
            [self refreshAndLoadMoreMethod];
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置系统状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)refreshAndLoadMoreMethod{
    _mCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self showModel];
    }];
    [_mCollection.mj_header beginRefreshing];
    
    _mCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self showModel];
    }];
    
}
- (void)showModel {
    [textField resignFirstResponder];
    GetShengqiangouModel * index = [[GetShengqiangouModel alloc] init];
    index.type = type;
    index.sort_type=sort_type;
    index.q=name;
    index.p=[NSString stringWithFormat:@"%d",(int)self.page];
    [MBProgressHUD showMessage:nil toView:self.view];
    [index GetShengqiangouModelsSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==1) {
             GetShengqiangouModel * list = (GetShengqiangouModel *)data;
            if (_page==1) {
                [self.dataArr removeAllObjects];
                self.dataArr=[NSMutableArray arrayWithArray:list.data.goods_list];
              
            }
            else{
                [self.dataArr addObjectsFromArray:list.data.goods_list];
            }
           
        }
        else
        {
            [self.dataArr removeAllObjects];
            [MBProgressHUD showError:message toView:self.view];
        }
        [_mCollection reloadData];
        [_mCollection.mj_footer endRefreshing];
        [_mCollection.mj_header endRefreshing];
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        [_mCollection.mj_footer endRefreshing];
        [_mCollection.mj_header endRefreshing];
    }];
}
//文字滚动初始化
-(void) initScrollText{
    
    [scrollViewText removeFromSuperview];
    
    //获取滚动条
    
    if(!scrollViewText){
        scrollViewText = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW ,50)];
        scrollViewText.showsHorizontalScrollIndicator = YES;   //隐藏水平滚动条
        scrollViewText.showsVerticalScrollIndicator = NO;     //隐藏垂直滚动条
        
        //横竖屏自适应
        scrollViewText.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [scrollViewText setBackgroundColor:[UIColor clearColor]];
        
        //添加到当前视图
        [_titleView addSubview:scrollViewText];
    }else{
        //清除子控件
        for (UIView *view in [scrollViewText subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (titleData) {
        
        CGFloat offsetX = 0 ,i = 0, h = 30;
        
        //设置滚动文字
        UIButton *btnText = nil;
        NSString *strTitle = [[NSString alloc] init];
        
        for (   ShengqiangouTitleModel  *model in titleData) {
            
            strTitle =model.name;
            
            btnText = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnText setFrame:CGRectMake([self getTitleLeft:i]+5,
                                         10,
                                         strTitle.length * 18.0f,
                                         h)];
            
            
            [btnText setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btnText setTitleColor:[UIColor colorWithRed:240/255.0 green:41/255.0 blue:42/255.0 alpha:1] forState:UIControlStateSelected];
            
            [btnText setTitle:strTitle forState:UIControlStateNormal];
            btnText.titleLabel.font = [UIFont systemFontOfSize: 12.0];
            
            //横竖屏自适应
            //  btnText.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            offsetX +=CGRectGetWidth(btnText.bounds) ;
            btnText.userInteractionEnabled = YES;
            
            btnText.tag=i;
            [btnText addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];
            btnText.layer.cornerRadius = 10;
            btnText.layer.masksToBounds = YES;
            btnText.layer.borderWidth = 1;
            btnText.layer.borderColor = [UIColor lightGrayColor].CGColor;
            //添加到滚动视图
            [scrollViewText addSubview:btnText];
            
                if ([model.is_default intValue]==1) {
                    btnText.selected=YES;
                    [btnText setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
                    selectBtn=btnText;
                }
             
         
            i++;
        }
        if (selectBtn==nil) {
            
          NSArray *butArr=scrollViewText.subviews;
            if (butArr.count>0) {
            
                UIButton *but=butArr[1];

                if ([but isKindOfClass:[UIButton class]]) {
                    but.selected=YES;
                    [but setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
                    selectBtn=but;
                }
            }
          
        }
  
       [scrollViewText setContentSize:CGSizeMake(offsetX+25*titleData.count, 0)];
    }
}
-(float) getTitleLeft:(CGFloat) i {
    float left = i * 20.0f;
    
    if (i > 0) {
        for (int j = 0; j < i; j ++) {
            ShengqiangouTitleModel *model=[titleData objectAtIndex:j];
            NSString *   strTitle =model.name ;
            left += [strTitle length] * 18.0f;
        }
    }
    return left;
}
- (void)createNav {

    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    
    [rightBtn setImage:[UIImage imageNamed:@"红色搜索"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[rightBtnItem];
    
    
    textField=[[UITextField alloc]initWithFrame:CGRectMake(45, 0, ScreenW -44-60, 30)];
    textField.backgroundColor=[UIColor whiteColor];
    textField.borderStyle=UITextBorderStyleNone;
    self.navigationItem.titleView = textField;
    
}

- (void)rightBtnClick{
    [textField resignFirstResponder];

    if (textField.text.length==0) {
         [MBProgressHUD showError:@"输入搜索内容" toView:self.view];
        return;
    }
  else  if (![textField.text isEqualToString:name]) {
        selectBtn.selected=NO;
       [selectBtn setBackgroundColor:[UIColor clearColor]];
    }
    else
    {
        selectBtn.selected=YES;
          [selectBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
    name=textField.text;
    [self refreshAndLoadMoreMethod];
}

#pragma mark  选择淘宝/拼多多
- (IBAction)selectType:(id)sender
{
    UIButton *but=(UIButton *)sender;
    if (but.selected) {
        return;
    }
    else
    {
        if (but.tag==3001) {
            _taobaoBtn.selected=YES;
            _taobaoLab.hidden=NO;
            _taobaoView.hidden=NO;
            _pingduoduoLab.hidden=YES;
            _pingDuoduoBtn.selected=NO;
            _pingduoduoView.hidden=YES;
            
            _t_zongheBtn.selected=YES;
            _t_youhuiBtn.selected=NO;
            _t_xiaoliangBtn.selected=NO;
            type=@"1";
            sort_type=@"999";
            
        }
        else
        {
            _taobaoBtn.selected=NO;
            _taobaoLab.hidden=YES;
            _taobaoView.hidden=YES;
            _pingduoduoLab.hidden=NO;
            _pingDuoduoBtn.selected=YES;
            _pingduoduoView.hidden=NO;
            
            _youhuiBtn.selected=YES;
            _yongquanBtn.selected=NO;
            _t_xiaoliangBtn.selected=NO;
            _jiageBtn.selected=NO;
            type=@"3";
            sort_type=@"14";
        }
        
    }
      [self refreshAndLoadMoreMethod];
}
#pragma mark 淘宝/拼多多 按钮响应事件
- (IBAction)selectSubType:(id)sender
{
    static NSUInteger clickCount = 0;//用于记录当前按钮的点击次数,对点击次数求余,根据余数设置selected状态下的图片的显示
    UIButton *but=(UIButton *)sender;
    if (but.selected) {
        if (but.tag==1004) {
            clickCount  ++;
            
            if (clickCount % 2 == 0) {
                //记录余数,用于向服务器发送需求的排序
                [sender setImage:[UIImage imageNamed:@"升序"] forState:UIControlStateSelected];
                sort_type=@"3";
            }else{
                //记录余数,用于向服务器发送需求的排序
                [sender setImage:[UIImage imageNamed:@"降序"] forState:UIControlStateSelected];
                sort_type=@"4";
            }
            
        }
        else
        {
            return;
        }
        
    }
    else{
        but.selected=YES;
        if (but.tag==1004) {
            clickCount = 0;
            [sender setImage:[UIImage imageNamed:@"升序"] forState:UIControlStateSelected];
            sort_type=@"3";
        }
        if (_taobaoView.hidden==NO) {
            for (UIButton *button in _taobaoView.subviews) {
                if ([button isKindOfClass:[UIButton class]]) {
                    if (button.tag!=but.tag) {
                        button.selected=NO;
                    }
                    
                }
                
            }
        }
        if (_pingduoduoView.hidden==NO)
        {
            for (UIButton *button in _pingduoduoView.subviews) {
                if ([button isKindOfClass:[UIButton class]]) {
                    if (button.tag!=but.tag) {
                        button.selected=NO;
                    }
                }
                
            }
        }
        switch (but.tag) {
            case 2000:
                sort_type=@"999";
                break;
            case 2001:
                sort_type=@"2";
                break;
            case 2002:
                sort_type=@"1";
                break;
                
            case 1001:
                sort_type=@"14";
                break;
            case 1002:
                sort_type=@"9";
                break;
            case 1003:
                sort_type=@"6";
                break;
                
            default:
                break;
        }
        
        
    }
      [self refreshAndLoadMoreMethod];
    
}
#pragma mark scrollView 按钮响应事件
-(void)selectTitle:(UIButton *)but
{
    if (but.selected) {
        return;
    }
    else
    {
        but.selected=YES;
        selectBtn=but;
        but.backgroundColor=[UIColor groupTableViewBackgroundColor];
        for (UIButton *button in scrollViewText.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                if (button.tag!=but.tag) {
                    button.selected=NO;
                    button.backgroundColor=[UIColor clearColor];

                }
                
            }
        }
        
    }
    ShengqiangouTitleModel  *model=    titleData[ but.tag];
    name=model.name;
    textField.text=name;
    [self refreshAndLoadMoreMethod];
    
}
#pragma mark - =========================== CollectionView的delegate回调
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GetShengqiangouListCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GetShengqiangouListCell" forIndexPath:indexPath];
    GetShengqiangouModel *model=self.dataArr[indexPath.item];
    
    
    [commonCell.picImaView sd_setImageWithURL:[NSURL URLWithString:model.pict_url]
                             placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",model.title]];
    //NSTextAttachment可以将要插入的图片作为特殊字符处理
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    //定义图片内容及位置和大小
    if ([model.biaoshi isEqualToString:@"taobao"]) {
        attch.image = [UIImage imageNamed:@"淘宝"];
    }
    else if ([model.biaoshi isEqualToString:@"tianmao"]) {
        attch.image = [UIImage imageNamed:@"天猫"];
    }
    else
    {
        attch.image = [UIImage imageNamed:@"拼多多"];
    }
    
    attch.bounds = CGRectMake(0, 0, 13.5, 13.5);
    //创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    //将图片放在最后一位
    //[attri appendAttributedString:string];
    //将图片放在第一位
    [attri insertAttributedString:string atIndex:0];
    //用label的attributedText属性来使用富文本
    commonCell.titleLab.attributedText = attri;
    
    
    
    NSString *zk_final_price=[NSString stringWithFormat:@"%.2f",[model.zk_final_price floatValue]];
    
    NSString *reserve_price=[NSString stringWithFormat:@"%.2f",[model.reserve_price floatValue]];
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@ ¥%@",zk_final_price,reserve_price]];
    [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(zk_final_price.length+2,reserve_price.length+1)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(zk_final_price.length+2,reserve_price.length+1)];
    commonCell.priceLab.attributedText = AttributedStr;
    
    
//    NSMutableAttributedString * AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"30天内销量  %@",model.volume]];
//    [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(7 , model.volume.length+1)];
     commonCell.xiaoliangLab.text = [NSString stringWithFormat:@"近30天销量  %@",model.volume];
    
    return commonCell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenW/2 - 5, ScreenW/2 -5 + 40 + 20 + 15+15 );
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GetShengqiangouModel *model=self.dataArr[indexPath.item];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:model.item_url];
    if (@available(iOS 10.0, *)) {
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            NSLog(@"Open %@",model.item_url);
        }];
    } else {
        // Fallback on earlier versions
        BOOL success = [application openURL:URL];
        NSLog(@"Open %@: %d",model.item_url,success);
    }
}


@end

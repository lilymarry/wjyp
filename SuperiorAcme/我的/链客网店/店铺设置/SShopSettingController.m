//
//  SShopSettingController.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SShopSettingController.h"
#import "SShopSettingCell.h"
#import "SSetShopNameCell.h"
#import "SSetShopIntroduceCell.h"
#import "SShopSetModel.h"
#import "CommonHelp.h"
#import "SImageTool.h"
#import "ShopTimeCell.h"
#define PlaceHolderImage [UIImage imageNamed:@"无界优品默认空视图_方形"]

@interface SShopSettingController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic, strong) NSIndexPath * selectIndexPath;

@property (nonatomic, strong) SImageTool * ImageTool;

@property (nonatomic, copy) NSString * reSetShopName;
@property (nonatomic, copy) NSString * reSetShopDesc;
@property (nonatomic, strong) UIImage * reSetShopIconImage;

@end

static NSString * ShopSettingCellID = @"ShopSettingCellID";
static NSString * SetShopNameCellID = @"SetShopNameCellID";
static NSString * SetShopIntroduceCellID = @"SetShopIntroduceCellID";
static NSString * ShopTimeCelllID = @"ShopTimeCelllID";
@implementation SShopSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreatNavigationBar];
    
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [_mTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SShopSettingCell class]) bundle:nil] forCellReuseIdentifier:ShopSettingCellID];
    [_mTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSetShopNameCell class]) bundle:nil] forCellReuseIdentifier:SetShopNameCellID];
    [_mTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SSetShopIntroduceCell class]) bundle:nil] forCellReuseIdentifier:SetShopIntroduceCellID];
       [_mTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopTimeCell class]) bundle:nil] forCellReuseIdentifier:ShopTimeCelllID];
    
   // NSLog(@"AAAAQAQQ %@",self.shopTime);
    
}
-(void)CreatNavigationBar{
    self.title = @"店铺设置";
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"保存" forState:UIControlStateSelected];
    [rightBtn setTitleColor:[UIColor colorWithRed:210.0/255 green:31.0/255 blue:24.0/255 alpha:1] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(editShopMessage:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    
    
   // UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithTitle:@"<返回" style:UIBarButtonItemStyleDone target:self action:@selector(goLast)];
//     UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"黑色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(goLast)];
//    self.navigationItem.leftBarButtonItem=left;
    
}

-(void)editShopMessage:(UIButton *)btn{

    
    btn.selected = !btn.selected;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EditSelect" object:nil userInfo:@{@"EditSelect":@(btn.selected)}];
    
    if (!btn.selected) {
        [self UpdateShopMessageWithShopName:self.reSetShopName andShopDesc:self.reSetShopDesc andShopIconImage:self.reSetShopIconImage?self.reSetShopIconImage : PlaceHolderImage];
    }
}

#pragma mark - =========================== UITableViewDataSource =============================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = nil;
    NSArray * tempArr = @[@"店铺头像",@"店铺名称",@"有效期",@"店铺简介"];
    switch (indexPath.row) {
        case 0:
            {
                SShopSettingCell * shopSetCell = [tableView dequeueReusableCellWithIdentifier:ShopSettingCellID forIndexPath:indexPath];
                shopSetCell.titleLabel.text = tempArr[indexPath.row];
                [shopSetCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.shopPicUrl] placeholderImage:PlaceHolderImage];
                if (self.shopPicUrl.length!=0) {
                    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:self.shopPicUrl]];
                    _reSetShopIconImage=[UIImage imageWithData:data];
                }
                else{
                    _reSetShopIconImage=PlaceHolderImage;
                }
              
                cell = shopSetCell;
            }
            break;
        case 1:
            {
                SSetShopNameCell * setShopNameCell = [tableView dequeueReusableCellWithIdentifier:SetShopNameCellID];
                setShopNameCell.titleLabel.text = tempArr[indexPath.row];
                setShopNameCell.shopName = self.shopName;
                cell = setShopNameCell;
                setShopNameCell.textFieldEndEditBlock = ^(NSString *text) {
                    self.reSetShopName = text;
                };
            }
            break;
        case 2:
        {
            ShopTimeCell * setShopNameCell = [tableView dequeueReusableCellWithIdentifier:ShopTimeCelllID];
            setShopNameCell.lab_tittle.text = tempArr[indexPath.row];
           setShopNameCell.lab_time.text =[CommonHelp timeWithTimeIntervalString:self.shopTime andFormatter:@"YYYY-MM-dd"] ;
            cell = setShopNameCell;
        }
            break;
        case 3:
            {
                SSetShopIntroduceCell * introduceCell = [tableView dequeueReusableCellWithIdentifier:SetShopIntroduceCellID];
                introduceCell.titleLabel.text = tempArr[indexPath.row];
                introduceCell.shopDesc = self.shopDesc;
                if (self.shopDesc.length==0) {
                    introduceCell.shopDesc =@"终于等到你，还好我没放弃。欢迎光临本小店~";
                }
                cell = introduceCell;
                introduceCell.textViewEndEditBlock = ^(NSString *text) {
                    self.reSetShopDesc = text;
                };
            }
            break;
            
        default:
            break;
    }

    
    return cell;
}

#pragma mark - =========================== UITableViewDelegate =============================
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 106;
            break;
        case 1:
            return 49;
            break;
        case 2:
            return 44;
            break;
        case 3:
            return 193;
            break;
        default:
            return 0;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        self.selectIndexPath = indexPath;
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.ImageTool ChoiceImageFromCamera];
        }];
        UIAlertAction * AlbumAction = [UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.ImageTool ChoiceImageFromAlbums];
        }];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:photoAction];
        [alertVC addAction:AlbumAction];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

#pragma mark - 更新店铺信息
-(void)UpdateShopMessageWithShopName:(NSString *)shopName andShopDesc:(NSString *)shopDesc andShopIconImage:(UIImage *)shopIconImage{
    if (shopName.length>8) {
         [MBProgressHUD showSuccess:@"店铺名称的字数不能大于8个" toView:self.view];
        return;
    }
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:@[_shopId,shopName,shopDesc,shopIconImage] forKeys:@[@"id",@"shopName",@"shopDesc",@"shopIconImage"]];
    [MBProgressHUD showMessage:@"店铺信息更新中..." toView:self.view];
    [SShopSetModel UpdateShopMessageWithDict:dict andSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showSuccess:message toView:self.view];
        NSLog(@"%@",data);
        if (_delgate!=nil &&[_delgate respondsToSelector:@selector(refrechUserSetView)]) {
            [self.delgate refrechUserSetView];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
}

#pragma mark - 懒加载获取头像的工具类
-(SImageTool *)ImageTool{
    if (!_ImageTool) {
        _ImageTool = [[SImageTool alloc] init];
        _ImageTool.vc = self;
        
        __weak typeof(self) WeakSelf = self;
        _ImageTool.choiceImageCallBackBlock = ^(UIImage * choiceImage) {
            __strong typeof(WeakSelf) StrongSelf = WeakSelf;
        
            //当前设置头像的cell
            SShopSettingCell * setImageCell = [StrongSelf.mTableView cellForRowAtIndexPath:StrongSelf.selectIndexPath];
            setImageCell.iconImageView.image = choiceImage;
            StrongSelf.reSetShopIconImage = choiceImage;
        };
        
    }
    return _ImageTool;
}

@end

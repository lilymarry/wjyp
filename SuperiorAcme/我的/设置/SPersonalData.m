//
//  SPersonalData.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPersonalData.h"
#import "SPersonalDataCell.h"
#import "SPersonalData_top.h"
#import "SPhotoVC.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import "SUserUserInfo.h"
#import "SUserEditInfo.h"
#import "DatePicker_Country.h"
#import "SAddress_choice.h"
#import "SRealNameAuth.h"

@interface SPersonalData () <UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    SPersonalData_top * top;
    UIImagePickerController * _imagePickerPhoto;
    UIImagePickerController * _imagePickerCamera;
    NSArray * brr;
    
    NSString * user_id;
    NSString * nickname_edit;
    NSString * real_name;
    NSString * id_card_num;
    NSString * sex_edit;
    NSString * email_edit;
    
    NSString * province_id_edit;
    NSString * city_id_edit;
    NSString * area_id_edit;
    NSString * street_id_edit;
    
    NSString * province_name;
    NSString * city_name;
    NSString * area_name;
    NSString * street_name;
    
    NSString * parent_id;
    NSString * parent_name;
    NSString * parent_phone;
    
    UIImage * head_pic_edit;
    
    NSString * parent_alliance_merchant_name;//"所属联盟商家名称",
    NSString * parent_alliance_merchant_sn;//"所属联盟商家编号",
    NSString * hidden_parent_name;//"隐藏推荐人姓名",
    NSString * hidden_parent_phone;//"隐藏推荐人手机号"
    
    BOOL auth_status;//是否实名认证
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SPersonalData

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SPersonalDataCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SPersonalDataCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    top = [[SPersonalData_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    _mTable.tableHeaderView = top;
    [top.choiceBtn addTarget:self action:@selector(choiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    SUserUserInfo * userInfo = [[SUserUserInfo alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [userInfo sUserUserInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SUserUserInfo * userInfo = (SUserUserInfo *)data;
            [top.headerImage sd_setImageWithURL:[NSURL URLWithString:userInfo.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            
            user_id = userInfo.data.user_id;
            nickname_edit = userInfo.data.nickname;
            real_name = userInfo.data.real_name;
            id_card_num = userInfo.data.id_card_num;
            sex_edit = userInfo.data.sex;
            email_edit = userInfo.data.email;
            
            province_id_edit = userInfo.data.province_id;
            city_id_edit = userInfo.data.city_id;
            area_id_edit = userInfo.data.area_id;
            street_id_edit = userInfo.data.street_id;
            
            province_name = userInfo.data.province_name;
            city_name = userInfo.data.city_name;
            area_name = userInfo.data.area_name;
            street_name = userInfo.data.street_name;
            
            parent_id = userInfo.data.parent_id;
            parent_name = userInfo.data.parent_name;
            parent_phone = userInfo.data.parent_phone;
            
            hidden_parent_name = userInfo.data.hidden_parent_name;
            hidden_parent_phone = userInfo.data.hidden_parent_phone;
            parent_alliance_merchant_name = userInfo.data.parent_alliance_merchant_name;
            parent_alliance_merchant_sn = userInfo.data.parent_alliance_merchant_sn;
            
            brr = @[@[user_id],@[nickname_edit],@[real_name],@[id_card_num],@[sex_edit],@[email_edit],@[[NSString stringWithFormat:@"%@ %@ %@",province_name,city_name,area_name]],@[street_name],@[[parent_id isEqualToString:@"0"] ? [NSString stringWithFormat:@"%@",parent_name] : [NSString stringWithFormat:@"%@(%@)",parent_name,parent_id]],@[parent_phone],@[hidden_parent_name],@[hidden_parent_phone],@[parent_alliance_merchant_name],@[parent_alliance_merchant_sn]];
            [_mTable reloadData];
                        
        } else {
            [MBProgressHUD showError:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[SRegisterLogin shareInstance] deleteUserInfo];
                EMError *error = [[EMClient sharedClient] logout:YES];
                SLand * land = [[SLand alloc] init];
                UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                self.view.window.rootViewController = landNav;
            });
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"修改个人资料";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    SUserUserInfo * userInfo = [[SUserUserInfo alloc] init];
    [userInfo sUserUserInfoSuccess:^(NSString *code, NSString *message, id data) {
        SUserUserInfo * userInfo = (SUserUserInfo *)data;
         NSLog(@"2222---------------%@",userInfo.data.nickname);
        if ([userInfo.data.auth_status integerValue] != 2) {
//            [MBProgressHUD showError:@"请先完善个人认证" toView:self.view];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                SRealNameAuth * auth = [[SRealNameAuth alloc] init];
//                [self.navigationController pushViewController:auth animated:YES];
//            });
            auth_status = NO;
        } else {
            auth_status = YES;
        }
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
    }];
    
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setTitle:@"保存" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    SUserEditInfo * edit = [[SUserEditInfo alloc] init];
    if ([nickname_edit isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入昵称" toView:self.view];
        return;
    }
    edit.nickname = nickname_edit;
    edit.sex = sex_edit;
    if ([email_edit isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入邮箱" toView:self.view];
        return;
    }
    edit.email = email_edit;
    if ([province_id_edit isEqualToString:@""] || [province_id_edit isEqualToString:@"0"]) {
        [MBProgressHUD showError:@"请选择所在地区" toView:self.view];
        return;
    }
    edit.province_id = province_id_edit;
    edit.city_id = city_id_edit;
    edit.area_id = area_id_edit;
    if ([street_id_edit isEqualToString:@""] || [street_id_edit isEqualToString:@"0"]) {
        [MBProgressHUD showError:@"请选择所在街道" toView:self.view];
        return;
    }
    edit.street_id = street_id_edit;
    edit.head_pic = head_pic_edit;
    [MBProgressHUD showMessage:nil toView:self.view];
    [edit sUserEditInfoSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma mark - 选择头像
- (void)choiceBtnClick {
    
//    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];//旧代码
    
    /*
     *修复设置头像是,弹出选择头像选项后,背景色中有白条的问题
     */
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, NAVIGATION_BAR_HEIGHT)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view addSubview:view];
    
    SPhotoVC * phone = [[SPhotoVC alloc] init];
    phone.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:phone animated:YES completion:nil];
    
    //默认返回
    phone.SPhotoVC = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
    
    //选择图片
    phone.SPhotoVC_Choicek = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        
        //打开相册
        _imagePickerPhoto = [[UIImagePickerController alloc] init];
        _imagePickerPhoto.delegate = self;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            _imagePickerPhoto.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            _imagePickerPhoto.allowsEditing = YES;
            [self presentViewController:_imagePickerPhoto animated:YES completion:nil];
        }
    };
    
    //拍照
    phone.SPhotoVC_Photo = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        
        //相机
        _imagePickerCamera = [[UIImagePickerController alloc] init];
        _imagePickerCamera.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            _imagePickerCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
            CGAffineTransform cameraTransform = CGAffineTransformMakeScale(1.25, 1.25);
            _imagePickerCamera.cameraViewTransform = cameraTransform;
            
            _imagePickerCamera.allowsEditing = YES;
            [self presentViewController:_imagePickerCamera animated:YES completion:nil];
        }
    };
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker == _imagePickerPhoto) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            NSString * sourceType = [info objectForKey:UIImagePickerControllerMediaType];
            if ([sourceType isEqualToString:(NSString *)kUTTypeImage]) {
                
                UIImage * imagePhoto = info[UIImagePickerControllerEditedImage];
                UIImage * scaleImage = [self scaleToSize:imagePhoto size:CGSizeMake(320, 320)];
                [self chooseImage:scaleImage];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }
    } else {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            //设置只可拍照
            _imagePickerCamera.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
            NSString * sourceType = [info objectForKey:UIImagePickerControllerMediaType];
            
            if ([sourceType isEqualToString:(NSString *)kUTTypeImage]) {
                
                UIImage * imageCamera = info[UIImagePickerControllerEditedImage];
                
                SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
                UIImageWriteToSavedPhotosAlbum(imageCamera, self,selectorToCall, nil);
                UIImage * scaleImage = [self scaleToSize:imageCamera size:CGSizeMake(320, 320)];
                [self chooseImage:scaleImage];
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
            
        }
        
        
    }
}

- (void)chooseImage:(UIImage *)cImage
{
    top.headerImage.image = cImage;
    head_pic_edit = cImage;
}

//压缩图片为指定大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

- (NSString *)imageNameWithChoose:(UIImage *)image
{   NSString * suffix;
    NSString * contentType;
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        suffix = @"png";
        contentType = @"image/png";
    }else {
        //返回为JPEG图像。
        suffix = @"jpg";
        contentType = @"image/jpeg";
    }
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
    NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
    NSString * imageName = [NSString stringWithFormat:@"image_iPhone_%@.%@",appendStringToImageName,suffix];
    
    return imageName;
    
}

- (void)imageWasSavedSuccessfully:(UIImage *)cameraImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo
{
    
    if (paramError == nil){
        
        NSLog(@"保存相册成功");
        
    } else {
        
        NSLog(@"保存相册时发生错误");
        NSLog(@"Error = %@", paramError);
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 14;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2 || section == 3 || section == 4) {
        if (auth_status == NO) {
            //未实名认证隐藏
            return 0.01;
        } else {
            return 10;
        }
    }
    if (section == 7) {
        return 50;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 7) {
        UILabel * footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        footer.text = @"推荐人信息";
        footer.textColor = WordColor_sub;
        footer.font = [UIFont systemFontOfSize:14];
        footer.textAlignment = NSTextAlignmentCenter;
        return footer;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        if (auth_status == NO) {
            //未实名认证隐藏
            return 0.01;
        } else {
            return 50;
        }
    }
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPersonalDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SPersonalDataCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 6 || indexPath.section == 7) {
        cell.rightImage.hidden = NO;
    } else {
        cell.rightImage.hidden = YES;
    }
    if (indexPath.section == 1 || indexPath.section == 5) {
        cell.contentTF.userInteractionEnabled = YES;
        cell.contentTF.clearButtonMode = UITextFieldViewModeAlways;
    } else {
        cell.contentTF.userInteractionEnabled = NO;
        cell.contentTF.clearButtonMode = UITextFieldViewModeNever;

    }
    if (indexPath.section == 1 || indexPath.section == 5 || indexPath.section == 6 || indexPath.section == 7) {
        cell.thisShow.hidden = NO;
    } else {
        cell.thisShow.hidden = YES;
    }
    if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        if (auth_status == NO) {
            cell.thisTitle.hidden = YES;
            cell.contentTF.hidden = YES;
            cell.contentTF.textColor = WordColor_30;
        } else {
            cell.thisTitle.hidden = NO;
            cell.contentTF.hidden = NO;
            cell.contentTF.textColor = WordColor;
        }
    } else {
        cell.thisTitle.hidden = NO;
        cell.contentTF.hidden = NO;
        cell.contentTF.textColor = WordColor;
    }
    cell.thisTitle.text = @[@[@"会员ID"],@[@"昵称"],@[@"真实姓名"],@[@"身份证号"],@[@"性别"],@[@"邮箱"],@[@"所在地区"],@[@"所在街道"],@[@"推荐人姓名"],@[@"推荐人手机号"],@[@"隐藏推荐人姓名"],@[@"隐藏推荐人手机号"],@[@"所属联盟商家名称"],@[@"所属联盟商家编号"]][indexPath.section][indexPath.row];
    cell.thisTitle.font = [UIFont systemFontOfSize:17];
    cell.contentTF.text = brr[indexPath.section][indexPath.row];
    cell.contentTF.font = [UIFont systemFontOfSize:17];
    cell.contentTF.delegate = self;
    if (indexPath.section == 1) {
        [cell.contentTF setTag:0];
    }
    if (indexPath.section == 5) {
        [cell.contentTF setTag:1];
    }
    return cell;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        nickname_edit = textField.text;
    } else {
        email_edit = textField.text;
    }
    brr = @[@[user_id],@[nickname_edit],@[real_name],@[id_card_num],@[sex_edit],@[email_edit],@[[NSString stringWithFormat:@"%@ %@ %@",province_name,city_name,area_name]],@[street_name],@[[parent_id isEqualToString:@"0"] ? [NSString stringWithFormat:@"%@",parent_name] : [NSString stringWithFormat:@"%@(%@)",parent_name,parent_id]],@[parent_phone],@[hidden_parent_name],@[hidden_parent_phone],@[parent_alliance_merchant_name],@[parent_alliance_merchant_sn]];
    [_mTable reloadData];
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        SUserUserInfo * userInfo = [[SUserUserInfo alloc] init];
        [userInfo sUserUserInfoSuccess:^(NSString *code, NSString *message, id data) {
            SUserUserInfo * userInfo = (SUserUserInfo *)data;
            if ([userInfo.data.personal_data_status integerValue] == 0) {
                [MBProgressHUD showError:@"请先完善个人资料" toView:self.view];
            } else {
                //认证
                SRealNameAuth * auth = [[SRealNameAuth alloc] init];
                [self.navigationController pushViewController:auth animated:YES];
            }
        } andFailure:^(NSError *error) {
        }];
        
        
    }
//    if (indexPath.section == 4) {
//        //选择性别
//
//        UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
//        backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//        [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
//        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//        view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//        [self.view addSubview:view];
//
//        SPhotoVC * phone = [[SPhotoVC alloc] init];
//        phone.modalPresentationStyle = UIModalPresentationOverFullScreen;
//        [self presentViewController:phone animated:YES completion:nil];
//        [phone.photoBtn setTitle:@"女" forState:UIControlStateNormal];
//        [phone.choiceBtn setTitle:@"男" forState:UIControlStateNormal];
//        //默认返回
//        phone.SPhotoVC = ^() {
//            [backGroundView removeFromSuperview];
//            [view removeFromSuperview];
//        };
//
//        //女
//        phone.SPhotoVC_Photo = ^() {
//            [backGroundView removeFromSuperview];
//            [view removeFromSuperview];
//            sex_edit = @"女";
//            brr = @[@[user_id],@[nickname_edit],@[real_name],@[id_card_num],@[sex_edit],@[email_edit],@[[NSString stringWithFormat:@"%@ %@ %@",province_name,city_name,area_name]],@[street_name],@[[parent_id isEqualToString:@"0"] ? [NSString stringWithFormat:@"%@",parent_name] : [NSString stringWithFormat:@"%@(%@)",parent_name,parent_id]],@[parent_phone],@[hidden_parent_name],@[hidden_parent_phone],@[parent_alliance_merchant_name],@[parent_alliance_merchant_sn]];
//            [_mTable reloadData];
//        };
//        //男
//        phone.SPhotoVC_Choicek = ^() {
//            [backGroundView removeFromSuperview];
//            [view removeFromSuperview];
//            sex_edit = @"男";
//            brr = @[@[user_id],@[nickname_edit],@[real_name],@[id_card_num],@[sex_edit],@[email_edit],@[[NSString stringWithFormat:@"%@ %@ %@",province_name,city_name,area_name]],@[street_name],@[[parent_id isEqualToString:@"0"] ? [NSString stringWithFormat:@"%@",parent_name] : [NSString stringWithFormat:@"%@(%@)",parent_name,parent_id]],@[parent_phone],@[hidden_parent_name],@[hidden_parent_phone],@[parent_alliance_merchant_name],@[parent_alliance_merchant_sn]];
//            [_mTable reloadData];
//        };
//    }
    if (indexPath.section == 6) {
        UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
        backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
        [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
        [self.view addSubview:view];
        
        DatePicker_Country * pick = [[DatePicker_Country alloc] init];
        pick.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:pick animated:YES completion:nil];
        
        pick.DatePicker_Country_Back = ^{
            [backGroundView removeFromSuperview];
            [view removeFromSuperview];
        };
        pick.DatePicker_Country_Submit = ^(NSString *one, NSString *two, NSString *three, NSString *one_id, NSString *two_id, NSString *three_id) {
            [backGroundView removeFromSuperview];
            [view removeFromSuperview];
            
            province_id_edit = one_id;
            city_id_edit = two_id;
            area_id_edit = three_id;
            
            province_name = one;
            city_name = two;
            area_name = three;
            
            street_name = @"";
            street_id_edit = @"";
            
            brr = @[@[user_id],@[nickname_edit],@[real_name],@[id_card_num],@[sex_edit],@[email_edit],@[[NSString stringWithFormat:@"%@ %@ %@",province_name,city_name,area_name]],@[street_name],@[[parent_id isEqualToString:@"0"] ? [NSString stringWithFormat:@"%@",parent_name] : [NSString stringWithFormat:@"%@(%@)",parent_name,parent_id]],@[parent_phone],@[hidden_parent_name],@[hidden_parent_phone],@[parent_alliance_merchant_name],@[parent_alliance_merchant_sn]];
            [_mTable reloadData];
        };
    }
    if (indexPath.section == 7) {
        if ([area_id_edit isEqualToString:@"0"]) {
            [MBProgressHUD showError:@"请先选择所在地区" toView:self.view];
            return;
        }
        SAddress_choice * choiceAdd = [[SAddress_choice alloc] init];
        choiceAdd.area_id = area_id_edit;
        [self.navigationController pushViewController:choiceAdd animated:YES];
        choiceAdd.SAddress_choice_choice = ^(NSString *thisName, NSString *this_id) {
            street_name = thisName;
            street_id_edit = this_id;
            
            brr = @[@[user_id],@[nickname_edit],@[real_name],@[id_card_num],@[sex_edit],@[email_edit],@[[NSString stringWithFormat:@"%@ %@ %@",province_name,city_name,area_name]],@[street_name],@[[parent_id isEqualToString:@"0"] ? [NSString stringWithFormat:@"%@",parent_name] : [NSString stringWithFormat:@"%@(%@)",parent_name,parent_id]],@[parent_phone],@[hidden_parent_name],@[hidden_parent_phone],@[parent_alliance_merchant_name],@[parent_alliance_merchant_sn]];
            [_mTable reloadData];
        };
    }
}
@end

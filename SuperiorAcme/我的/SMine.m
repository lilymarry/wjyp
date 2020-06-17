//
//  SMine.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/6.
//  Copyright © 2017年 GYM. All rights reserved.
//
#define NAVBAR_CHANGE_POINT 50

#import "SMine.h"
#import "SMessage.h"
#import "SMineCell.h"
#import "SMine_top.h"
#import "SSet.h"//设置
#import "SMember.h"//会员
#import "SCarefreeGrade.h"//无忧会员
#import "SBalance.h"//余额
#import "Sintegral.h"//积分
#import "SShopCoupon.h"//购物券
#import "SCodePackage.h"//卡券包
#import "SOrderCenter.h"//订单中心
#import "SCollect.h"//我的收藏
#import "SFootprint.h"//我的足迹
#import "SAddress.h"//收货地址
#import "SEva.h"//我的评价
#import "SAcademy.h"
#import "SRegistrationCodeView.h"//注册码
#import "SShare.h"//分享好友
#import "SWorkAchievement.h"//分享成绩
#import "SComRecom_list.h"//商家推荐
#import "SHelp.h"//帮助中心
#import "SFeed.h"//意见反馈
#import "SAboutUs.h"//关于我们
#import "STicketFight.h"//无界商店
#import "SWelfareAgency.h"//福利社
#import "SListedIncubation.h"//上市孵化

#import "SUserUserCenter.h"
#import "SLand.h"
#import "SUserGetSignCode.h"
#import "SIndexIndex.h"

#import "SAllianceMerchant.h"//联盟商家推荐
#import "SExpandingBusiness.h"//拓展商
#import "SComCenter.h"
//#import "SOrderCenter_list.h"
#import "SPersonalData.h"

#import "CreateSeniorMemberViewController.h"//申请无界推广员
#import <MessageUI/MessageUI.h>

#import "UIView+customGetCurrentUIViewController.h"
#import "SUserUserCard.h"
#import "SCarefreeMember.h"
#import "CollectionAccountVC.h"

#import "SUserUserInfo.h"
#import "ShopCodeList.h"
#import "SMyShopController.h"

#import <Contacts/Contacts.h>

#import "SUserUserAddress.h"

#import "SShareContact1.h"

#import "MySgiftVoucher.h"

#import "SlineDetailWebController.h"
#import "CompleteUserView.h"
#import "GoodsManager.h"
#import "CleanMutualGoods.h"
@interface SMine () <UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate,MFMailComposeViewControllerDelegate,ShopCodeListDelegate>
{
    UIButton * rightWinBtn;
    UIButton * lefthBtn;
    SMine_top * top;
    NSString * server_line;//客服电话
    
    UILabel * mess_count;//角标个数

    NSString * merchant_easemob;
    NSString * merchant_name;
    NSString * merchant_logo;
    NSString * model_is_agent;//":"0",    //是否显示    代理加盟  0 不显示  1 显示
    NSString * model_is_alliance;//":"0"    //是否显示  联盟商家管理   0 不显示  1 显示
    NSString * user_card_type;//"1无界会员 2无忧会员 3优享会员 4其他会员"
    NSString * shop_card_status;//会员购买会员卡状态  0不开启  1开启
    NSString * activity_status;//首页活动是否开启，0不开启 订单直接普通商品跳转
    NSString * city_status;//": 0              // 是否填写个人资料所在地（0->否，1->是）
    NSString * blueCouponBalance;//蓝色代金券余额
    NSString * complete_status; //1 时赠送蓝色代金券 0时诚聘无界推广员
    /*
     *添加拜师码相关属性
     */
    NSString * member_trainer;//会员拜师码
    NSString * merchant_trainer;//商户拜师码
    NSString * QRCodeStr;//"邀请码",
    BOOL  isShowAccountBind;//三方收款账户绑定状态
  //  NSString * stage_merchant_id;//商家码id
    
    BOOL  isShowType;//显示商家码
    BOOL isShowJeanne_cate;//赠送蓝色代金券
    
    BOOL isshow;
    ShopCodeList *choseview;
    UIView *bgView ; //遮罩层
    NSArray *shopArr;//线下店铺
    NSArray *shopAccountArr;//线下可认证的店铺
    NSArray *shopTicketArr;//可赠送代金券的店铺
    
    NSString *  alliance_merchant;
    NSString *has_shop;
    NSString *shop_id_ming;
    NSString *shop_id;
    NSArray *userArr;//用户通讯录
    BOOL isNOo;
    
    NSString *return_ticket;
    
    NSString * uct_status;//店主身份
    NSString * chance_num;//银两
    NSString *clean_status;//寄售管理
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
/**
 邮箱控制器
 */
@property (nonatomic, strong)MFMailComposeViewController *mailSender;
/*
 *添加判断是否允许keyWindow添加mess_count的状态属性
 */
@property (nonatomic, assign) BOOL isAddMess_count;

@property (nonatomic, strong) NSArray *datas; //延时会员

@end

@implementation SMine

- (void)viewDidLoad {
    [super viewDidLoad];
    isNOo=NO;
    isshow =NO;
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SMineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SMineCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //创建顶部视图
    [self createSMineTopView];
    
    //下拉刷新
    [self initRefresh];
    
    //web 收到消息
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toChat:) name:@"toChat" object:nil];
}
/**
 创建顶部视图
 */
- (void)createSMineTopView {
    top = [[SMine_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/414*251 + 80)];
    __weak typeof(self) weakSelf = self;
    top.topBtnBlock = ^(NSInteger type) {
        [weakSelf topBtnEvent:type];
    };
    _mTable.tableHeaderView = top;
    [top.yanChangHuiYuanBtn addTarget:self
                               action:@selector(wentToZengSongHuiYuanPage)
                     forControlEvents:1<<6];
}
#pragma mark 请求通讯录权限
- (void)requestContactAuthorAfterSystemVersion9{
    
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    NSString *OKVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"OKPress"];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
            if (error) {
                NSLog(@"授权失败");
            }else {
                NSLog(@"成功授权");
            }
        }];
    }
    else if(status == CNAuthorizationStatusRestricted)
    {
        if (OKVersion.length==0) {
             [self showAlertViewAboutNotAuthorAccessContact];
        }
     
       
    }
    else if (status == CNAuthorizationStatusDenied)
    {
        if (OKVersion.length==0) {
            [self showAlertViewAboutNotAuthorAccessContact];
        }
    }
    else if (status == CNAuthorizationStatusAuthorized)//已经授权
    {
        //有通讯录权限-- 进行下一步操作
        [self openContact];
    }
    
}

//有通讯录权限-- 进行下一步操作
- (void)openContact{
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    NSMutableArray *arr=[NSMutableArray array];
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
 
        //拼接姓名
        NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        
        NSArray *phoneNumbers = contact.phoneNumbers;
        
        for (CNLabeledValue *labelValue in phoneNumbers) {
            CNPhoneNumber *honeNumber = labelValue.value;
            NSString * string = honeNumber.stringValue ;
            //去掉电话中的特殊字符
            string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSDictionary *dic=@{@"name":nameStr,@"phone":string};
            [arr addObject:dic];
        }
        //    *stop = YES; // 停止循环，相当于break；
        
    }];
    
    userArr =[NSArray arrayWithArray:arr];
    
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAddress"];
    if (saveVersion.length==0) {
    SUserUserAddress *user=[[SUserUserAddress alloc]init];
    user.PerSondata=arr;
    [user SUserUserAddressSuccess:^(NSString *code, NSString *message) {
        if ([code isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"userAddress"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        }
       else if ([code isEqualToString:@"0"]) {
           if ([message isEqualToString:@"重复添加！"]) {
               [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"userAddress"];
               [[NSUserDefaults standardUserDefaults] synchronize];
           }
           
        }
    } andFailure:^(NSError *error) {

    }];
    }
    
}

//提示没有通讯录权限
- (void)showAlertViewAboutNotAuthorAccessContact{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"请授权通讯录权限"
                                          message:@"请在iPhone的\"设置-隐私-通讯录\"选项中,允许无界优品访问你的通讯录"
                                          preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"不在提醒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setValue:@"OK" forKey:@"OKPress"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    [alertController addAction:OKAction];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }

    }];
    [alertController addAction:setAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     *当当前控制器的视图将要显示的时候,允许keyWindow添加mess_count
     */
    _isAddMess_count = YES;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白
    //tabBar-->重置、防止重影
    for (id obj in self.tabBarController.tabBar.subviews) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj removeFromSuperview];
        }
    }
    [self scrollViewDidScroll:_mTable];
    [TopWindow show];

}

- (void)viewDidDisappear:(BOOL)animated {
    [mess_count removeFromSuperview];
 
}
- (void)initRefresh
{
    __block SMine * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [blockSelf showModel];
        [blockSelf getUserDate];
        /*
         *在下拉刷新的时候,更新mess_count的未读消息数
         */
        [blockSelf GetMesscountTipMessage];
    }];
}
- (void)viewDidAppear:(BOOL)animated {

    /*
     * 修复点击更多按钮后,窗口无内容显示的问题(是因为keyWindow被修改的原因)
     * 重新设置应用的keyWindow
     */
    if (![UIApplication sharedApplication].windows.firstObject.keyWindow) {
        [[UIApplication sharedApplication].windows.firstObject makeKeyWindow];
    }
    
    //开始侧滑返回
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //判断侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    rightWinBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - NavigationBarTitleViewMargin, 20, NavigationBarTitleViewMargin, 44)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:rightWinBtn];
    [rightWinBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [mess_count removeFromSuperview];
    //获取当前未读消息数
    SIndexIndex * list = [[SIndexIndex alloc] init];
    list.lng = @"";
    list.lat = @"";
    [list sIndexIndexSuccess:^(NSString *code, NSString *message, id data) {
        
        
        [[EMClient sharedClient].chatManager getConversation:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account type:EMConversationTypeChat createIfNotExist:YES];
        [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
        
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSInteger totalUnreadCount = 0;
        for (EMConversation *conversation in conversations) {
            totalUnreadCount += conversation.unreadMessagesCount;
        }
        [mess_count removeFromSuperview];
        
        SIndexIndex * list = (SIndexIndex *)data;
        return_ticket=list.data.return_ticket;
        /*
         *根据"_isAddMess_count"的状态,来判断是否允许keyWindow添加mess_count
         */
        if (_isAddMess_count) {
            if ([list.data.msg_tip integerValue] != 0 || totalUnreadCount != 0) {
                if (ScreenW > 375) {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 25 - 58, STATUS_BAR_HEIGHT, 15, 15)];
                } else {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 25 - 48, STATUS_BAR_HEIGHT, 15, 15)];
                }
                
                mess_count.text = [NSString stringWithFormat:@"%ld",[list.data.msg_tip integerValue] + totalUnreadCount];
                mess_count.font = [UIFont systemFontOfSize:10];
                mess_count.textColor = [UIColor whiteColor];
                mess_count.backgroundColor = [UIColor orangeColor];
                mess_count.textAlignment = NSTextAlignmentCenter;
                mess_count.layer.masksToBounds = YES;
                mess_count.layer.cornerRadius = 7.5;
                [[[UIApplication sharedApplication] keyWindow] addSubview:mess_count];
            }
        }
        
    } andFailure:^(NSError *error) {
    }];
    
#pragma mark - 判断是否登录
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        self.view.window.rootViewController = landNav;
    } else {
        [self showModel];
        [self getUserDate];
        NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAddress"];
        
        if (saveVersion.length==0) {
            [self requestContactAuthorAfterSystemVersion9];
        }
    }
}
- (void)messagesDidReceive:(NSArray *)aMessages {
    if ([NSStringFromClass([self.navigationController.viewControllers.lastObject class]) isEqualToString:@"SMine"]) {
        [self viewDidAppear:YES];
    }
}
- (void)showModel {
    SUserUserCenter * center = [[SUserUserCenter alloc] init];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [center sUserUserCenterSuccess:^(NSString *code, NSString *message, id data) {
        [_mTable.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SUserUserCenter * center = (SUserUserCenter *)data;
            blueCouponBalance = center.data.blue_voucher;
            merchant_easemob = center.data.service_easemob_account;
            merchant_logo = center.data.service_head_pic;
            merchant_name = center.data.service_nickname;
            has_shop=center.data.has_shop;
            uct_status=center.data.uct_status;
            clean_status=center.data.clean_status;
            if ([center.data.has_shop isEqualToString:@"1"]) {
                shop_id_ming=center.data.shop_id_ming;
                shop_id=center.data.shop_id;
            }
            else
            {
                shop_id_ming=@"";
            }
          //  shopOutTime=center.data.has_shop;
            alliance_merchant=center.data.alliance_merchant;
            top.yanChangHuiYuanBtn.hidden = !center.data.reward_status;
            
            
            //是否显示三方绑定
//            if (![center.data.alliance_merchant isEqualToString:@"0"] && [center.data.change_account_status isEqualToString:@"1"]) {
//                // 显示三方绑定
//                isShowAccountBind = YES;
//            } else {
//                isShowAccountBind = NO;
//            }
            
            /*
             *保存拜师码相关信息
             */
            member_trainer = center.data.is_member_trainer;
            merchant_trainer = center.data.is_merchant_trainer;
            QRCodeStr = center.data.code;
         //   stage_merchant_id = center.data.stage_merchant_id;
            
            [[NSUserDefaults standardUserDefaults] setValue:QRCodeStr forKey:INVITE_CODE];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIViewController * vc = self.tabBarController.viewControllers[3];
            vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",[center.data.cart_num integerValue]];
            
            user_card_type = center.data.user_card_type;
            activity_status = center.data.activity_status;
            
            complete_status = center.data.complete_status;
            
            //如果已登录、地区参数未完善，提醒完善个人资料信息
            if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token != nil && [center.data.city_status integerValue] == 0) {
                
                CompleteUserView * header = [[CompleteUserView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
               
                header.money=return_ticket;
                header.block = ^{
                    SPersonalData * pd = [[SPersonalData alloc] init];
                    pd.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:pd animated:YES];
                };
                [self.view.window addSubview:header];
                
                
//                NSString *str=@"请完善个人资料";
//                if (return_ticket!=nil) {
//                    str=[NSString stringWithFormat:@"请完善个人资料,获取%@代金券!",return_ticket];
//                }
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请完善个人资料地区信息" preferredStyle:UIAlertControllerStyleAlert];
//                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                }]];
//                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    NSLog(@"点击确定");
//                    SPersonalData * pd = [[SPersonalData alloc] init];
//                    pd.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:pd animated:YES];
//                }]];
//                [self presentViewController:alertController animated:YES completion:nil];
            }
            
            [HttpManager checkTheUpdate:@"1342931428" responseResult:^(NSString * c1, NSString *c2, BOOL c3) {
                if ([self isNO:c1] == NO) {
                    shop_card_status = @"0";
                } else {
                    shop_card_status = @"1";
                }
                //根据版本号 控制无界会员购买入口的view
                [top viewIsShow:[self isNO:c1]];
                isNOo=[self isNO:c1];
                [_mTable reloadData];
            }];
            //给顶部视图top传递数据
            [top setValue:center];
            chance_num=center.data.chance_num;
            [lefthBtn setTitle:center.data.nickname forState:UIControlStateNormal];
            UIImageView * btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(7, 5, 30, 30)];
            btnImage.layer.masksToBounds = YES;
            btnImage.layer.cornerRadius = 15;
            [btnImage sd_setImageWithURL:[NSURL URLWithString:center.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            [lefthBtn addSubview:btnImage];
            server_line = center.data.server_line;
            model_is_agent = center.data.is_agent;
            model_is_alliance = center.data.is_alliance;
        } else {
            [MBProgressHUD showError:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[SRegisterLogin shareInstance] deleteUserInfo];
                EMError *error_err = [[EMClient sharedClient] logout:YES];
                SLand * land = [[SLand alloc] init];
                UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                self.view.window.rootViewController = landNav;
            });
        }
        
    } andFailure:^(NSError *error) {
        [_mTable.mj_header endRefreshing];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(void)getUserDate
{
    
  //  NSMutableArray *arr=[[NSMutableArray alloc]init];
    SUserUserInfo * center = [[SUserUserInfo alloc] init];
    [center sUserUserInfoSuccess:^(NSString *code, NSString *message, id data) {
        [_mTable.mj_header endRefreshing];
     
         if ([code isEqualToString:@"1"]) {
         SUserUserInfo * center = (SUserUserInfo *)data;
        uct_status=center.data.uct_status;
      
         bool result= [self change_account_statusFromData:center.data.mInfo withState:1];
            
            if (result && [center.data.alliance_merchant intValue]>0) {
                isShowAccountBind=YES;
            }
            else
            {
                isShowAccountBind=NO;
            }
            isShowType= [self change_account_statusFromData:center.data.mInfo withState:2];
            
            bool result1= [self change_account_statusFromData:center.data.mInfo withState:3];
            
            if ((result1 && [center.data.alliance_merchant intValue]>0)||[center.data.member_coding intValue]==3 ) {
                isShowJeanne_cate=YES;
            }
            else
            {
                isShowJeanne_cate=NO;
            }
            NSMutableArray *arr=[[NSMutableArray arrayWithArray:center.data.mInfo] copy];
           
            if (arr.count >0) {
                NSMutableArray *array = [NSMutableArray arrayWithArray:arr];
                [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *name = (NSDictionary*)obj;
                    //show_type=1就会出现商家码选择的弹框
                  if([name[@"show_type"] integerValue]!=1){
                        [array removeObject:obj];
                    }
                }];
                shopArr=[NSArray arrayWithArray:array];//商家码数组
            }
            
            NSMutableArray *arr1=[[NSMutableArray arrayWithArray:center.data.mInfo] copy];
            if (arr1.count>0) {
                NSMutableArray *array = [NSMutableArray arrayWithArray:arr1];
                [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *name = (NSDictionary*)obj;
                    //大于0 赠送蓝色代金券不显示
                   if([name[@"jeanne_cate"] integerValue]!=0){
                        [array removeObject:obj];
                    }
                }];
                shopTicketArr=[NSArray arrayWithArray:array];
            }
            
            NSMutableArray *arr2=[[NSMutableArray arrayWithArray:center.data.mInfo] copy];
            if (arr2.count>0) {
                NSMutableArray *array = [NSMutableArray arrayWithArray:arr2];
                [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *name = (NSDictionary*)obj;
                    //绑定三方收款账户弹窗
                    if([name[@"change_account_status"] integerValue]!=1){
                        [array removeObject:obj];
                    }
                }];
                shopAccountArr=[NSArray arrayWithArray:array];
            }
       
        }
     
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
    
}
-(BOOL)change_account_statusFromData:(NSArray *)data withState:(int)tag
{
    for (int i=0; i<data.count; i++) {
        if (tag==1) {
            if ([data[i][@"change_account_status"] integerValue]==1) {
                return YES;
            }
        }
        else if (tag==2)
        {
            if ([data[i][@"show_type"] integerValue]==1) {
                return YES;
            }
        }
        else
        {
            if ([data[i][@"jeanne_cate"] integerValue]==0) {
                return YES;
            }
        }
       
    }
    return NO;
}
-(void)selectShopCodeListData:(NSDictionary *)dic state:(NSString *)state
{
    [self hidThebgview];
    [choseview removeFromSuperview];
   // NSLog(@"SSSSS_ %@",dic);
    if ([state isEqualToString:@"2"]) {
           [self shopCode:dic[@"merchant_name"] andStage_merchant_id:dic[@"stage_merchant_id"]];
    }
    else
    {
      CollectionAccountVC *cavc = [[CollectionAccountVC alloc] init];
      cavc.isShowAlert = [top.fourNum.text doubleValue] < 2.0;
      cavc.shopId=dic[@"stage_merchant_id"];
      [self.navigationController pushViewController:cavc animated:YES];
    }
 
}
#pragma mark - 进入赠送会员界面
-(void)wentToZengSongHuiYuanPage{
    SUserUserCard * user = [[SUserUserCard alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [user sUserUserCardSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SUserUserCard * user = (SUserUserCard *)data;
        self.datas = user.data.list;
        
        SUserUserCard * list = [self.datas lastObject];
        
        SCarefreeMember * member = [[SCarefreeMember alloc] init];
        member.sale_status = list.sale_status;
        member.score_status = @"5";
        member.rank_id = list.rank_id;
        member.member_coding = list.member_coding;
        member.rank_name = list.rank_name;
        member.bannerArr = list.abs_url;
        member.thisMoney = list.money;
        member.is_get = list.is_get;
        member.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:member animated:YES];
        
       
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}

#pragma mark - 判断版本号
- (BOOL)isNO:(NSString *)c1 {
    // app版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *localVerson = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    //将版本号按照.切割后存入数组中
    NSArray *localArray = [localVerson componentsSeparatedByString:@"."];
    NSMutableArray * localArray_sub = [[NSMutableArray alloc] init];
    [localArray_sub addObjectsFromArray:localArray];
    NSArray *appArray = [c1 componentsSeparatedByString:@"."];
    NSMutableArray * appArray_sub = [[NSMutableArray alloc] init];
    [appArray_sub addObjectsFromArray:appArray];
    
    NSInteger num = 0;//循环次数
    if (localArray_sub.count > appArray_sub.count) {
        num = localArray_sub.count;
        for (int i = 0; i < localArray_sub.count - appArray_sub.count; i++) {
            [appArray_sub addObject:@"0"];
        }
    }
    if (localArray_sub.count < appArray_sub.count) {
        num = appArray_sub.count;
        for (int i = 0; i < appArray_sub.count - localArray_sub.count; i++) {
            [localArray_sub addObject:@"0"];
        }
    }
    if (localArray_sub.count == appArray_sub.count) {
        num = localArray_sub.count;
    }
    if (localArray_sub == appArray_sub) {
        return NO;
    }
    for(int i = 0; i < num; i++){//以最短的数组长度为遍历次数,防止数组越界
        //取出每个部分的字符串值,比较数值大小
        if([localArray_sub[i] integerValue] > [appArray_sub[i] integerValue]) {
            //从前往后比较数字大小,一旦分出大小,跳出循环
            return NO;
        }
    }
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    /*
     *当当前控制器的视图将要"不显示"的时候,不允许keyWindow添加mess_count
     */
    _isAddMess_count = NO;
    
    
    [self.navigationController.navigationBar lt_reset];
    
    [mess_count removeFromSuperview];
    [rightWinBtn removeFromSuperview];
}
- (void)createNav {

    lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 150, 44);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    lefthBtn.titleEdgeInsets = UIEdgeInsetsMake(-5, 7 + 7 + 30,0, 0);
    lefthBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lefthBtn.hidden = YES;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0,0,-15);
    [rightBtn setImage:[UIImage imageNamed:@"导航栏设置"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn_sub.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * rightBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:rightBtn_sub];
    rightBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-25);
    [rightBtn_sub setImage:[UIImage imageNamed:@"导航栏消息"] forState:UIControlStateNormal];
    [rightBtn_sub addTarget:self action:@selector(rightBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem,rightBtnItem_sub];

}
#pragma mark - 设置
- (void)rightBtnClick {
    [mess_count removeFromSuperview];
    SSet * set = [[SSet alloc] init];
    set.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:set animated:YES];
}
#pragma mark - 消息
- (void)rightBtn_subClick {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
            //            [self showModel];
        };
        return;
    }
    
    [mess_count removeFromSuperview];
    SMessage * mess = [[SMessage alloc] init];
    mess.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mess animated:YES];
}

/**
 顶部视图点击事件

 @param num tag值
 */
- (void)topBtnEvent:(NSInteger)num {
    [mess_count removeFromSuperview];
    NSInteger _num = num;
    UIViewController * tmp_vc;
    switch (_num) {
        case 1:
            #pragma mark - 无忧会员
        {
            if (!top.yanChangHuiYuanBtn.hidden) {
                [self wentToZengSongHuiYuanPage];
                return;
            }
            SCarefreeGrade * member = [[SCarefreeGrade alloc] init];
            tmp_vc = member;
        }
            break;
        case 2:
            #pragma mark - 会员等级
        {
            SMember * member = [[SMember alloc] init];
            tmp_vc = member;
            member.type = YES;
        }
            break;
        case 4:
            #pragma mark - 余额
        {
            SBalance * balance = [[SBalance alloc] init];
            balance.complete_status = complete_status;
            balance.user_card_type = user_card_type;
            balance.alliance_merchant=alliance_merchant;
            balance.shopid=shop_id_ming;
            balance.viewType = @"1";
            tmp_vc = balance;
        }
            break;
        case 3:
            #pragma mark - 积分
        {
            Sintegral * integ = [[Sintegral alloc] init];
            integ.complete_status = complete_status;
            integ.user_card_type = user_card_type;
            integ.uct_status = uct_status;
            integ.type=@"1";
            tmp_vc = integ;
        }
            break;
        case 5:
            #pragma mark - 购物券
        {
            SShopCoupon * shopCou = [[SShopCoupon alloc] init];
            tmp_vc = shopCou;
        }
            break;
        case 6:
#pragma mark - 银两
        {
            Sintegral * integ = [[Sintegral alloc] init];
            integ.chance_num = chance_num;
            integ.type=@"2";
            tmp_vc = integ;
        }
            break;
        case 7:
    #pragma mark - 赠品券
        {
            MySgiftVoucher *gift=[[MySgiftVoucher alloc]init];
            tmp_vc = gift;
        }
            break;

        default:
            break;
    }
    tmp_vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tmp_vc animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }
    if (section == 1) {
        return 13;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 10;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([shop_card_status integerValue] == 0) {
                return 0.01;
            }
        }
    }
    if (indexPath.section == 1) {

        if (indexPath.row == 0) {
        //隐藏店铺管理
            if (!([has_shop integerValue] == 1)) {
            return 0.01;
            }
        }
        /*
         *显示隐藏拜师码cell
         */
        if (indexPath.row == 3) {
            if ([member_trainer isEqualToString:@""] && [merchant_trainer isEqualToString:@""]) {
                return 0.01;
            }
        }
        //赠送蓝色代金券
        if (indexPath.row == 6) {
            if (![complete_status isEqualToString:@"1"]) {
                 return 50;
            }
            if (!isShowJeanne_cate) {
                return 0.01;
            }
        }
        else if (indexPath.row == 7)
        {   //商家推荐
            if([user_card_type isEqualToString:@"2"]||[user_card_type isEqualToString:@"3"])
            {
                return 50;
            }
            
            else {
                return 0.01;
            }
        }
        if (indexPath.row == 8) {
            //是否显示    代理加盟  0 不显示  1 显示
            if ([model_is_agent integerValue] == 0) {
                return 0.01;
            }
        }
        if (indexPath.row == 9) {
            //是否显示  联盟商家管理   0 不显示  1 显示
            if ([model_is_alliance integerValue] == 0) {
                return 0.01;
            }
        }
        if ( indexPath.row == 10) {
            //是否显示  三方收款绑定
            if (!isShowAccountBind) {
                return 0.01;
            }
        }

        if ( indexPath.row == 11) {
            //是否显示  商家码
            if (!isShowType) {
                return 0.01;
            }
        }
        if ( indexPath.row == 12) {
            //是否显示  寄售管理
            if ([clean_status isEqualToString:@"0"]) {
                return 0.01;
            }
        }
    }
  
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SMineCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SMineCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    static NSString *complete_status_strTitle = @"";
    if (complete_status != nil) {
        //使用新规则
        [complete_status isEqualToString:@"1"] ? (complete_status_strTitle = @"赠送蓝色代金券") : (complete_status_strTitle = @"申请无界推广员");
    } else {
        //使用老规则
        [user_card_type isEqualToString:@"3"] ? (complete_status_strTitle = @"赠送蓝色代金券") : (complete_status_strTitle = @"申请无界推广员");
    }
     static NSString *strTitle = @"";
     static NSString *strTitle1 = @"";
//    if ([Url_header isEqualToString:@"test2"])
//    {
        strTitle=@"店铺管理";
        strTitle1=@"我的店铺Web";
        
//    }
//     else
//     {
//      strTitle=@"商家码";
//       strTitle1=@"我的注册码";
//     }
    
   // NSLog(@"ASXzd %@",complete_status_strTitle);
    cell.thisTitle.text = @[@[@"卡券包",@"订单中心",@"我的收藏",@"我的足迹",@"收货地址",@"我的评价"],@[@"链客网店" ,@"无界书院",@"注册码",@"拜师码",@"分享好友",@"分享成绩",complete_status_strTitle,@"商家推荐",@"代理加盟",@"联盟商家管理中心",@"三方收款账户绑定",strTitle,@"寄售管理"],@[@"帮助中心",@"意见反馈",@"评分鼓励",@"关于我们",@"在线客服"]][indexPath.section][indexPath.row];
    cell.headerImage.image = [UIImage imageNamed:@[@[@"我的卡券包",@"我的订单中心",@"我的收藏",@"我的足迹",@"我的收货地址",@"我的评价"],@[@"店铺管理",@"我的无界书院",@"我的注册码",@"我的注册码",@"我的分享好友",@"我的分享成绩",@"赠送蓝色优惠券",@"我的商家推荐",@"我的代理加盟",@"我的联盟商家管理中心",@"三方收款账户绑定",strTitle1,strTitle1],@[@"我的帮助中心",@"我的意见反馈",@"我的评分鼓励",@"我的关于我们",@"我的在线客服"]][indexPath.section][indexPath.row]];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([shop_card_status integerValue] == 0) {
                cell.thisTitle.hidden = YES;
                cell.headerImage.hidden = YES;
                cell.rightR.hidden = YES;
            } else {
                cell.thisTitle.hidden = NO;
                cell.headerImage.hidden = NO;
                cell.rightR.hidden = NO;
            }
        } else {
            cell.thisTitle.hidden = NO;
            cell.headerImage.hidden = NO;
            cell.rightR.hidden = NO;
        }
    } else if (indexPath.section == 1) {

        if (indexPath.row==0) {
            if (!([has_shop integerValue] == 1)) {
                cell.thisTitle.hidden = YES;
                cell.headerImage.hidden = YES;
                cell.rightR.hidden = YES;
            }
            else
            {
                cell.thisTitle.hidden = NO;
                cell.headerImage.hidden = NO;
                cell.rightR.hidden = NO;
            }
        }
        /*
         *显示隐藏拜师码界面
         */
       else if (indexPath.row == 3) {
            if ([merchant_trainer isEqualToString:@""] && [member_trainer isEqualToString:@""]) {
                cell.thisTitle.hidden = YES;
                cell.headerImage.hidden = YES;
                cell.rightR.hidden = YES;
            }else{
                cell.thisTitle.hidden = NO;
                cell.headerImage.hidden = NO;
                cell.rightR.hidden = NO;
            }
        }
        else if (indexPath.row == 6)
        {   //赠送蓝色代金券
             if([complete_status isEqualToString:@"1"])
            {
                if (!isShowJeanne_cate) {
                    cell.thisTitle.hidden = YES;
                    cell.headerImage.hidden = YES;
                    cell.rightR.hidden = YES;
                }
                else
                {
                    cell.thisTitle.hidden = NO;
                    cell.headerImage.hidden = NO;
                    cell.rightR.hidden = NO;
                }
            }
            else {
                cell.thisTitle.hidden = NO;
                cell.headerImage.hidden = NO;
                cell.rightR.hidden = NO;
            }
        }
        else if (indexPath.row == 7)
        {   //商家推荐
            if([user_card_type isEqualToString:@"2"]||[user_card_type isEqualToString:@"3"])
            {
                    cell.thisTitle.hidden = NO;
                    cell.headerImage.hidden = NO;
                    cell.rightR.hidden = NO;
            }
           
            else {
                cell.thisTitle.hidden = YES;
                cell.headerImage.hidden = YES;
                cell.rightR.hidden = YES;
            }
        }
        else if (indexPath.row == 8)
        {
            if ([model_is_agent integerValue] == 0) {
                cell.thisTitle.hidden = YES;
                cell.headerImage.hidden = YES;
                cell.rightR.hidden = YES;
            } else {
                cell.thisTitle.hidden = NO;
                cell.headerImage.hidden = NO;
                cell.rightR.hidden = NO;
            }
        }
        else  if (indexPath.row == 9)
        {
            if ([model_is_alliance integerValue] == 0) {
                cell.thisTitle.hidden = YES;
                cell.headerImage.hidden = YES;
                cell.rightR.hidden = YES;
            } else {
                cell.thisTitle.hidden = NO;
                cell.headerImage.hidden = NO;
                cell.rightR.hidden = NO;
            }
        }
        else  if (indexPath.row == 10) {
            if (!isShowAccountBind) {
                cell.thisTitle.hidden = YES;
                cell.headerImage.hidden = YES;
                cell.rightR.hidden = YES;
            } else {
                cell.thisTitle.hidden = NO;
                cell.headerImage.hidden = NO;
                cell.rightR.hidden = NO;
            }
          }
        else  if (indexPath.row == 11) {
            if (!isShowType) {
                cell.thisTitle.hidden = YES;
                cell.headerImage.hidden = YES;
                cell.rightR.hidden = YES;
            } else {
                cell.thisTitle.hidden = NO;
                cell.headerImage.hidden = NO;
                cell.rightR.hidden = NO;
            }
        }
        else  if (indexPath.row == 12) {
            if ([clean_status isEqualToString:@"0"]) {
                cell.thisTitle.hidden = YES;
                cell.headerImage.hidden = YES;
                cell.rightR.hidden = YES;
            } else {
                cell.thisTitle.hidden = NO;
                cell.headerImage.hidden = NO;
                cell.rightR.hidden = NO;
            }
        }
        else {
            cell.thisTitle.hidden = NO;
            cell.headerImage.hidden = NO;
            cell.rightR.hidden = NO;
          }

    } else {

                 cell.thisTitle.hidden = NO;
                  cell.headerImage.hidden = NO;
               cell.rightR.hidden = NO;

    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SMineCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
#pragma mark - 卡券包
            
            [mess_count removeFromSuperview];
            SCodePackage * codePack = [[SCodePackage alloc] init];
            codePack.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:codePack animated:YES];
        } else if (indexPath.row == 1) {
#pragma mark - 订单中心
            
            [mess_count removeFromSuperview];
            SOrderCenter * orderCen = [[SOrderCenter alloc] init];
            orderCen.activity_status = activity_status;
            orderCen.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:orderCen animated:YES];
            
            
        } else if (indexPath.row == 2) {
#pragma mark - 我的收藏
            
            [mess_count removeFromSuperview];
            SFootprint * footprint = [[SFootprint alloc] init];
            footprint.hidesBottomBarWhenPushed = YES;
            footprint.type = YES;
            [self.navigationController pushViewController:footprint animated:YES];
        } else if (indexPath.row == 3) {
#pragma mark - 我的足迹
            
            [mess_count removeFromSuperview];
            SFootprint * footprint = [[SFootprint alloc] init];
            footprint.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:footprint animated:YES];
        } else if (indexPath.row == 4) {
#pragma mark - 收货地址
            
            [mess_count removeFromSuperview];
            SAddress * address = [[SAddress alloc] init];
            address.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:address animated:YES];
        } else if (indexPath.row == 5) {
#pragma mark - 我的评价
            
            [mess_count removeFromSuperview];
            SEva * eva = [[SEva alloc] init];
            eva.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:eva animated:YES];
        }
    }
    if (indexPath.section == 1) {
  #pragma mark - 店铺管理
        if (indexPath.row==0) {
                    SMyShopController * myShopVC = [[SMyShopController alloc] init];
                    myShopVC.hidesBottomBarWhenPushed = YES;
                    myShopVC.shopid=shop_id_ming;
                    myShopVC.hasShop=has_shop;
                    myShopVC.shopidMing=shop_id;
                    [self.navigationController pushViewController:myShopVC animated:YES];
        }
        
        if (indexPath.row == 1) {
#pragma mark - 无界书院
            
            [mess_count removeFromSuperview];
            SAcademy * acad = [[SAcademy alloc] init];
            acad.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:acad animated:YES];
        } else if (indexPath.row == 2) {
#pragma mark - 注册码
            
            SRegistrationCodeView * codeView = [[SRegistrationCodeView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            
            //给二维码添加点击手势
            UITapGestureRecognizer *codeViewImageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QRImageTapGesture:)];
            codeView.thisImage.userInteractionEnabled = YES;
            [codeView.thisImage addGestureRecognizer:codeViewImageTapGesture];
            
            codeView.QRCodeType = cell.thisTitle.text;
            [[[UIApplication sharedApplication] keyWindow] addSubview:codeView];
            codeView.SRegistrationCodeViewBack = ^{
                [codeView removeFromSuperview];
            };
            
            SUserGetSignCode * signCode = [[SUserGetSignCode alloc] init];
            [signCode sUserGetSignCodeSuccess:^(NSString *code, NSString *message, id data) {
                SUserGetSignCode * signCode = (SUserGetSignCode *)data;
                
                UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:signCode.data.code] withSize:250.0f];
                UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:0.0f andGreen:0.0f andBlue:0.0f];
                codeView.thisImage.image = customQrcode;
                
                [codeView.header_pic sd_setImageWithURL:[NSURL URLWithString:signCode.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

            } andFailure:^(NSError *error) {
            }];

        }else if (indexPath.row == 3) {
#pragma mark - 拜师码
            
            SRegistrationCodeView * codeView = [[SRegistrationCodeView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            
            //给二维码添加点击手势
            UITapGestureRecognizer *codeViewImageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QRImageTapGesture:)];
            codeView.thisImage.userInteractionEnabled = YES;
            [codeView.thisImage addGestureRecognizer:codeViewImageTapGesture];
            
            //生成二维码字符串的回调
            __weak typeof(codeView) WeakSelfCodeView = codeView;
            codeView.passQRCodeStrBlock = ^(NSString *QRCodeStr) {
                UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:QRCodeStr] withSize:250.0f];
                UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:0.0f andGreen:0.0f andBlue:0.0f];
                WeakSelfCodeView.thisImage.image = customQrcode;
//                [codeView.header_pic sd_setImageWithURL:[NSURL URLWithString:signCode.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            };
            
            codeView.QRCodeType = cell.thisTitle.text;
            codeView.merchant_trainer = merchant_trainer;
            codeView.member_trainer = member_trainer;
            codeView.code = QRCodeStr;
            NSMutableArray * tempArr = [NSMutableArray array];
            /*
             *先显示会员拜师二维码,再显示商家拜师二维码
             */
            ![member_trainer isEqualToString:@""] ? [tempArr addObject:member_trainer]:@"";
            ![merchant_trainer isEqualToString:@""] ? [tempArr addObject:merchant_trainer]:@"";
            codeView.TrainerArr = [NSArray arrayWithArray:tempArr];
            
            [[[UIApplication sharedApplication] keyWindow] addSubview:codeView];
            codeView.SRegistrationCodeViewBack = ^{
                [WeakSelfCodeView removeFromSuperview];
            };
        } else if (indexPath.row == 4) {
#pragma mark - 分享好友
            [mess_count removeFromSuperview];
            if (isNOo==NO) {
                SShareContact1   *  share = [[SShareContact1 alloc] init];
                share.hidesBottomBarWhenPushed = YES;
                share.personArr=userArr;
                
                [self.navigationController pushViewController:share animated:YES];
            }
            else
            {
             SShare * share = [[SShare alloc] init];
            share.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:share animated:YES];
            }
            
        } else if (indexPath.row == 5) {
#pragma mark - 分享成绩
            
            [mess_count removeFromSuperview];
            SWorkAchievement * work = [[SWorkAchievement alloc] init];
            work.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:work animated:YES];
        } else if (indexPath.row == 6) {
#pragma mark - 赠送代金券
            [mess_count removeFromSuperview];
            
            BOOL isShowBlueTicket = FALSE;
            if (complete_status != nil) {
                //使用新规则
                if ([complete_status isEqualToString:@"1"]) {
                    isShowBlueTicket = TRUE;
                }
            } else {
                //使用老规则
                if ([user_card_type isEqualToString:@"3"]) {
                    isShowBlueTicket = TRUE;
                }
            }
            if (isShowBlueTicket) {
                SBalance * balance = [[SBalance alloc] init];
                balance.hidesBottomBarWhenPushed = YES;
                balance.user_card_type = user_card_type;
                balance.viewType = @"2";
                balance.blueCouponBalance = blueCouponBalance;
                balance.blueTickArr=shopTicketArr;
                [self.navigationController pushViewController:balance animated:YES];
            } else {
                CreateSeniorMemberViewController *seniorMemeberVC = [[CreateSeniorMemberViewController alloc] init];
                seniorMemeberVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:seniorMemeberVC animated:YES];
            }
        } else if (indexPath.row == 7) {
#pragma mark - 商家推荐
            
            [mess_count removeFromSuperview];
            SComCenter * comCen = [[SComCenter alloc] init];
            comCen.type = @"1";
            comCen.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:comCen animated:YES];
        } else if (indexPath.row == 8) {
#pragma mark - 代理加盟
            
            [mess_count removeFromSuperview];
            SComCenter * comCen = [[SComCenter alloc] init];
            comCen.type = @"2";
            comCen.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:comCen animated:YES];
        } else if (indexPath.row == 9) {
#pragma mark - 联盟商家管理中心
            
            [mess_count removeFromSuperview];
            SExpandingBusiness * eb = [[SExpandingBusiness alloc] init];
            eb.isno = @"3";
            eb.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:eb animated:YES];
        } else if (indexPath.row == 10) {
#pragma mark - 三方收款账户绑定
            
            [mess_count removeFromSuperview];
            if (isshow==NO) {
                [self showTheChooseViewWithshopArr:shopAccountArr andStaste:@"1"];

            }
       
        } else if (indexPath.row == 11) {
#pragma mark - 商家码
            if (isshow==NO) {
                 [self showTheChooseViewWithshopArr:shopArr andStaste:@"2"];
            }
           
            
        
        }
        
        else if (indexPath.row == 12) {
#pragma mark - 寄售管理
            CleanMutualGoods   * help = [[CleanMutualGoods alloc] init];
            help.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:help animated:YES];
        }
    }
    if (indexPath.section == 2) {
       
        
        if (indexPath.row == 0) {
#pragma mark - 帮助中心
            
            [mess_count removeFromSuperview];
            SHelp * help = [[SHelp alloc] init];
            help.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:help animated:YES];
        } else if (indexPath.row == 1) {
#pragma mark - 意见反馈
            
            [mess_count removeFromSuperview];
            SFeed * feed = [[SFeed alloc] init];
            feed.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:feed animated:YES];
        } else if (indexPath.row == 2) {
#pragma mark - 评分鼓励
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1342931428"]];
            
        } else if (indexPath.row == 3) {
#pragma mark - 关于我们
            
            [mess_count removeFromSuperview];
            SAboutUs * about = [[SAboutUs alloc] init];
            about.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:about animated:YES];
        } else if (indexPath.row == 4) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",server_line]]];
            if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
                SLand * land = [[SLand alloc] init];
                UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                land.modalPresent = YES;
                [self presentViewController:landNav animated:YES completion:nil];
//                land.SLand_showModel = ^{
//                    [self showModel];
//                };
                return;
            }
            if ([merchant_easemob isEqualToString:@""]) {
                [MBProgressHUD showError:@"对方不在线" toView:self.view];
                return;
            }
            SUserUserCenter * center = [[SUserUserCenter alloc] init];
            [center sUserUserCenterSuccess:^(NSString *code, NSString *message, id data) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    SUserUserCenter * center = (SUserUserCenter *)data;
                    [mess_count removeFromSuperview];
                    
                    //环信ID:@"8001"
                    //聊天类型:EMConversationTypeChat
                    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:merchant_easemob conversationType:EMConversationTypeChat];
                    chatController.title = merchant_name;
                    chatController.nickname_mine = center.data.nickname;
                    chatController.pic_mine = center.data.head_pic;
                    chatController.nickname_other = merchant_name;
                    chatController.pic_other = merchant_logo;
                    chatController.hidesBottomBarWhenPushed = YES;
                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
                    [self.navigationController pushViewController:chatController animated:YES];
                    
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
    }    
}

- (void)showTheChooseViewWithshopArr:(NSArray *)arr andStaste:(NSString *)state
{
    [self showThebgview];
    isshow=YES;
    choseview =[[ShopCodeList alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 250)];
    choseview.dDelegate=self;
    choseview.shopArr=arr;
    choseview.state=state;
    [choseview reloadTable];
    [self.view.window addSubview:choseview];
    
}
-(void)shopCode:(NSString *)qrCodeType andStage_merchant_id:(NSString *)stage_merchant_id
    {
        
    //    if ([Url_header isEqualToString:@"test2"]) {
            NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OsManager/index", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
            NSString *urlStr =[NSString stringWithFormat:@"%@/sta_mid/%@.html",detail_Base_url,stage_merchant_id];
            SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
            conter.urlStr=urlStr;
            conter.fag=@"8";
            conter.activity_status=activity_status;
            conter.hidesBottomBarWhenPushed=YES;
              [self.navigationController pushViewController:conter animated:YES];
            
 
//        }
//        else
//        {
//        SRegistrationCodeView * codeView = [[SRegistrationCodeView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//
//        //给二维码添加点击手势
//        UITapGestureRecognizer *codeViewImageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QRImageTapGesture:)];
//        codeView.thisImage.userInteractionEnabled = YES;
//        [codeView.thisImage addGestureRecognizer:codeViewImageTapGesture];
//
//        //生成二维码字符串的回调
//        __weak typeof(codeView) WeakSelfCodeView = codeView;
//        codeView.passQRCodeStrBlock = ^(NSString *QRCodeStr) {
//            UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:QRCodeStr] withSize:250.0f];
//            UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:0.0f andGreen:0.0f andBlue:0.0f];
//            WeakSelfCodeView.thisImage.image = customQrcode;
//            //                [codeView.header_pic sd_setImageWithURL:[NSURL URLWithString:signCode.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
//        };
//
//       // codeView.QRCodeType = qrCodeType;
//        codeView.QRCodeType = @"商家码";
//        codeView.stage_merchant_id = stage_merchant_id;
//
//        NSMutableArray * tempArr = [NSMutableArray arrayWithObject:@"商家码"];
//
//        codeView.TrainerArr = [NSArray arrayWithArray:tempArr];
//
//        [[[UIApplication sharedApplication] keyWindow] addSubview:codeView];
//        codeView.SRegistrationCodeViewBack = ^{
//            [WeakSelfCodeView removeFromSuperview];
//        };
//        }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor redColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        //        home_search.thisSearchView.backgroundColor = [UIColor whiteColor];
        if (offsetY >= 64) {
            lefthBtn.hidden = NO;
        }

    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        lefthBtn.hidden = YES;

        //        home_search.thisSearchView.backgroundColor = [UIColor colorWithRed:239/255.0 green:244/255.0 blue:244/255.0 alpha:0.5];
    }
    
    //获取tableView当前的y偏移
    CGFloat contentOffsety  = scrollView.contentOffset.y;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
        _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=200-64){
        _mTable.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
    }
}


- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent),size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (CIImage *)createQRForString:(NSString *)qrString {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}
#pragma mark - imageToTransparent
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

/*
 *抽取获取未读消息数的网络请求方法,实现在下拉刷新时,获取到更多的未读消息
 */
-(void)GetMesscountTipMessage{
    [mess_count removeFromSuperview];
    //获取当前未读消息数
    SIndexIndex * list = [[SIndexIndex alloc] init];
    list.lng = @"";
    list.lat = @"";
    [list sIndexIndexSuccess:^(NSString *code, NSString *message, id data) {
        [[EMClient sharedClient].chatManager getConversation:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account type:EMConversationTypeChat createIfNotExist:YES];
        [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSInteger totalUnreadCount = 0;
        for (EMConversation *conversation in conversations) {
            totalUnreadCount += conversation.unreadMessagesCount;
        }
        [mess_count removeFromSuperview];
        
        SIndexIndex * list = (SIndexIndex *)data;
        
        /*
         *根据"_isAddMess_count"的状态,来判断是否允许keyWindow添加mess_count
         */
        if (_isAddMess_count) {
            if ([list.data.msg_tip integerValue] != 0 || totalUnreadCount != 0) {
                if (ScreenW > 375) {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 25 - 58, STATUS_BAR_HEIGHT, 15, 15)];
                } else {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 25 - 48, STATUS_BAR_HEIGHT, 15, 15)];
                }
                
                mess_count.text = [NSString stringWithFormat:@"%ld",[list.data.msg_tip integerValue] + totalUnreadCount];
                mess_count.font = [UIFont systemFontOfSize:10];
                mess_count.textColor = [UIColor whiteColor];
                mess_count.backgroundColor = [UIColor orangeColor];
                mess_count.textAlignment = NSTextAlignmentCenter;
                mess_count.layer.masksToBounds = YES;
                mess_count.layer.cornerRadius = 7.5;
                [[[UIApplication sharedApplication] keyWindow] addSubview:mess_count];
            }
        }
    } andFailure:^(NSError *error) {
    }];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    [MBProgressHUD showSuccess:@"已成功保存到相册!" toView:[UIApplication sharedApplication].delegate.window];
}
-(void)QRImageTapGesture:(UITapGestureRecognizer *)sender {
    UIImage *image = ((UIImageView *)sender.view).image;
    UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
    /*
    UIAlertController *alertCTL = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *downloadAC = [UIAlertAction actionWithTitle:@"保存二维码到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
    }];
    UIAlertAction *emailAC = [UIAlertAction actionWithTitle:@"发送二维码到邮箱" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![MFMailComposeViewController canSendMail]) {
            [MBProgressHUD showError:@"没有设置系统邮箱，请去设置。" toView:self.view];
            return;
        }
        self.mailSender = [[MFMailComposeViewController alloc]init];
        self.mailSender.mailComposeDelegate = self;
        [self.mailSender setToRecipients:nil];
        [self.mailSender setSubject:@"无界优品 拜师二维码"];
        NSData *imageData = UIImagePNGRepresentation(image);
        [self.mailSender addAttachmentData:imageData mimeType:@"image/jpeg" fileName:@"拜师二维码.JPG"];
        [self presentViewController:self.mailSender animated:YES completion:nil];
        
    }];
    UIAlertAction *cancelAC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertCTL addAction:downloadAC];
    [alertCTL addAction:emailAC];
    [alertCTL addAction:cancelAC];
    [self presentViewController:alertCTL animated:YES completion:nil];
    */
}
//加载背景蒙板
-(void)showThebgview{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    bgView.backgroundColor=[UIColor colorWithRed:60.0/255 green:60.0/255 blue:60.0/255 alpha:1];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheView:)];
    tapGesture.numberOfTapsRequired=1;
    [bgView addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0.8;
    }completion:^(BOOL finished){
        
    } ];
}
//撤销背景蒙板
-(void)hidThebgview{
     isshow=NO;
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}
//销毁查询菜单view
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    [choseview removeFromSuperview];
}
@end

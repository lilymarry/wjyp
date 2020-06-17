//
//  SMessage.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMessage.h"
#import "SMessageCell.h"
#import "SMessage_order.h"
//#import "SMessageInfor.h"
#import "EaseUI.h"
#import "SUserMessageNewMsg.h"
#import "CQPlaceholderView.h"
#import "SUserUserCenter.h"
#import "EaseMessageViewController.h"
#import "SlineDetailWebController.h"
@interface SMessage () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate,EMChatManagerDelegate>
{
    NSArray * topArr_content;
    NSArray * topArr_count;
    NSArray * topArr_time;
    NSMutableArray * json_arr;
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView *placeholderView;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SMessageCell"];
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}
- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages {
    NSMutableArray *arr=[NSMutableArray array];
    for (EMMessage *message in aCmdMessages) {
        // cmd消息中的扩展属性
        NSDictionary *ext = message.ext;
      //  NSLog(@"cmd消息中的扩展属性是 -- %@",ext);
        if (SWNOTEmptyDictionary(ext)) {
            NSDictionary *dic=@{@"from":message.from,@"cmd_ext":message.ext};
            
            [arr addObject:dic];
            
        }
       
    }
    NSLog(@"cmd消息中的扩展属性是 %@",arr);
    [[NSUserDefaults standardUserDefaults] setValue:arr forKey:@"cmd_extArr"];

    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)messagesDidReceive:(NSArray *)aMessages {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)viewDidAppear:(BOOL)animated {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)initRefresh
{
    __block SMessage * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
//    _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        page++;
//        [blockSelf showModel];
//    }];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)showModel {
    
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray * emId_arr = [[NSMutableArray alloc] init];
    NSMutableArray * emCount_arr = [[NSMutableArray alloc] init];
    NSMutableArray * emLastMess_ContentArr = [[NSMutableArray alloc] init];
    NSMutableArray * emLastMess_TimeArr = [[NSMutableArray alloc] init];
    for (EMConversation * emCon in conversations) {
        [emId_arr addObject:emCon.conversationId];
        [emCount_arr addObject:[NSString stringWithFormat:@"%zd",emCon.unreadMessagesCount]];
        NSString * lastContent = @"";
        EMMessageBody *messageBody = emCon.latestMessage.body;
        if (emCon.latestMessage.body.type == EMMessageBodyTypeImage) {
            lastContent = @"[图片]";
        }
        if (emCon.latestMessage.body.type == EMMessageBodyTypeText) {
            lastContent = [EaseConvertToCommonEmoticonsHelper convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
            if ([emCon.latestMessage.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
                lastContent = @"[动画表情]";
            }
        }
        if (emCon.latestMessage.body.type == EMMessageBodyTypeVoice) {
            lastContent = @"[语音]";
        }
        if (emCon.latestMessage.body.type == EMMessageBodyTypeLocation) {
            lastContent = @"[定位]";
        }
        if (emCon.latestMessage.body.type == EMMessageBodyTypeVideo) {
            lastContent = @"[视频]";
        }
        if (emCon.latestMessage.body.type == EMMessageBodyTypeFile) {
            lastContent = @"[文件]";
        }
        [emLastMess_ContentArr addObject:lastContent];
        
        [emLastMess_TimeArr addObject:[NSString stringWithFormat:@"%zd",emCon.latestMessage.timestamp]];
    }
    
    json_arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < emId_arr.count; i++) {
        if (![emId_arr[i] isEqualToString:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account]) {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:emId_arr[i] forKey:@"easemob_account"];
            [dic setObject:emCount_arr[i] forKey:@"msg_count"];
            [dic setObject:emLastMess_ContentArr[i] forKey:@"last_content"];
            [dic setObject:emLastMess_TimeArr[i] forKey:@"last_time"];
            [json_arr addObject:dic];
        }
    }
    
    SUserMessageNewMsg * list = [[SUserMessageNewMsg alloc] init];
    list.account_json = [json_arr mj_JSONString];
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sUserMessageNewMsgSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SUserMessageNewMsg * list = (SUserMessageNewMsg *)data;
  //      if ([Url_header isEqualToString:@"test2"]) {
            topArr_content = @[list.data.order_title,list.data.msg_title,list.data.stage_title,list.data.announce_title];
            topArr_count = @[list.data.order_count,list.data.msg_count,list.data.stage_count,list.data.announce_count];
            topArr_time = @[list.data.order_time,list.data.msg_time,list.data.stage_time,list.data.announce_time];
//        }
//        else
//        {
//        topArr_content = @[list.data.order_title,list.data.msg_title,list.data.announce_title];
//        topArr_count = @[list.data.order_count,list.data.msg_count,list.data.announce_count];
//        topArr_time = @[list.data.order_time,list.data.msg_time,list.data.announce_time];
//        }
        
        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:list.data.chat_list];
            [_mTable.mj_footer resetNoMoreData];
        } else {
            if (list.data.chat_list.count) {
                
                [arr addObjectsFromArray:list.data.chat_list];
                [_mTable.mj_footer endRefreshing];
                
            } else {
                
                [_mTable.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [_mTable.mj_header endRefreshing];
        [_mTable reloadData];
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
    
    self.title = @"消息";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
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
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
//         if ([Url_header isEqualToString:@"test2"])
//             {
                   return 4;
//             }
//          return 3;
    }
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SMessageCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
   //     if ([Url_header isEqualToString:@"test2"])
    //    {
        cell.thisTitle.text = @[@"订单消息",@"通知消息",@"店铺消息",@"公告"][indexPath.row];
        cell.headerImage.image = [UIImage imageNamed:@[@"订单消息",@"通知消息",@"店铺消息",@"公告"][indexPath.row]];
   //     }
//        else
//        {
//            cell.thisTitle.text = @[@"订单消息",@"通知消息",@"公告"][indexPath.row];
//            cell.headerImage.image = [UIImage imageNamed:@[@"订单消息",@"通知消息",@"公告"][indexPath.row]];
//        }
        cell.headerNum.text = topArr_count[indexPath.row];
        if ([topArr_count[indexPath.row] integerValue] == 0 || [topArr_count[indexPath.row] isEqualToString:@""]) {
            cell.headerNum.hidden = YES;
        } else {
            cell.headerNum.hidden = NO;
        }
        cell.thisContent.text = topArr_content[indexPath.row];
        cell.thisTime.text = topArr_time[indexPath.row];
    } else {
        SUserMessageNewMsg * list = arr[indexPath.row];
        cell.thisTitle.text = list.nickname;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.headerNum.text = list.msg_count;
        if ([list.msg_count integerValue] == 0) {
            cell.headerNum.hidden = YES;
        } else {
            cell.headerNum.hidden = NO;
        }
        cell.thisContent.text = list.last_content;
        cell.thisTime.text = list.last_time;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SMessage_order * order = [[SMessage_order alloc] init];
     //    if ([Url_header isEqualToString:@"test2"])
      //  {
            if (indexPath.row==2) {
            NSString *    urlStr =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/UserMessage/stage_message/p/1.html", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
                SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
                conter.urlStr=urlStr;
                conter.fag=@"10";
 
              [self.navigationController pushViewController:conter animated:YES];
            }
            else
            {
            if (indexPath.row == 0) {
                order.type = @"1";
            }
            if (indexPath.row == 1) {
                order.type = @"2";
            }
            if (indexPath.row == 3) {
                order.type = @"3";
            }
            [self.navigationController pushViewController:order animated:YES];
            }
    //    }
        
 
      
    } else {
        SUserMessageNewMsg * list = arr[indexPath.row];

        SUserUserCenter * center = [[SUserUserCenter alloc] init];
        [center sUserUserCenterSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SUserUserCenter * center = (SUserUserCenter *)data;
                
                //环信ID:@"8001"
                //聊天类型:EMConversationTypeChat
                EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:list.easemob_account conversationType:EMConversationTypeChat];
                chatController.title = list.nickname;
                chatController.nickname_mine = center.data.nickname;
                chatController.pic_mine = center.data.head_pic;
                chatController.nickname_other = list.nickname;
                chatController.pic_other = list.head_pic;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        SUserMessageNewMsg * list = arr[indexPath.row];
        [[EMClient sharedClient].chatManager deleteConversation:list.easemob_account isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError){
            //code
            [self showModel];
        }];
    }
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end

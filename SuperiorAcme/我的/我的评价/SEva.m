//
//  SEva.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEva.h"
#import "SEvaTop.h"
#import "SEvaHeader.h"
#import "SEvaCell.h"
#import "SUserMyCommentList.h"//我的评价
#import "CQPlaceholderView.h"
#import "SMerchantCommentList.h"//商家的评价
#import "ReplyView.h"

@interface SEva () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    SEvaTop * top;
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView *placeholderView;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SEva

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SEvaCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SEvaCell"];
    
   placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];

    top = [[SEvaTop alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    _mTable.tableHeaderView = top;
    

    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)initRefresh
{
    __block SEva * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)showModel {
    if (_type == NO) {
        SUserMyCommentList * list = [[SUserMyCommentList alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserMyCommentListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已有 %@ 条评价    ",nums]];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, nums.length)];
            top.num.attributedText = AttributedStr;
            
            SUserMyCommentList * list = (SUserMyCommentList *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
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
    } else {
        SMerchantCommentList * list = [[SMerchantCommentList alloc] init];
        list.merchant_id = _merchant_id;
        list.goods_id = _goods_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMerchantCommentListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已有 %@ 条评价    ",nums]];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, nums.length)];
            top.num.attributedText = AttributedStr;
            
            SMerchantCommentList * list = (SMerchantCommentList *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    
                    [arr addObjectsFromArray:list.data];
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
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_type == NO) {
        self.title = @"我的评价";
    } else {
        self.title = @"商品评价";
    }
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
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }

    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_type == NO) {
        SUserMyCommentList * list = arr[section];
        
        CGSize size = [list.content boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        
        NSInteger eva_num;
        if (list.pictures.count == 0) {
            eva_num = 90;
        } else {
            eva_num = 0;
        }
        
        return 206 + size.height - eva_num;
    }
    SMerchantCommentList * list = arr[section];
    
    CGSize size = [list.content boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    NSInteger eva_num;
    if (list.pictures.count == 0) {
        eva_num = 90;
    } else {
        eva_num = 0;
    }
    
    return 206 + size.height - eva_num;
}

/**
 商家评论数据处理

 @param type 0:获取内容高度 1:获取视图
 @param section 当前组
 @return 内容高度 或 视图
 */
- (id)replyDataDispose:(NSInteger)type andSection:(NSInteger)section{
    NSInteger reply_id;
    NSString *reply_content;
    NSArray  *reply_array;
    if (_type == NO) {
        SUserMyCommentList * list = arr[section];
        reply_id = [list.reply_id integerValue];
        reply_content = list.reply;
        reply_array = list.reply_pictures_list;
    } else {
        SMerchantCommentList * list = arr[section];
        reply_id = [list.reply_id integerValue];
        reply_content = list.reply;
        reply_array = list.reply_pictures_list;
    }
    CGFloat height = 0.01;
    CGSize size = CGSizeZero;
    if (reply_content != nil && ![reply_content isEqualToString:@"0"]) {
        size = [reply_content boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    }
    CGFloat textHeight = size.height;
    if (reply_array.count > 0) {
        height = (ScreenW - 45) / 4;
    }
    if (textHeight > 0 || reply_array.count > 0) {
        height += textHeight + 40;
    }
    if (type) {
        //获取视图
        return reply_id > 0 ? [self createReplyView:reply_content andReviewArray:reply_array andTextHeight:textHeight andHeight:height] : nil;
    } else {
        //获取内容高度
        return [NSNumber numberWithFloat:height];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSNumber *height = (NSNumber *)[self replyDataDispose:0 andSection:section];
    return [height floatValue];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return (UIView *)[self replyDataDispose:1 andSection:section];
}

/**
 创建商家回复评论视图
 
 @param content 评论内容
 @param reviewArray 评论图片数组
 @return 返回视图 或 nil
 */
- (UIView *)createReplyView:(NSString *)content andReviewArray:(NSArray *)reviewArray andTextHeight:(CGFloat)textHeight andHeight:(CGFloat)height {
    ReplyView *replyView = [[NSBundle mainBundle] loadNibNamed:@"ReplyView" owner:self options:nil].firstObject;
    replyView.frame = CGRectMake(0, 0, ScreenW, height);
    NSString * text = [NSString stringWithFormat:@"商家回复: %@", content];
     NSMutableAttributedString *fontAttributeNameStr = [[NSMutableAttributedString alloc]initWithString:text];
    [fontAttributeNameStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
    [fontAttributeNameStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1] range:NSMakeRange(0, 5)];
    replyView.content.attributedText = fontAttributeNameStr;
    if (reviewArray.count >0) {
        for (int i = 0; i < reviewArray.count; i++) {
            SMerchantCommentList *image = reviewArray[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i > 0 ? (15 + ((ScreenW - 45) / 4 + 5) * i) : 15 , replyView.content.frame.origin.y + textHeight + 10, (ScreenW - 45) / 4, (ScreenW - 45) / 4)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:image.review_path] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            [replyView.backView addSubview:imageView];
        }
    }
    return replyView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (_type == NO) {
        SUserMyCommentList * list = arr[section];
        
        CGSize size = [list.content boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        
        SEvaHeader * header = [[SEvaHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 206 + size.height)];
        
        header.evaContent.text = list.content;
        header.evaContent_HHH.constant = size.height;
        
        [header.headerImage sd_setImageWithURL:[NSURL URLWithString:list.user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        header.nick.text = list.nickname;
        header.goods_type.text = [NSString stringWithFormat:@"%@ 颜色分类:%@",list.create_time,list.good_attr == nil ? @"默认" : list.good_attr];
        [header showModel:list.pictures];
        if (list.pictures.count == 0) {
            header.mCollect.hidden = YES;
        } else {
            header.mCollect.hidden = NO;
        }
        
        return header;
    }
    
    SMerchantCommentList * list = arr[section];
    
    CGSize size = [list.content boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;

    SEvaHeader * header = [[SEvaHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 206 + size.height)];
    
    header.evaContent.text = list.content;
    header.evaContent_HHH.constant = size.height;

    [header.headerImage sd_setImageWithURL:[NSURL URLWithString:list.user_head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    header.nick.text = list.nickname;
    header.goods_type.text = [NSString stringWithFormat:@"%@ 颜色分类:%@",list.create_time,list.good_attr == nil ? @"默认" : list.good_attr];
    [header showModel:list.pictures];
    if (list.pictures.count == 0) {
        header.mCollect.hidden = YES;
    } else {
        header.mCollect.hidden = NO;
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (_type == YES) {
            return 100;
        }
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEvaCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SEvaCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_type == NO) {
        SUserMyCommentList * list = arr[indexPath.section];
        
//        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@",list.goods_name]];
//
//        //图文混排
//        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//        textAttachment.image = [UIImage imageNamed:@"拼团R"];
//
//        textAttachment.bounds = CGRectMake(0, -8, 25, 25);
//        // 用textAttachment生成属性字符串
//        NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
//        // 属性字符串插入到目标字符串
//        [AttributedStr insertAttributedString:attachmentAttrStr atIndex:0];
//        cell.thisTitle.attributedText = AttributedStr;
        cell.thisTitle.text = list.goods_name;
        
        [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisPrice.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list.goods_num];
    } else {
        SMerchantCommentList * list = arr[indexPath.section];
        
//        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@",list.goods_name]];
//
//        //图文混排
//        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//        textAttachment.image = [UIImage imageNamed:@"拼团R"];
//
//        textAttachment.bounds = CGRectMake(0, -8, 25, 25);
//        // 用textAttachment生成属性字符串
//        NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
//        // 属性字符串插入到目标字符串
//        [AttributedStr insertAttributedString:attachmentAttrStr atIndex:0];
//        cell.thisTitle.attributedText = AttributedStr;
        cell.thisTitle.text = list.goods_name;
        
        [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisPrice.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        cell.thisNum.text = [NSString stringWithFormat:@"x%@",list.goods_num];
        
//        cell.thisTitle.hidden = YES;
//        cell.thisImage.hidden = YES;
//        cell.thisPrice.hidden = YES;
//        cell.thisNum.hidden = YES;
    }
    
    return cell;
}

@end

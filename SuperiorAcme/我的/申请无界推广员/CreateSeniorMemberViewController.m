//
//  CreateSeniorMemberViewController.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "CreateSeniorMemberViewController.h"
#import "HttpManager.h"
#import "SUserUserCard.h"
#import "SCarefreeMember.h"

@interface CreateSeniorMemberViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation CreateSeniorMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请无界推广员";
    [HttpManager postWithUrl:SUserCreateSeniorMember_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [_image sd_setImageWithURL:[NSURL URLWithString:dic[@"data"][@"ads"][0][@"picture"]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    } andFail:^(NSError *error) {
        
    }];
}
- (IBAction)gotoBuyMember:(id)sender {
    SUserUserCard * user = [[SUserUserCard alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [user sUserUserCardSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SUserUserCard * list = ((SUserUserCard *)data).data.list[2];
        SCarefreeMember * member = [[SCarefreeMember alloc] init];
        member.sale_status = list.sale_status;
        member.score_status = list.score_status;
        member.rank_id = list.rank_id;
        member.member_coding = list.member_coding;
        member.rank_name = list.rank_name;
        member.bannerArr = list.abs_url;
        member.thisMoney = list.money;
        member.is_get = list.is_get;
        member.hidesBottomBarWhenPushed = YES;
//        member.grade = self;
        [self.navigationController pushViewController:member animated:YES];
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

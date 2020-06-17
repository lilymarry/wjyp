//
//  SAMineURLConstant.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SAMineURLConstant.h"

@implementation SAMineURLConstant

//文章模块
#pragma mark - APP文章
 NSString *const SArticleGetArticle_Url = @"Article/getArticle";

#pragma mark - 关于我们
 NSString *const SArticleAboutUs_Url = @"Article/aboutUs";

#pragma mark - 意见反馈问题类型
 NSString *const SArticleFeedbackType_Url = @"Article/feedbackType";

#pragma mark - 意见反馈
 NSString *const SArticleFeedback_Url = @"Article/feedback";

#pragma mark - 帮助中心
 NSString *const SArticleHelpCenter_Url = @"Article/helpCenter";

//无界书院
#pragma mark - 无界书院首页
 NSString *const SAcademyAcademyIndex_Url = @"Academy/academyIndex";

#pragma mark - 文章详情
 NSString *const SAcademyAcademyInfo_Url = @"Academy/academyInfo";

//收货地址
#pragma mark - 收货地址列表
 NSString *const SAddressAddressList_Url = @"Address/addressList";

#pragma mark - 设置默认收货地址
 NSString *const SAddressSetDefault_Url = @"Address/setDefault";

#pragma mark - 获取一条收货地址
 NSString *const SAddressGetOneAddress_Url = @"Address/getOneAddress";

#pragma mark - 添加收货地址
 NSString *const SAddressAddAddress_Url = @"Address/addAddress";

#pragma mark - 编辑收货地址
 NSString *const SAddressEditAddress_Url = @"Address/editAddress";

#pragma mark - 删除收货地址
 NSString *const SAddressDelAddress_Url = @"Address/delAddress";

#pragma mark - 获取区域列表
 NSString *const SAddressGetRegion_Url = @"Address/getRegion";

#pragma mark - 获取街道列表
 NSString *const SAddressGetStreet_Url = @"Address/getStreet";


#pragma mark -******************   会员模块   **********************

#pragma mark - 获取个人资料
 NSString *const SUserUserInfo_Url = @"User/userInfo";

#pragma mark - 修改个人资料
 NSString *const SUserEditInfo_Url =  @"User/editInfo";

#pragma mark - 实名认证
 NSString *const SUserAddAuth_Url = @"User/addAuth";

#pragma mark - 修改登录密码
 NSString *const SUserChangePassword_Url = @"User/changePassword";

#pragma mark - 个人设置
 NSString *const SUserSetting_Url = @"User/setting";

#pragma mark - 获取实名认证信息
 NSString *const SUserGetAuth_Url = @"User/getAuth";

#pragma mark - 修改支付密码
 NSString *const SUserRePayPwd_Url = @"User/rePayPwd";

#pragma mark - 更换绑定手机
 NSString *const SUserChangePhone_Url = @"User/changePhone";

#pragma mark - 我的评价
 NSString *const SUserMyCommentList_Url = @"User/myCommentList";

#pragma mark - 我的足迹
 NSString *const SUserMyfooter_Url = @"User/myfooter";

#pragma mark - 我的购物券
 NSString *const SUserVouchersList_Url = @"User/vouchersList";

#pragma mark - 购物券明细
 NSString *const SUserVouchersLog_Url = @"User/vouchersLog";

#pragma mark - 我的积分
 NSString *const SUserMyIntegral_Url = @"User/myIntegral";

#pragma mark - 设置登录密码
 NSString *const SUserSetPassword_Url = @"User/setPassword";

#pragma mark - 设置支付密码
 NSString *const SUserSetPayPwd_Url = @"User/setPayPwd";

#pragma mark - 个人中心
 NSString *const SUserUserCenter_Url = @"User/userCenter";

#pragma mark - 卡券包-优惠券
 NSString *const SUserMyTicket_Url = @"User/myTicket";

#pragma mark - 获取经营范围
 NSString *const SUserGetRange_Url = @"User/getRange";

#pragma mark - 会员推荐商户
 NSString *const SUserMerchantRefer_Url = @"User/merchantRefer";

#pragma mark - 获取推荐商家列表
 NSString *const SUserReferList_Url = @"User/referList";

#pragma mark - 会员成长
 NSString *const SUserUserDevelop_Url = @"User/userDevelop";

#pragma mark - 成长值明细
 NSString *const SUserUserDevelopLog_Url = @"User/userDevelopLog";

#pragma mark - 增加成长值
 NSString *const SUserAddPoint_Url = @"User/addPoint";

#pragma mark - 会员等级
 NSString *const SUserUserRank_Url = @"User/userRank";

#pragma mark - 注册码
 NSString *const SUserGetSignCode_Url = @"User/getSignCode";

#pragma mark - 工作成绩
 NSString *const SUserGradeRank_Url = @"User/gradeRank";

#pragma mark - 我的分享
 NSString *const SUserMyShare_Url = @"User/myShare";

#pragma mark - 我的推荐
 NSString *const SUserMyRecommend_Url = @"User/myRecommend";

#pragma mark - 我的推荐(新)
 NSString *const SUserMyRecommendNew_Url = @"User/myRecommendNew";

#pragma mark - 分享回调
 NSString *const SUserShareBack_Url = @"User/shareBack";

#pragma mark - 忘记支付密码
 NSString *const SUserResetPayPwd_Url = @"User/resetPayPwd";

#pragma mark - 积分明细
 NSString *const SUserIntegralLog_Url = @"User/integralLog";

#pragma mark - 分享好友
 NSString *const SUserShareFriend_Url = @"User/shareFriend";

#pragma mark - 删除足迹
 NSString *const SUserDelFooter_Url = @"User/delFooter";

#pragma mark - 推荐商家详情
 NSString *const SUserReferInfo_Url = @"User/referInfo";

#pragma mark - 绑定第三方
 NSString *const SUserBindOther_Url = @"User/bindOther";
#pragma mark -获取支付宝openid
 NSString *const SUserBindOtherAlipay_Url = @"User/alipay_info";

#pragma mark - 解除绑定
 NSString *const SUserRemoveBind_Url = @"User/removeBind";

#pragma mark - 个人认证
 NSString *const SUserPersonalAuth_Url = @"User/personalAuth";

#pragma mark - 个人认证详情
 NSString *const SUserPersonalAuthInfo_Url = @"User/personalAuthInfo";

#pragma mark - 企业认证
 NSString *const SUserCompAuth_Url = @"User/compAuth";

#pragma mark - 会员卡列表
 NSString *const SUserUserCard_Url = @"User/userCard";

#pragma mark - 验证支付密码
 NSString *const SUserVerificationPayPwd_Url = @"User/verificationPayPwd";

#pragma mark - 积分兑换
 NSString *const SUserChangeIntegral_Url = @"User/changeIntegral";

#pragma mark - 积分自动兑换
 NSString *const SUserChangeIntegralStatus_Url = @"User/changeIntegralStatus";

#pragma mark - 获取兑换详情信息
 NSString *const SUserAutoChange_Url = @"User/autoChange";

#pragma mark - 申请无界推广员
 NSString *const SUserCreateSeniorMember_Url = @"User/promoters";

#pragma mark - ****************   会员收藏   ******************

#pragma mark - 用户收藏
 NSString *const SUserCollectCollectList_Url = @"UserCollect/collectList";

#pragma mark - 加入我的收藏
 NSString *const SUserCollectAddCollect_Url = @"UserCollect/addCollect";

#pragma mark - 删除收藏品
 NSString *const SUserCollectDelCollect_Url = @"UserCollect/delCollect";

#pragma mark - 取消收藏
 NSString *const SUserCollectDelOneCollect_Url = @"UserCollect/delOneCollect";


#pragma mark - ****************   会员余额   ******************

#pragma mark - 余额首页
 NSString *const SUserBalanceBalanceIndex_Url = @"UserBalance/balanceIndex";

#pragma mark - 线上充值
 NSString *const SUserBalanceUpMoney_Url = @"UserBalance/upMoney";

#pragma mark - 线下充值
 NSString *const SUserBalanceUnderMoney_Url = @"UserBalance/underMoney";

#pragma mark - 银行卡类型获取
 NSString *const SUserBalanceGetBankType_Url = @"UserBalance/getBankType";

#pragma mark - 添加银行卡
 NSString *const SUserBalanceAddBank_Url = @"UserBalance/addBank";

#pragma mark - 获取银行卡列表
 NSString *const SUserBalanceBankList_Url = @"UserBalance/bankList";

#pragma mark - 删除银行卡
 NSString *const SUserBalanceDelBank_Url = @"UserBalance/delBank";

#pragma mark - 提现首页
 NSString *const SUserBalanceCashIndex_Url = @"UserBalance/cashIndex";

#pragma mark - 提现操作
 NSString *const SUserBalanceGetCash_Url = @"UserBalance/getCash";

#pragma mark - 转账
 NSString *const SUserBalanceChangeMoney_Url = @"UserBalance/changeMoney";

#pragma mark - 赠送蓝色代金券
 NSString *const SUserBalanceChangeBlueCoupon_Url = @"User/gifVoucher";

#pragma mark - 赠送蓝色代金券赠送
 NSString *const SUserBalanceBlueCouponLog_Url = @"User/gifVoucherList";

#pragma mark - 赠送蓝色代金券某条明细
 NSString *const SUserBalanceBlueCouponLogDetail_Url = @"User/gifVoucherListDetail";

#pragma mark - 余额明细
 NSString *const SUserBalanceBalanceLog_Url = @"UserBalance/balanceLog";

#pragma mark - 根据ID或者手机获取真实姓名
 NSString *const SUserBalanceGetUserName_Url = @"UserBalance/getUserName";

#pragma mark - 线下充值详情
 NSString *const SUserBalanceGetUnderInfo_Url = @"UserBalance/getUnderInfo";

#pragma mark - 线下充值列表
 NSString *const SUserBalanceUnderMoneys_Url = @"UserBalance/underMoneys";

#pragma mark - 平台银行卡列表
 NSString *const SUserBalancePlatformAccount_Url = @"UserBalance/platformAccount";

#pragma mark - 编辑银行卡
 NSString *const SUserBalanceEditBank_Url = @"UserBalance/editBank";

#pragma mark - 充值订单列表
 NSString *const SUserBalanceUserBalanceHjs_Url = @"UserBalance/userBalanceHjs";

#pragma mark - 充值订单详情
 NSString *const SUserBalanceHjsInfo_Url = @"UserBalance/hjsInfo";

#pragma mark - 删除订单
 NSString *const SUserBalanceDelHjsInfo_Url = @"UserBalance/delHjsInfo";

#pragma mark - 搜索银行卡
 NSString *const SUserBalanceSearchBank_Url =  @"UserBalance/searchBank";

#pragma mark - ****************   会员消息中心   ******************

#pragma mark - 消息中心页
 NSString *const SUserMessageNewMsg_Url = @"UserMessage/newMsg";

#pragma mark - 通知消息列表
 NSString *const SUserMessageMsgList_Url = @"UserMessage/msgList";

#pragma mark - 订单消息列表
 NSString *const SUserMessageOrderMsgList_Url = @"UserMessage/orderMsgList";

#pragma mark - 公告消息列表
 NSString *const SUserMessageAnnounceList_Url = @"UserMessage/announceList";

#pragma mark - 获取公告内容
 NSString *const SUserMessageAnnounceInfo_Url = @"UserMessage/announceInfo";

#pragma mark - ****************   环信   ******************
#pragma mark - 客服环信账号
 NSString *const SEasemobBind_Url = @"Easemob/bind";

#pragma mark - ****************   联盟商家推荐   ******************
#pragma mark - 联盟/无界驿站推荐
 NSString *const SRecommendingAddBusiness_Url = @"Recommending/addBusiness";

#pragma mark - 联盟商家类型
 NSString *const SRecommendingBusinessType_Url = @"Recommending/businessType";

#pragma mark - 联盟商家列表
 NSString *const SRecommendingBusinessList_Url = @"Recommending/businessList";

#pragma mark - 联盟商家列表详情
 NSString *const SRecommendingBusinessInfo_Url = @"Recommending/businessInfo";

#pragma mark - 商家推荐广告
 NSString *const SRecommendingAdvertImg_Url = @"Recommending/advertImg";

#pragma mark - 获取用户通讯录
NSString *const SUserAddressUrl = @"User/user_contacts";



@end

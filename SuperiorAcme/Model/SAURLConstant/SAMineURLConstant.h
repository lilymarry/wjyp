//
//  SAMineURLConstant.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAMineURLConstant : NSObject

//文章模块
#pragma mark - APP文章
extern NSString *const SArticleGetArticle_Url;

#pragma mark - 关于我们
extern NSString *const SArticleAboutUs_Url;

#pragma mark - 意见反馈问题类型
extern NSString *const SArticleFeedbackType_Url;

#pragma mark - 意见反馈
extern NSString *const SArticleFeedback_Url;

#pragma mark - 帮助中心
extern NSString *const SArticleHelpCenter_Url;

//无界书院
#pragma mark - 无界书院首页
extern NSString *const SAcademyAcademyIndex_Url;

#pragma mark - 文章详情
extern NSString *const SAcademyAcademyInfo_Url;

//收货地址
#pragma mark - 收货地址列表
extern NSString *const SAddressAddressList_Url;

#pragma mark - 设置默认收货地址
extern NSString *const SAddressSetDefault_Url;

#pragma mark - 获取一条收货地址
extern NSString *const SAddressGetOneAddress_Url;

#pragma mark - 添加收货地址
extern NSString *const SAddressAddAddress_Url;

#pragma mark - 编辑收货地址
extern NSString *const SAddressEditAddress_Url;

#pragma mark - 删除收货地址
extern NSString *const SAddressDelAddress_Url;

#pragma mark - 获取区域列表
extern NSString *const SAddressGetRegion_Url;

#pragma mark - 获取街道列表
extern NSString *const SAddressGetStreet_Url;

#pragma mark -******************   会员模块   **********************

#pragma mark - 获取个人资料
extern NSString *const SUserUserInfo_Url;

#pragma mark - 修改个人资料
extern NSString *const SUserEditInfo_Url;

#pragma mark - 实名认证
extern NSString *const SUserAddAuth_Url;

#pragma mark - 修改登录密码
extern NSString *const SUserChangePassword_Url;

#pragma mark - 个人设置
extern NSString *const SUserSetting_Url;

#pragma mark - 获取实名认证信息
extern NSString *const SUserGetAuth_Url;

#pragma mark - 修改支付密码
extern NSString *const SUserRePayPwd_Url;

#pragma mark - 更换绑定手机
extern NSString *const SUserChangePhone_Url;

#pragma mark - 我的评价
extern NSString *const SUserMyCommentList_Url;

#pragma mark - 我的足迹
extern NSString *const SUserMyfooter_Url;

#pragma mark - 我的购物券
extern NSString *const SUserVouchersList_Url;

#pragma mark - 购物券明细
extern NSString *const SUserVouchersLog_Url;

#pragma mark - 我的积分
extern NSString *const SUserMyIntegral_Url;

#pragma mark - 设置登录密码
extern NSString *const SUserSetPassword_Url;

#pragma mark - 设置支付密码
extern NSString *const SUserSetPayPwd_Url;

#pragma mark - 个人中心
extern NSString *const SUserUserCenter_Url;

#pragma mark - 卡券包-优惠券
extern NSString *const SUserMyTicket_Url;

#pragma mark - 获取经营范围
extern NSString *const SUserGetRange_Url;

#pragma mark - 会员推荐商户
extern NSString *const SUserMerchantRefer_Url;

#pragma mark - 获取推荐商家列表
extern NSString *const SUserReferList_Url;

#pragma mark - 会员成长
extern NSString *const SUserUserDevelop_Url;

#pragma mark - 成长值明细
extern NSString *const SUserUserDevelopLog_Url;

#pragma mark - 增加成长值
extern NSString *const SUserAddPoint_Url;

#pragma mark - 会员等级
extern NSString *const SUserUserRank_Url;

#pragma mark - 注册码
extern NSString *const SUserGetSignCode_Url;

#pragma mark - 工作成绩
extern NSString *const SUserGradeRank_Url;

#pragma mark - 我的分享
extern NSString *const SUserMyShare_Url;

#pragma mark - 我的推荐
extern NSString *const SUserMyRecommend_Url;

#pragma mark - 我的推荐(新)
extern NSString *const SUserMyRecommendNew_Url;

#pragma mark - 分享回调
extern NSString *const SUserShareBack_Url;

#pragma mark - 忘记支付密码
extern NSString *const SUserResetPayPwd_Url;

#pragma mark - 积分明细
extern NSString *const SUserIntegralLog_Url;

#pragma mark - 分享好友
extern NSString *const SUserShareFriend_Url;

#pragma mark - 删除足迹
extern NSString *const SUserDelFooter_Url;

#pragma mark - 推荐商家详情
extern NSString *const SUserReferInfo_Url;

#pragma mark - 绑定第三方
extern NSString *const SUserBindOther_Url;
extern NSString *const SUserBindOtherAlipay_Url;

#pragma mark - 解除绑定
extern NSString *const SUserRemoveBind_Url;

#pragma mark - 个人认证
extern NSString *const SUserPersonalAuth_Url;

#pragma mark - 个人认证详情
extern NSString *const SUserPersonalAuthInfo_Url;

#pragma mark - 企业认证
extern NSString *const SUserCompAuth_Url;

#pragma mark - 会员卡列表
extern NSString *const SUserUserCard_Url;

#pragma mark - 验证支付密码
extern NSString *const SUserVerificationPayPwd_Url;

#pragma mark - 积分兑换
extern NSString *const SUserChangeIntegral_Url;

#pragma mark - 积分自动兑换
extern NSString *const SUserChangeIntegralStatus_Url;

#pragma mark - 获取兑换详情信息
extern NSString *const SUserAutoChange_Url;

#pragma mark - 申请无界推广员
extern NSString *const SUserCreateSeniorMember_Url;

#pragma mark - ****************   会员收藏   ******************

#pragma mark - 用户收藏
extern NSString *const SUserCollectCollectList_Url;

#pragma mark - 加入我的收藏
extern NSString *const SUserCollectAddCollect_Url;

#pragma mark - 删除收藏品
extern NSString *const SUserCollectDelCollect_Url;

#pragma mark - 取消收藏
extern NSString *const SUserCollectDelOneCollect_Url;

#pragma mark - ****************   会员余额   ******************

#pragma mark - 余额首页
extern NSString *const SUserBalanceBalanceIndex_Url;

#pragma mark - 线上充值
extern NSString *const SUserBalanceUpMoney_Url;

#pragma mark - 线下充值
extern NSString *const SUserBalanceUnderMoney_Url;

#pragma mark - 银行卡类型获取
extern NSString *const SUserBalanceGetBankType_Url;

#pragma mark - 添加银行卡
extern NSString *const SUserBalanceAddBank_Url;

#pragma mark - 获取银行卡列表
extern NSString *const SUserBalanceBankList_Url;

#pragma mark - 删除银行卡
extern NSString *const SUserBalanceDelBank_Url;

#pragma mark - 提现首页
extern NSString *const SUserBalanceCashIndex_Url;

#pragma mark - 提现操作
extern NSString *const SUserBalanceGetCash_Url;

#pragma mark - 转账
extern NSString *const SUserBalanceChangeMoney_Url;

#pragma mark - 赠送蓝色代金券
extern NSString *const SUserBalanceChangeBlueCoupon_Url;

#pragma mark - 赠送蓝色代金券赠送
extern NSString *const SUserBalanceBlueCouponLog_Url;

#pragma mark - 赠送蓝色代金券某条明细
extern NSString *const SUserBalanceBlueCouponLogDetail_Url;

#pragma mark - 余额明细
extern NSString *const SUserBalanceBalanceLog_Url;

#pragma mark - 根据ID或者手机获取真实姓名
extern NSString *const SUserBalanceGetUserName_Url;

#pragma mark - 线下充值详情
extern NSString *const SUserBalanceGetUnderInfo_Url;

#pragma mark - 线下充值列表
extern NSString *const SUserBalanceUnderMoneys_Url;

#pragma mark - 平台银行卡列表
extern NSString *const SUserBalancePlatformAccount_Url;

#pragma mark - 编辑银行卡
extern NSString *const SUserBalanceEditBank_Url;

#pragma mark - 充值订单列表
extern NSString *const SUserBalanceUserBalanceHjs_Url;

#pragma mark - 充值订单详情
extern NSString *const SUserBalanceHjsInfo_Url;

#pragma mark - 删除订单
extern NSString *const SUserBalanceDelHjsInfo_Url;

#pragma mark - 搜索银行卡
extern NSString *const SUserBalanceSearchBank_Url;

#pragma mark - ****************   会员消息中心   ******************

#pragma mark - 消息中心页
extern NSString *const SUserMessageNewMsg_Url;

#pragma mark - 通知消息列表
extern NSString *const SUserMessageMsgList_Url;

#pragma mark - 订单消息列表
extern NSString *const SUserMessageOrderMsgList_Url;

#pragma mark - 公告消息列表
extern NSString *const SUserMessageAnnounceList_Url;

#pragma mark - 获取公告内容
extern NSString *const SUserMessageAnnounceInfo_Url;

#pragma mark - ****************   环信   ******************
#pragma mark - 客服环信账号
extern NSString *const SEasemobBind_Url;

#pragma mark - ****************   联盟商家推荐   ******************
#pragma mark - 联盟/无界驿站推荐
extern NSString *const SRecommendingAddBusiness_Url;

#pragma mark - 联盟商家类型
extern NSString *const SRecommendingBusinessType_Url;

#pragma mark - 联盟商家列表
extern NSString *const SRecommendingBusinessList_Url;

#pragma mark - 联盟商家列表详情
extern NSString *const SRecommendingBusinessInfo_Url;

#pragma mark - 商家推荐广告
extern NSString *const SRecommendingAdvertImg_Url;

#pragma mark - 获取用户通讯录
extern NSString *const SUserAddressUrl;

@end

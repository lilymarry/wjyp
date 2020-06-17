//
//  SHyphenateList.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SHyphenateList_choiceBlock) (NSString * header_pic, NSString * nickname, NSString * hx);

@interface SHyphenateList : UIViewController
@property (nonatomic, copy) NSString * merchant_id;
/*
 *店铺的联系方式
 */
@property (nonatomic, copy) NSString * merchant_phone;

@property (nonatomic, copy) SHyphenateList_choiceBlock SHyphenateList_choice;
@end

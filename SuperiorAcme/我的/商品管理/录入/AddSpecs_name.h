//
//  AddSpecs_name.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/15.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void (^AddSpecs_nameFinishBlock)(NSDictionary *dict);

typedef  void (^ModiySpecs_nameFinishBlock)(NSDictionary *dict,NSInteger index);

@interface AddSpecs_name : UIViewController
@property(nonatomic,copy) AddSpecs_nameFinishBlock block;

@property(nonatomic,copy) ModiySpecs_nameFinishBlock ModiyBlock;
@property(nonatomic,strong) NSMutableArray * arr;
@property(nonatomic,strong) NSString * tittle;
@property(nonatomic,strong) NSString * pid;
@property(nonatomic,strong) NSString * goods_id;
@property (assign, nonatomic) NSInteger index;
@property ( strong ,nonatomic)NSString *type; //新增 1 修改2
@property ( strong ,nonatomic)NSString *sta_mid;

-(id)initWithBlock:(AddSpecs_nameFinishBlock)ablock;

-(id)initWithModiyBlock:(ModiySpecs_nameFinishBlock)ablock;


@end

NS_ASSUME_NONNULL_END

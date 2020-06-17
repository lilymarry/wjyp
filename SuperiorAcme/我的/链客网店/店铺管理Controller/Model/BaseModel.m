//
//  OABaseModel.m
//  Re-OA
//
//  Created by imac-1 on 2016/12/29.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (stuff==nil) {
        stuff=[[NSMutableDictionary alloc] init];
    }
    [stuff setValue:value forKey:key];
   NSLog(@"WARNING : <%@> has undefined key: %@, value: %@", NSStringFromClass([self class]), key, value); 
}

- (void)setNilValueForKey:(NSString *)key
{
    NSLog(@"%@",key);
}

- (id)valueForUndefinedKey:(NSString *)key
{
    id value=[stuff valueForKey:key];
     NSLog(@"WARNING : <%@> has undefined key: %@", NSStringFromClass([self class]), key);
    return value;
}

@end

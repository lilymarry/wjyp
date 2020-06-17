//
//  UBTypeCell.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBTypeCell.h"

@implementation UBTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(void)xibWithCollectionView:(UICollectionView *)collectionView{
    [collectionView registerNib:[UINib nibWithNibName:[UBTypeCell cellIdentifier] bundle:nil]
     forCellWithReuseIdentifier:[UBTypeCell cellIdentifier]];
}

+(NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}


@end

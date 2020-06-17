//
//  SShopCar_editView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopCar_editView.h"
#import "SShopCar_editViewCell.h"
#import "SShopCar_editViewReusa.h"
#import "SCartAddCart.h"
#import "SGoodsAttrApi.h"
#import "JYEqualCellSpaceFlowLayout.h"

@interface SShopCar_editView () <UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
{
    NSArray * thisArr;
    NSMutableArray * thisConArr;//商品属性集合
    NSArray * thisConArr_Model;//对比属性原始数据
    NSString * nowType;//YES立即购买
    NSString * model_product_id;//最后选择的属性id
    NSString * model_product_name;//最后选择的属性名称（购物车编辑需要）
    NSString * model_goods_num;//最后选择的属性库存（购物车编辑需要展示）
    NSString * model_shop_price;
    NSString * model_market_price;
    NSString * model_red_return_integral;
    NSString * model_wy_price;
    NSString * model_yx_price;
    NSString * model_choiceContent;
    NSArray * model_dj_ticket;
    NSString * model_integral;
    /*
     *拼单商品对应的正常商品的价格
     */
    NSString * model_p_shop_price;
    
    ///对应的普通商品的返还积分数
    NSString * model_p_integral;
    
    NSString * thisGym;//详情页GYM
    
    NSString * model_group_buy_id;//拼单购选中的商品规格ID
    
    NSString * group_goods_max_num;//拼单购最大限购数
    
#pragma mark - 无界商店
    /*
     *无界商店需要回传到商品详情页的数据
     */
    NSString * model_integral_buy_id;//无界商店选中的规格的商品ID
    NSString * model_use_integral;//无界商店选中的规格商品的积分
    
    NSString * model_gift_goods_id;//无界商店选中的规格的商品ID
    NSString * model_use_voucher;//无界商店选中的规格商品的积分
    
    
    
    
}
@end
@implementation SShopCar_editView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SShopCar_editView" owner:self options:nil];
        [self addSubview:_thisView];
        
        _goodsImageView.layer.masksToBounds = YES;
        _goodsImageView.layer.cornerRadius = 3;
        _goodsImageView.layer.borderWidth = 0.5;
        _goodsImageView.layer.borderColor = MyLine.CGColor;
        
        _goodsImage.layer.masksToBounds = YES;
        _goodsImage.layer.cornerRadius = 3;
        
        _numTF.delegate = self;
        
        
        JYEqualCellSpaceFlowLayout * mFlowLayout = [[JYEqualCellSpaceFlowLayout alloc]initWithType:AlignWithLeft betweenOfCell:10.0];
        
//        UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        mFlowLayout.minimumInteritemSpacing = 10;//用于控制单元格之间最小 列间距
        mFlowLayout.minimumLineSpacing = 10;//用于控制单元格之间最小 行间距
        mFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        mFlowLayout.itemSize = CGSizeMake((ScreenW - 50)/4, 40);//设置单元格的宽和高
        mFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);//各分区上下左右空白区域大小
        
        [_mCollect setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
        _mCollect.showsVerticalScrollIndicator = NO;
        //注册：告诉系统哪个类创建重用标识，标识是什么，创建什么类型的cell
        [_mCollect registerNib:[UINib nibWithNibName:@"SShopCar_editViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SShopCar_editViewCell"];
        [_mCollect registerNib:[UINib nibWithNibName:@"SShopCar_editViewReusa" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SShopCar_editViewReusa"];
        [_mCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        
       
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_numTF == textField) {
        _numTF.text = [NSString stringWithFormat:@"%.f", fabsf(floorf([textField.text intValue]))];
        
        if ([_numTF.text integerValue] > [model_goods_num integerValue]) {
            _numTF.text = model_goods_num;
        } else if ([_numTF.text integerValue] <= 0) {
            _numTF.text = @"1";
        }
        
        if ([_buy_goods_type isEqualToString:@"拼单购"]) {
            if ([group_goods_max_num integerValue] > 0) {
                if ([model_goods_num integerValue] >= [group_goods_max_num integerValue]) {
                    if ([_numTF.text integerValue] > [group_goods_max_num integerValue]) {
                        //超过最大限制购买数
                        _numTF.text = [NSString stringWithFormat:@"%ld", [group_goods_max_num integerValue]];
                    }
                }
                
            }
        }
        
        
    }
}
- (void)showModel {
//    if (_is_active) {
//        _cart_add_button.hidden=YES;
//        _cart_minus_button.hidden=YES;
//    }
    
    _numTF.delegate = self;
    thisConArr = [[NSMutableArray alloc] init];
    SGoodsAttrApi * attrApi = [[SGoodsAttrApi alloc] init];
    attrApi.buy_goods_type = _buy_goods_type;
    attrApi.goods_id = _goods_id;
    attrApi.product_id = _product_id == nil ? @"" : _product_id;
    attrApi.group_buy_type_status = _group_buy_type_status;
    [attrApi sGoodsAttrApiSuccess:^(NSString *code, NSString *message, id data) {
        SGoodsAttrApi * attrApi = (SGoodsAttrApi *)data;
        //对比数组
        for (int i = 0; i < attrApi.data.first_val.count; i++) {
            SGoodsAttrApi * infor_sub_System = attrApi.data.first_val[i];
            //把所有商品组合规格存入数组里 thisConArr
            [thisConArr addObject:infor_sub_System.arrtValue];
        }
        if ([attrApi.data.is_attr isEqualToString:@"0"] || attrApi.data.is_attr == nil) {
#pragma mark - 没有属性 只加载默认图片、金额、库存
            //显示内容
            model_goods_num = attrApi.data.goods_num;
            if ([_buy_goods_type isEqualToString:@"无界商店"]) {
                /*
                 *  fxg 无界商店 积分 放价格后面
                 */
                _thisPrice.text = [NSString stringWithFormat:@"%@积分",attrApi.data.use_integral];
            }
            if ([_buy_goods_type isEqualToString:@"赠品专区"]) {
                _thisPrice.text = [NSString stringWithFormat:@"%@赠品券",attrApi.data.use_voucher];
            }
            else{
                _thisPrice.text = [NSString stringWithFormat:@"￥%@",attrApi.data.shop_price];
            }
            [_goodsImage sd_setImageWithURL:[NSURL URLWithString:attrApi.data.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            _all_num.text = [NSString stringWithFormat:@"库存(%@)",model_goods_num];
            //是否显示商品限购数
            [self isShowMaxNum:attrApi.data.max_num andBuy_goods_type:_buy_goods_type];
            _numTF.text = @"1";
        } else {
#pragma mark - 有属性
            //把所有商品规格存入数组 thisArr
            thisArr = attrApi.data.first_list;
            //把所有商品规格组合存入数组 thisConArr_Model
            thisConArr_Model = attrApi.data.first_val;
            //判断每个分类规格里面是否只有一个子规格
            bool isSingle = TRUE;
            for (SGoodsAttrApi * infor_MoRen in thisArr) {
                if (infor_MoRen.first_list_val.count == 1) {
                    SGoodsAttrApi * infor_MoRen_sub = infor_MoRen.first_list_val.firstObject;
                    //默认选中第一个子规格
                    infor_MoRen_sub.val_isno = @"1";
                } else if (infor_MoRen.first_list_val.count > 1) {
                    isSingle = FALSE;
                }
            }
            if (!isSingle) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self collectionView:_mCollect didSelectItemAtIndexPath:indexPath];
            } else {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:thisArr.count - 1];
                [self collectionView:_mCollect didSelectItemAtIndexPath:indexPath];
            }
            if (self.SShopCar_editView_showPrice) {
                self.SShopCar_editView_showPrice();
            }
        }
    } andFailure:^(NSError *error) {
    }];
}
#pragma mark - 是否立即购买
- (void)addBuy:(NSString *)addBuy_isno {
    nowType = addBuy_isno;
    [_submitBtn setTitle:addBuy_isno forState:UIControlStateNormal];

}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (thisArr.count == 0) {
        _thisPrice_Title.hidden = YES;
    } else {
        _thisPrice_Title.hidden = NO;
    }
    return thisArr.count;
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    SGoodsAttrApi * infor = thisArr[section];
    return infor.first_list_val.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = {0.01,50};
    return size;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize size = {0.01,0.5};
    return size;
}
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SGoodsAttrApi * infor = thisArr[indexPath.section];
    SGoodsAttrApi * infor_sub = infor.first_list_val[indexPath.row];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGSize size = [infor_sub.val boundingRectWithSize:CGSizeMake(MAXFLOAT, 40) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return CGSizeMake(size.width + 50, 40);
}
#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SShopCar_editViewReusa * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SShopCar_editViewReusa" forIndexPath:indexPath];

        SGoodsAttrApi * infor = thisArr[indexPath.section];
        header.thisTitle.text = infor.first_list_name;
        reusableview = header;
        
    }// header;
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(5, 0, ScreenW - 10, 0.5)];
        [footer addSubview:line];
        line.backgroundColor = MyLine;

        reusableview = footer;
        
    }// header;
    return reusableview;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SShopCar_editViewCell * mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SShopCar_editViewCell" forIndexPath:indexPath];
    mCell.thisTitle.layer.masksToBounds = YES;
    mCell.thisTitle.layer.cornerRadius = 20;
    mCell.thisTitle.layer.borderWidth = 0.5;
    mCell.thisTitle.layer.borderColor = MyLine.CGColor;
    
    SGoodsAttrApi * infor = thisArr[indexPath.section];
    SGoodsAttrApi * infor_sub = infor.first_list_val[indexPath.row];
    mCell.thisTitle.text = infor_sub.val;
    if (infor_sub.val_isno == nil) {
        //未选中
        mCell.thisTitle.backgroundColor = [UIColor whiteColor];
        mCell.thisTitle.textColor = WordColor;
    } else if ([infor_sub.val_isno isEqualToString:@"1"]) {
        //选中
        mCell.thisTitle.backgroundColor = [UIColor redColor];
        mCell.thisTitle.textColor = [UIColor whiteColor];
    } else if ([infor_sub.val_isno isEqualToString:@"2"]) {
        //库存不足
        mCell.thisTitle.backgroundColor = [UIColor groupTableViewBackgroundColor];
        mCell.thisTitle.textColor = WordColor_sub;
    }
    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = thisArr.count;
    NSString *selectArrStr;
    SGoodsAttrApi * tmpArr = thisArr[indexPath.section];
    SGoodsAttrApi * tmpArr_sub = tmpArr.first_list_val[indexPath.row];
    selectArrStr = [NSString stringWithFormat:@"%@", tmpArr_sub.val];
    //不可点击状态时 直接跳出当前方法
    if ([tmpArr_sub.val_isno isEqualToString:@"2"]) return;
    //修改被选中规格的效果
    for (int i = 0; i < tmpArr.first_list_val.count; i++) {
        SGoodsAttrApi * infor_Choice = tmpArr.first_list_val[i];
        if (i == indexPath.row) {
            infor_Choice.val_isno = @"1";
        } else {
            if (![infor_Choice.val_isno isEqualToString:@"2"]) {
                infor_Choice.val_isno = nil;
            }
        }
    }
    //拼接最新选中的组合并更新其他分类规格状态效果
    NSMutableArray * infor_Arr_choice = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        if (i <= indexPath.section) {
            SGoodsAttrApi *tmpArr = thisArr[i];
            //当前分类规格之前的规格
            for (SGoodsAttrApi *tmpNextArr in tmpArr.first_list_val) {
                if ([tmpNextArr.val_isno isEqualToString:@"1"]) {
                    [infor_Arr_choice addObject:tmpNextArr.val];
                }
            }
            if (infor_Arr_choice.count > 1) {
                selectArrStr = [NSString stringWithFormat:@"%@", [infor_Arr_choice componentsJoinedByString:@"+"]];
            }
        } else {
            if (indexPath.section + 1 <= count - 1) {
                SGoodsAttrApi * tmp_netxArr = thisArr[indexPath.section + 1];
                for (SGoodsAttrApi * infor_Choice in tmp_netxArr.first_list_val) {
                    NSString *str = [NSString stringWithFormat:@"%@+%@", [infor_Arr_choice componentsJoinedByString:@"+"], infor_Choice.val];
                    if ([self choiceArrCon:str] == NO) {
                        infor_Choice.val_isno = nil;
                    } else {
                        infor_Choice.val_isno = @"2";
                    }
                }
            }
            
        }
    }
    //把不相邻当前分类规格的其他规格全部设置成不可点击状态
    for (int i = (int)(indexPath.section + 2); i < thisArr.count; i++) {
        SGoodsAttrApi * arr = thisArr[i];
        for (int j = 0; j < arr.first_list_val.count; j++) {
            SGoodsAttrApi * tmparr = arr.first_list_val[j];
            tmparr.val_isno = @"2";
        }
    }
    //更新数据
    BOOL isHave = NO;
    if (indexPath.section + 1 == count) {
        //当前规格是最后一个规格
        for (SGoodsAttrApi * infor_con in thisConArr_Model) {
            if ([infor_con.arrtValue isEqualToString:selectArrStr]) {
                isHave = YES;
                //找到匹配的规格组合更新数据
                [self updateValue:infor_con andStr:selectArrStr];
            }
        }
    } else {
        if (indexPath.section + 1 != count || !isHave) {
            //当前规格不是最后一个规格 或者 没有找到符合的规格
            _all_num.text = [NSString stringWithFormat:@"库存(%@)",@"0"];
            _maxNum.text = @"";
            group_goods_max_num = @"0";
            _numTF.text = @"0";
        }
    }
    [_mCollect reloadData];
}

- (void)updateValue:(SGoodsAttrApi *)infor_con andStr:(NSString *)str {
    if ([_buy_goods_type isEqualToString:@"无界商店"]) {
        _thisPrice.text = [NSString stringWithFormat:@"%@积分",infor_con.use_integral];
    }
    else if ([_buy_goods_type isEqualToString:@"赠品专区"]) {
        _thisPrice.text = [NSString stringWithFormat:@"%@赠品券",infor_con.use_voucher];
    }
    else{
        _thisPrice.text = [NSString stringWithFormat:@"￥%@",infor_con.shop_price];
    }
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:infor_con.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    _all_num.text = [NSString stringWithFormat:@"库存(%@)",infor_con.goods_num];
    //是否显示商品限购数
    [self isShowMaxNum:infor_con.max_num andBuy_goods_type:_buy_goods_type];
    model_product_id = infor_con.id;
    model_product_name = infor_con.arrtValue;
    model_goods_num = infor_con.goods_num;
    _numTF.text = @"1";
    model_shop_price = infor_con.shop_price;
    model_market_price = infor_con.market_price;
    //                    model_red_return_integral = infor_con.red_return_integral;
    /*
     *设置拼单购模式下,显示的积分
     */
    if ([_buy_goods_type isEqualToString:@"拼单购"]) {
        model_red_return_integral = infor_con.integral;
    }else{
        model_red_return_integral = infor_con.red_return_integral;
    }
    /*
     *对应的普通商品的价格
     */
    model_p_shop_price = infor_con.p_shop_price;
    
    /*
     *对应普通商品返还的积分
     */
    model_p_integral = infor_con.p_integral;
    
    model_wy_price = infor_con.wy_price;
    model_yx_price = infor_con.yx_price;
    model_choiceContent = str;
    model_dj_ticket = infor_con.dj_ticket;
    model_integral = infor_con.integral;
    model_group_buy_id = infor_con.group_buy_id == nil ? @"" : infor_con.group_buy_id;
    
    /*
     *保存无界商店需要回传的数据
     */
    model_integral_buy_id = infor_con.integral_buy_id == nil ? @"" : infor_con.integral_buy_id;
    model_use_integral = infor_con.use_integral;
    
    
    //赠品专区
    model_gift_goods_id = infor_con.gift_goods_id == nil ? @"" : infor_con.gift_goods_id;
    model_use_voucher= infor_con.use_voucher;
    
}
- (BOOL)choiceArrCon:(NSString *)str {
    for (NSString * str_sub in thisConArr) {
        if (!([str_sub rangeOfString:str].location == NSNotFound)) {
            //所有组合中存在当前已选择的规格组合
            return NO;
        }
    }
    return YES;
}
- (BOOL)choice_isno {
    for (SGoodsAttrApi * infor in thisArr) {
        for (SGoodsAttrApi * infor_sub in infor.first_list_val) {
            if ([infor_sub.val_isno isEqualToString:@"1"]) {
                return NO;
            }
        }
    }
    return YES;
}
- (IBAction)backBtn:(UIButton *)sender {
    if (self.SShopCar_editView_back) {
        self.SShopCar_editView_back();
    }
}
- (IBAction)submitBtn:(UIButton *)sender {
//    if ([_numTF.text integerValue] == 0) {
//        [MBProgressHUD showError:@"此商品属性库存不足" toView:self];
//        return;
//    }//旧代码

    /*
     *添加是否有库存的判断
     */
    if ([[self StringContainNumberWith:_all_num.text] integerValue] == 0) {
        [MBProgressHUD showError:@"此商品属性库存不足" toView:self];
        return;
    }
    /*
     *添加选择的商品的数量是否>0的判断
     */
    if ([_numTF.text integerValue] == 0) {
        [MBProgressHUD showError:@"请确认购买商品的数量!" toView:self];
        return;
    }
    
    
//    if (model_product_id == nil) {
//        [MBProgressHUD showError:@"请完善属性" toView:self];
//        return;
//    }
    if ([thisGym isEqualToString:@"GYM"]) {
        if (self.SShopCar_editView_now) {
            self.SShopCar_editView_now(model_shop_price, model_market_price, model_red_return_integral, model_wy_price, model_yx_price, model_goods_num, model_choiceContent,_numTF.text,model_product_id, model_dj_ticket,model_integral,model_group_buy_id,model_p_shop_price,model_p_integral,model_integral_buy_id,model_use_integral,model_gift_goods_id,model_use_voucher);
        }
        return;
    }
    SCartAddCart * addCart = [[SCartAddCart alloc] init];
    addCart.goods_id = _goods_id;
    addCart.product_id = model_product_id;
    if ([nowType isEqualToString:@"立即购买"] || [nowType isEqualToString:@"立即兑换"] || [nowType isEqualToString:@"确定"]) {
        
        /*
         *添加判断,是否由拼单购一键参团界面的回调
         */
        if (_isOneKeyGroup) {
            if (self.SShopCar_editView_OneKeyGroupAddBuy) {
                self.SShopCar_editView_OneKeyGroupAddBuy(_numTF.text,model_product_id == nil ? _product_id : model_product_id, model_group_buy_id);
            }
        }else{
            //立即购买、立即兑换要出去
            if (self.SShopCar_editView_addBuy) {
                self.SShopCar_editView_addBuy(_numTF.text,model_product_id == nil ? _product_id : model_product_id);
            }
        }
        return;
    }
    if ([nowType isEqualToString:@"完成"]) {
        //购物车编辑要出去
        if (self.SShopCar_editView_carEdit) {
            self.SShopCar_editView_carEdit(_numTF.text, model_product_id, model_product_name,model_goods_num);
        }
        return;
    }
    addCart.num = _numTF.text;
    [MBProgressHUD showMessage:nil toView:self];
    [addCart sCartAddCartSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.SShopCar_editView_submit) {
                    self.SShopCar_editView_submit();
                }
            });
        } else {
            [MBProgressHUD showError:message toView:self];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self];
    }];    
}
- (IBAction)leftBtn:(UIButton *)sender {
    if ([_numTF.text integerValue] == 0) {
        return;
    }
    if ([model_goods_num integerValue] != 0 && [_numTF.text integerValue] > 1) {
        _numTF.text = [NSString stringWithFormat:@"%ld",[_numTF.text integerValue] - 1];
    }
}
- (IBAction)rightBtn:(UIButton *)sender {
    if ([_numTF.text integerValue] == 0) {
        return;
    }
    if ([model_goods_num integerValue] != 0 &&[model_goods_num integerValue] - [_numTF.text integerValue] <= 0) {
        return;
    }
    if ([_buy_goods_type isEqualToString:@"拼单购"]) {
        if ([group_goods_max_num integerValue] > 0) {
            if ([_numTF.text integerValue] + 1 > [group_goods_max_num integerValue]) {
                return;
            }
        }
    }
    _numTF.text = [NSString stringWithFormat:@"%ld",[_numTF.text integerValue] + 1];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([model_goods_num integerValue] == 0) {
        _numTF.text = @"0";
    }
    if ([textField.text isEqualToString:@""]) {
        _numTF.text = @"1";
    }
    if ([model_goods_num integerValue] != 0 && [model_goods_num integerValue] - [_numTF.text integerValue] <= 0) {
        _numTF.text = model_goods_num;
    }
//    if (_is_active) {
//        _numTF.text = @"1";
//    }
    
    return YES;
}

#pragma mark - 商品详情改成这样
- (void)goodsInfor_now:(NSString *)gym {
    thisGym = gym;
    [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    
}


#pragma mark - 获取字符串中的数字
/*
 *获取字符串中的数字
 */
- (NSString * )StringContainNumberWith:(NSString *)str {
    
    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    int containNum =[[str stringByTrimmingCharactersInSet:nonDigits] intValue];
    return [NSString stringWithFormat:@"%d",containNum];
}


/**
 拼单购商品 最大限购数
 
 @param maxNum 限购数
 @param buy_goods_type 商品类型
 */
- (void)isShowMaxNum:(NSString *)maxNum andBuy_goods_type:(NSString *)buy_goods_type{
    if ([buy_goods_type isEqualToString:@"拼单购"]) {
        if ([maxNum integerValue] > 0) {
            _maxNum.text = [NSString stringWithFormat:@"限购(%@)", maxNum];
            group_goods_max_num = maxNum;
        } else {
            _maxNum.text = @"";
            group_goods_max_num = @"0";
        }
    }
}
@end

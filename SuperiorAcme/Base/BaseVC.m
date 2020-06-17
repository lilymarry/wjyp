//
//  BaseVC.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//  基类控制器

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];

}
-(void)lefthBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 创建带分段控制器的NavigationController

 @param segmentedControlTitles 分段控制器 标题集合
 @param isHave 是否有右边按钮
 @param rightBtnOption 右边按钮参数字典
 */
-(void)CreatNavBar:( NSArray * _Nonnull )segmentedControlTitles andIsHaveRightBtn:(BOOL)isHave andRightBtnOption:( NSDictionary * _Nullable )rightBtnOption andDefaultHiddenForRightBtn:(BOOL)RightBtnIsHidden{
    // 初始化，添加分段名，会自动布局
    UISegmentedControl * segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedControlTitles];
    segmentedControl.frame = CGRectMake(0, 0, 150, 30);
    // 设置初始选中项
    segmentedControl.selectedSegmentIndex = 0;
    // 设置颜色
    segmentedControl.tintColor = [UIColor colorWithRed:210.0/255 green:31.0/255 blue:24.0/255 alpha:1];
    // 添加响应方法
    [segmentedControl addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    _segmentControl = segmentedControl;
    
    if (isHave && rightBtnOption.count > 0) {
        //navigationItem右侧的按钮
        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 44, 44);
        if (RightBtnIsHidden) rightBtn.hidden = YES;
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [rightBtn setTitleColor:[UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1] forState:UIControlStateNormal];
        UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0,0,-15);
        [rightBtn addTarget:self action:@selector(navRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        if ([rightBtnOption valueForKey:@"title"]) {
            [rightBtn setTitle:[rightBtnOption valueForKey:@"title"] forState:UIControlStateNormal];
        }
        if ([rightBtnOption valueForKey:@"imageName"]) {
            [rightBtn setImage:[UIImage imageNamed:[rightBtnOption valueForKey:@"imageName"]] forState:UIControlStateNormal];
        }
        self.navigationItem.rightBarButtonItem = rightBtnItem;
    }
}

/**
 UISegmentedControl的方法

 @param sender UISegmentedControl被点击
 */
- (void)selectItem:(UISegmentedControl *)sender {
}

/**
 navRightBtn的方法

 @param btn 点击的按钮
 */
-(void)navRightBtn:(UIButton *)btn{
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

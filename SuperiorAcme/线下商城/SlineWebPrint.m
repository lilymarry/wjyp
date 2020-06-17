//
//  SlineWebPrint.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/12/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SlineWebPrint.h"
#import "SEPrinterManager.h"

@interface SlineWebPrint ()<UITableViewDelegate,UITableViewDataSource,SEPrinterManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)   NSArray              *deviceArray;  /**< 蓝牙设备个数 */
@property (strong, nonatomic)   NSArray              *saveDeviceArray;  /**< 蓝牙设备个数 */
@property (strong, nonatomic)    SEPrinterManager *manager;
@end

@implementation SlineWebPrint

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"打印设备";
    
    _manager = [SEPrinterManager sharedInstance];
    _manager.delegate=self;
    
   NSString  *uuid=  [SEPrinterManager UUIDStringForLastPeripheral];

    [_manager startScanPerpheralTimeout:10 Success:^(NSArray<CBPeripheral *> *perpherals,BOOL isTimeout) {
      //  NSLog(@"perpherals:%@",perpherals);
        _deviceArray = perpherals;
        for (CBPeripheral *per in perpherals) {
            if ([per.identifier.UUIDString isEqualToString:uuid]) {
                self.saveDeviceArray =[NSArray arrayWithObject:per];
            }
        }
        [_tableView reloadData];
    } failure:^(SEScanError error) {
        NSLog(@"error:%ld",(long)error);
    }];
  
    [self CreatNavigationBar];
}
-(void)CreatNavigationBar{

    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn setTitle:@"停止" forState:UIControlStateSelected];
    [rightBtn setTitleColor:[UIColor colorWithRed:210.0/255 green:31.0/255 blue:24.0/255 alpha:1] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(selectPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    

}
-(void)selectPress:(UIButton *)btn
{
     btn.selected = !btn.selected;
    if (!btn.selected) {
        [_manager startScanPerpheralTimeout:10 Success:^(NSArray<CBPeripheral *> *perpherals,BOOL isTimeout) {
            
            _deviceArray = perpherals;
            
            [_tableView reloadData];
        } failure:^(SEScanError error) {
            NSLog(@"error:%ld",(long)error);
        }];
    }
    else
    {
        [_manager stopScan];
    }

}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return _saveDeviceArray.count;
    }
    else
    {
       return _deviceArray.count;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"已匹配的设备";
    }
    else
    {
        return @"附近的设备";
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"deviceId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    CBPeripheral *peripherral;
    if (indexPath.section==0) {
          peripherral = [self.saveDeviceArray objectAtIndex:indexPath.row];
    }
    else{
       peripherral = [self.deviceArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"名称:%@",peripherral.name];

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CBPeripheral *peripheral;
    if (indexPath.section==0) {
        peripheral = [self.saveDeviceArray objectAtIndex:indexPath.row];
    }
    else{
        peripheral = [self.deviceArray objectAtIndex:indexPath.row];
    }
    
    [_manager connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
        if (error) {
              [MBProgressHUD showError:@"连接失败" toView:self.view];
           
        } else {
           
            [MBProgressHUD showError:@"连接成功" toView:self.view];
        }
    }];
    
    // 如果你需要连接，立刻去打印
    //    [[SEPrinterManager sharedInstance] fullOptionPeripheral:peripheral completion:^(SEOptionStage stage, CBPeripheral *perpheral, NSError *error) {
    //        if (stage == SEOptionStageSeekCharacteristics) {
    //            HLPrinter *printer = [self getPrinter];
    //
    //            NSData *mainData = [printer getFinalData];
    //            [[SEPrinterManager sharedInstance] sendPrintData:mainData completion:nil];
    //        }
    //    }];
}

-(void)printerManager:(SEPrinterManager *)manager scanError:(SEScanError)error
{
    if (error==SEScanErrorPoweredOff) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请打开蓝牙" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (error==SEScanErrorTimeout)
    {
        [MBProgressHUD showError:@"搜索超时" toView:self.view];
    }
    else
    {
        [MBProgressHUD showError:@"设备不支持" toView:self.view];
    }
}

@end

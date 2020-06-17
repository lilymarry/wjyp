//
//  HelpCenter.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/9.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "HelpCenter.h"
#import "SArticleHelpCenter.h"
#import "HelpCenterCell.h"
#import "HelpCenterChildCell.h"
@interface HelpCenter ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arr;
}

@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end


  
@implementation HelpCenter

- (void)viewDidLoad {
    [super viewDidLoad];
      _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
      [_mTable registerNib:[UINib nibWithNibName:@"HelpCenterCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HelpCenterCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"HelpCenterChildCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HelpCenterChildCell"];
    
    if ([_type isEqualToString:@"4"]) {
        self.title=@"寄售攻略";
    }
    else
    {
         self.title=@"常见问题";
    }
    SArticleHelpCenter * center = [[SArticleHelpCenter alloc] init];
  
        center.type = _type;
          
            [MBProgressHUD showMessage:nil toView:self.view];
            [center sArticleHelpCenterSuccess:^(NSString *code, NSString *message, id data) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
    
                SArticleHelpCenter * center = (SArticleHelpCenter *)data;
                arr=[NSMutableArray arrayWithArray:center.data];
            
                [_mTable reloadData];
    
            } anFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SArticleHelpCenter * model =arr[indexPath .row];
    
    if (model.isChild) {
     
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        CGFloat h = [model.content sizeWithFont:[UIFont systemFontOfSize:16]
                            constrainedToSize:CGSizeMake(w, CGFLOAT_MAX)
                                lineBreakMode:NSLineBreakByWordWrapping].height;
        model.webHeight = h + 40;
        return model.webHeight + 40;
    }
    else
    {
        return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    SArticleHelpCenter * center =arr[indexPath .row];
   
    if (center.isChild) {
        
       
        HelpCenterChildCell *cell = [[HelpCenterChildCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HelpCenterChildCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        [cell loadUrlStr:center.content height:center.webHeight ];

         return cell;
    }
   
    else
    {
        HelpCenterCell * oneCell = [tableView dequeueReusableCellWithIdentifier:@"HelpCenterCell" forIndexPath:indexPath];
        oneCell.titleLab.text=center.title;
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (center.isExpended) {
            oneCell.stateImageView.image=[UIImage imageNamed:@"灰色上箭头"];
        }
        else
        {
           oneCell.stateImageView.image=[UIImage imageNamed:@"灰色下箭头"];
        }
        return oneCell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     SArticleHelpCenter * parentModel =arr[indexPath .row];
    if (parentModel.isChild==NO) {
        parentModel.isExpended= !parentModel.isExpended? YES:NO;
        
        NSIndexPath *newIndexPath= [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
        
        if (parentModel.isExpended) {
             SArticleHelpCenter  *childModel= [parentModel copy] ;
            childModel.isChild=YES;
            [arr insertObject:childModel atIndex:indexPath.row+1];
            
            [_mTable beginUpdates];
            
            [_mTable insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationMiddle];
            
            [_mTable endUpdates];
            
        }else{
            [arr removeObjectAtIndex:indexPath.row+1];
            NSIndexPath *newIndexPath= [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
            
            [_mTable beginUpdates];
          
            [_mTable  deleteRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationMiddle];
            [_mTable endUpdates];
        }
        
    }
    [_mTable reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

//
//  SHelp_NewContent.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHelp_NewContent.h"
#import "SHelpCell.h"
#import "SHelp_header.h"
#import "SArticleHelpCenter.h"

@interface SHelp_NewContent ()
{
    NSArray * thisArr;
}
@end

@implementation SHelp_NewContent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SHelp_NewContent" owner:self options:nil];
        [self addSubview:_thisView];
        
        [_mTable registerNib:[UINib nibWithNibName:@"SHelpCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHelpCell"];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showModel:(NSArray *)arr {
    thisArr = arr;
    [_mTable reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return thisArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SHelp_header * header = [[SHelp_header alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];

    SArticleHelpCenter * list = thisArr[section];
    header.thisTitle.text = [NSString stringWithFormat:@"%ld.%@",section + 1,list.title];
    if (list.is_no == NO) {
        [header.openBtn setImage:[UIImage imageNamed:@"灰色上箭头"] forState:UIControlStateNormal];
    } else {
        [header.openBtn setImage:[UIImage imageNamed:@"灰色下箭头"] forState:UIControlStateNormal];
    }
    [header.openBtn addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [header.openBtn setTag:section];
    return header;
}
- (void)openBtnClick:(UIButton *)btn {
    SArticleHelpCenter * list = thisArr[btn.tag];
    if (list.is_no == NO) {
        list.is_no = YES;
    } else {
        list.is_no = NO;
    }
//    [_mTable reloadData];
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:btn.tag];
    [_mTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SArticleHelpCenter * list = thisArr[indexPath.section];
    if (list.is_no == YES) {
        return 0.01;
    }
    //1.将字符串转化为标准HTML字符串
    NSString *str1 = [self htmlEntityDecode:list.content];
    //2.将HTML字符串转换为attributeString
    NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
    CGRect rect = [attributeStr boundingRectWithSize:CGSizeMake(ScreenW - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize size = rect.size;
    return size.height + 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHelpCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SHelpCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SArticleHelpCenter * list = thisArr[indexPath.section];
    
    //1.将字符串转化为标准HTML字符串
    NSString *str1 = [self htmlEntityDecode:list.content];
    //2.将HTML字符串转换为attributeString
    NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
    
    //3.使用label加载html字符串
    cell.thisContet.attributedText = attributeStr;
//    cell.thisContet.text = list.content;
    
    return cell;
}

//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

//去掉 HTML 字符串中的标签
- (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

@end

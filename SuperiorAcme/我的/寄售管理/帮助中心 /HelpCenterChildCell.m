//
//  HelpCenterChildCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/9.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "HelpCenterChildCell.h"
#import<WebKit/WebKit.h>
@interface HelpCenterChildCell()<WKNavigationDelegate>
@property (strong, nonatomic)  WKWebView * wk_web;
@end
@implementation HelpCenterChildCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self buildUI];
    }
    return self;
}
- (void)buildUI
{
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    _wk_web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0) configuration:wkWebConfig];
    _wk_web.userInteractionEnabled = YES;
    //ios的scrollview嵌套webview，解决事件冲突
    //    如果你触摸的地方是webView，那么响应的只可能是webView，如果在webView之外，就是scrollview响应。
    //    当然，如果webView滑动到边界了，再拉也会作用在scrollview上的。如果你设置webview不可滚动，那就没有任何问题了。
    _wk_web.scrollView.scrollEnabled=NO;
    

    [self.contentView addSubview:_wk_web];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)loadUrlStr:(NSString *)contentStr height:(float)height
{
    [_wk_web loadHTMLString:contentStr baseURL:nil];
    _wk_web.frame = CGRectMake(0, 0, ScreenW, height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

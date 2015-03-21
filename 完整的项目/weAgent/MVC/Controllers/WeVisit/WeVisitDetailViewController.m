//
//  WeVisitDetailViewController.m
//  weAgent
//
//  Created by 王拓 on 14/12/3.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "WeVisitDetailViewController.h"

@interface WeVisitDetailViewController ()

@end

@implementation WeVisitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[WeVisitDetail alloc]init];
    //初始化条件
    NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",self.infoId,@"id",nil];
    
    DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            NSDictionary *article=[[NSDictionary alloc]init];
            article=[[methodResult objectForKey:@"result"] objectForKey:@"articles"];
            
            //设置标题
            self.view.title.text=[article objectForKey:@"title"];
            self.view.title.lineBreakMode=NSLineBreakByWordWrapping;
            CGRect contentTmpRect=[self.view.title.text boundingRectWithSize:CGSizeMake(270, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.view.title.font,NSFontAttributeName, nil] context:nil];
            CGFloat contentTitleH=contentTmpRect.size.height;
            
            //重新定义高度
            CGRect contentFrame=self.view.title.frame;
            contentFrame.size.height=contentTitleH;
            self.view.title.frame=contentFrame;
            
            //分段数
            long int contentCount =[[article objectForKey:@"content"] count];
            
            NSString *subTitle=[[NSString alloc]initWithFormat:@"发表于 %@ 阅读量 %@",[article objectForKey:@"create_at"],[article objectForKey:@"click"]];
            self.view.info.text=subTitle;
            
            //循环添加每段内容
            for (int i=0; i<contentCount; i++) {
                NSArray *infoContent=[article objectForKey:@"content"][i];
                NSString *contentImg=infoContent[0];
                NSString *contentTitle=infoContent[1];
                NSString *contentMain=infoContent[2];
                [self loadContent:contentImg contentTitle:contentTitle contentMain:contentMain];
            }
        };
        
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:condition onCompletion:RPCMainHandler];
        
    };
    [self RPCUseClass:@"ItvArticles" callMethodName:@"show" withParameters:condition onCompletion:completionHandler];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)initWithId:(NSString*)infoId
{
    if ((self = [super init])) {
        self.infoId = infoId;
    }
    return self;
}

/**
 *  根据数据添加文章内容
 *
 *  @param contentImg   图片地址
 *  @param contentTitle 子标题
 *  @param contentMain  文章内容
 */
-(void) loadContent:(NSString *)contentImg contentTitle:(NSString *)contentTitle contentMain:(NSString *)contentMain{
    
    CGFloat adjustWidth=[[UIScreen mainScreen] bounds].size.width-40.0f;
    //设置图片
    //判断是否有图片
    if ([[contentImg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]!=0) {
        
        UIImageView *contentImage=[[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, adjustWidth, adjustWidth*0.60)];
        [contentImage setImageWithURL:[NSURL URLWithString:contentImg]];
        CSLinearLayoutItem *itemImg=[CSLinearLayoutItem layoutItemForView:contentImage];
        itemImg.padding=CSLinearLayoutMakePadding(10.0, 20.0, 0.0, 10.0);
        [self.view.linearLayoutView addItem:itemImg];
        
    }
    
    //设置副标题
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, adjustWidth, 27)];
    titleLabel.textColor=[UIColor grayColor];
    //设置行数
    [titleLabel setNumberOfLines:0];
    //设置字体及字号
    titleLabel.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    //设置内容个
    titleLabel.text=contentTitle;
    //设置自动识别高度
    titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    CGRect tmpRect=[titleLabel.text boundingRectWithSize:CGSizeMake(270, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:titleLabel.font,NSFontAttributeName, nil] context:nil];
    CGFloat contentH=tmpRect.size.height;
    //重新定义高度
    titleLabel.frame=CGRectMake(0.0, 0.0, adjustWidth, contentH);
    CSLinearLayoutItem *item=[CSLinearLayoutItem layoutItemForView:titleLabel];
    item.padding=CSLinearLayoutMakePadding(10.0, 20.0, 0.0, 10.0);
    [self.view.linearLayoutView addItem:item];
    
    
    
    
    //设置正文
    UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, adjustWidth, 27)];
    
    //设置行数
    [contentLabel setNumberOfLines:0];
    contentLabel.textColor=[UIColor lightGrayColor];
    
    //设置字体及字号
    contentLabel.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    
    //设置自动识别高度
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:contentMain];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    //行间距
    [paragraphStyle setLineSpacing:3];
    //首行缩进
    [paragraphStyle setFirstLineHeadIndent:22];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentMain length])];
    [contentLabel setAttributedText:attributedString];
    [contentLabel sizeToFit];
    
    
    //重新定义高度
    CSLinearLayoutItem *contentItem=[CSLinearLayoutItem layoutItemForView:contentLabel];
    contentItem.padding=CSLinearLayoutMakePadding(10.0, 20.0, 0.0, 10.0);
    [self.view.linearLayoutView addItem:contentItem];
    
}

@end

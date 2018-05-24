//
//  ViewController.m
//  LabelClicked
//
//  Created by Rey on 2018/5/23.
//  Copyright © 2018年 Rey. All rights reserved.
//

#import "ViewController.h"
#import "QTLabel.h"
@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    NSLog(@"%@",[URL scheme]);
    if([[URL scheme] containsString:@"ClickedStr"]){
        NSLog(@"点击了  %@",[URL scheme]);
    }
    return YES;
}
- (NSMutableAttributedString *)subStringWithSize:(CGSize)size withStr:(NSString *)desStr withSuffix:(NSString *)sStr{
    UIFont *ftm = [UIFont systemFontOfSize:18];
    NSString *iStr = [NSString stringWithFormat:@"%@%@",desStr,sStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    CGFloat linHei = 10;
    paragraphStyle.lineSpacing = linHei;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:iStr];
    [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, iStr.length)];
    [att addAttribute:NSFontAttributeName value:ftm range:NSMakeRange(0, iStr.length)];
//    [att addAttribute:NSLinkAttributeName value:@"ClickedStr://" range:NSMakeRange(desStr.length, sStr.length)];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor magentaColor] range:NSMakeRange(desStr.length, sStr.length)];

    CGRect rect = [att boundingRectWithSize:CGSizeMake(size.width, 9999) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];

//    CGRect rect = [iStr boundingRectWithSize:CGSizeMake(size.width,  CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attDic context:nil];
    if(rect.size.height > ftm.lineHeight*3+2*linHei){
        desStr = [desStr substringToIndex:desStr.length-1];
      return  [self subStringWithSize:size withStr:desStr withSuffix:sStr];
    }else{
        return att;
    }



}

- (void)createUI{
    UIFont *ftm = [UIFont systemFontOfSize:18];
    NSString *strI = @"超过一定行数的label强制在末尾加上一个展开且可以点击成全文超过一定行数的label强制在末尾加上一个展开且可以点击成全文超过一定行数的label强制在末尾加上一个展开且可以点击成全文超过一定行数的label强制在末尾加上一个展开且可以点击成全文超过一定行数的label强制在末尾加上一个展开且可以点击成全文超过一定行数的label强制在末尾加上一个展开且可以点击成全文超过一定行数的label强制在末尾加上一个展开且可以点击成全文超过一定行数的label强制在末尾加上一个展开且可以点击成全文";
    NSString *strI1 = @"ios 超过一定行数的label强制在末尾加eee";

//    UITextView *txtLab = [[UITextView alloc]initWithFrame:CGRectMake(20, 120, self.view.frame.size.width-2*20, 90)];
//    txtLab.textColor = [UIColor blackColor];
//    txtLab.font = ftm;
//    txtLab.attributedText = [self subStringWithSize:CGSizeMake(txtLab.frame.size.width+5, 90) withStr:strI withSuffix:@"...点击查看更多>>"];
//    txtLab.editable = NO;
//    [txtLab setScrollEnabled:YES];
//    txtLab.delegate = self;
//    [self.view addSubview:txtLab];
    UILabel *txtLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, self.view.frame.size.width-2*20, 90)];
    txtLab.textColor = [UIColor blackColor];
    txtLab.font = ftm;
    txtLab.attributedText = [self subStringWithSize:CGSizeMake(txtLab.frame.size.width, 90) withStr:strI withSuffix:@"点击查看更多"];
    txtLab.numberOfLines = 0;

    [self.view addSubview:txtLab];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labClick:)];
    [txtLab addGestureRecognizer:tap];


    QTLabel *lab1 = [[QTLabel alloc]initWithFrame:CGRectMake(20,220, self.view.frame.size.width-2*20, 110)];
    lab1.numberOfLines = 0;
    lab1.userInteractionEnabled = YES;
    NSString *linkStr = @"点击查看更多";
    lab1.attributedText = [self subStringWithSize:CGSizeMake(lab1.frame.size.width, 90) withStr:strI withSuffix:linkStr];
    [self.view addSubview:lab1];
    lab1.linkRanges = [NSMutableArray arrayWithObjects:[NSValue valueWithRange:NSMakeRange(lab1.attributedText.length-linkStr.length, linkStr.length)], nil];

    lab1.linkTapHandle = ^(QTLabel *label, NSString *selectStr, NSRange range){
        NSLog(@"str:%@ range:%@",selectStr,NSStringFromRange(range));
    };

//    txtLab.backgroundColor = [UIColor cyanColor];

}

- (void)labClick:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:tap.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

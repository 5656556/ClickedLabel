//
//  ViewController.m
//  LabelClicked
//
//  Created by Rey on 2018/5/23.
//  Copyright © 2018年 Rey. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "QTLabel.h"
@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController


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

    QTLabel *lab1 = [[QTLabel alloc]initWithFrame:CGRectMake(20,80, self.view.frame.size.width-2*20, 90)];
    lab1.numberOfLines = 0;
    lab1.userInteractionEnabled = YES;
    NSString *linkStr = @"点击查看更多";
    lab1.attributedText = [self subStringWithSize:CGSizeMake(lab1.frame.size.width, 90) withStr:strI withSuffix:linkStr];
    [self.view addSubview:lab1];
    lab1.linkRanges = [NSMutableArray arrayWithObjects:[NSValue valueWithRange:NSMakeRange(lab1.attributedText.length-linkStr.length, linkStr.length)], nil];

    lab1.linkTapHandle = ^(QTLabel *label, NSString *selectStr, NSRange range){
        NSLog(@"str:%@ range:%@",selectStr,NSStringFromRange(range));
    };
    NSArray *arrFTS = [UIFont familyNames];
    UIFont *tff = [ViewController customTTFFontWithName:@"FZkatongjian" fontSize:18];//[UIFont fontWithName:@"FZkatongjian" size:18];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 190,self.view.frame.size.width-2*20, 80)];
    lab2.numberOfLines = 0;
    lab2.text = strI;
    lab2.font = tff;
    [self.view addSubview:lab2];



//    txtLab.backgroundColor = [UIColor cyanColor];

}

+ (UIFont*)customTTFFontWithName:(NSString *)fontName fontSize:(float)fontsize
{
    NSDictionary *fontsizeAttr=[NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithFloat:fontsize], kCTFontSizeAttribute,
                                nil];
    return [ViewController customFontWithName:fontName
                               ofType:@"ttf"
                           attributes:fontsizeAttr];
}


+ (UIFont*)customFontWithName:(NSString *)fontName
                       ofType:(NSString *)type
                   attributes:(NSDictionary *)attributes
{
    NSString *fontPath = [[NSBundle mainBundle] pathForResource:fontName ofType:type];
    NSData *data = [[NSData alloc] initWithContentsOfFile:fontPath];
    CGDataProviderRef fontProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
#if  !__has_feature(objc_arc)
    [data release];
#endif
    CGFontRef cgFont = CGFontCreateWithDataProvider(fontProvider);
    CGDataProviderRelease(fontProvider);
    CTFontDescriptorRef fontDescriptor = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attributes);
    CTFontRef font = CTFontCreateWithGraphicsFont(cgFont, 0, NULL, fontDescriptor);
    CFRelease(fontDescriptor);
    CGFontRelease(cgFont);
    return (__bridge UIFont*)font;
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

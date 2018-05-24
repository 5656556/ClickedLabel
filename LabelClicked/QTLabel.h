//
//  QTLabel.h
//  LabelClicked
//
//  Created by Rey on 2018/5/24.
//  Copyright © 2018年 Rey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTLabel : UILabel
@property (nonatomic,copy) void(^linkTapHandle)(QTLabel *label, NSString *selectStr, NSRange range);//链接回调Blcock
@property (nonatomic,copy) void(^userTaphandle)(QTLabel *label, NSString *selectStr, NSRange range);//用户回调Block
@property (nonatomic,copy) void(^tapIndex)(NSInteger tapIndex);//链接回调Blcock

@property (nonatomic, strong) UIColor *attrStrColor;//设置特殊字符颜色，默认为蓝色
@property (nonatomic, strong) NSMutableArray *linkRanges;

@end

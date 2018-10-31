//
//  NSLable.m
//  Simbox
//
//  Created by Sun on 2018/7/11.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "NSLable.h"

@implementation NSLable

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.editable = NO;
    self.bordered = NO; //不显示边框
    self.backgroundColor = [NSColor clearColor]; //控件背景色
//    self.stringValue = @"";
    self.font = [NSFont fontWithName:@"PingFangSC-Regular" size:14];//文字字体、大小
//    self.font = [NSFont systemFontOfSize:14];   //文字大小
    self.textColor = [NSColor blackColor];      //文字颜色
    self.alignment = NSTextAlignmentLeft;       //水平显示方式
    
    self.maximumNumberOfLines = 1; //最多显示行数
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

@end

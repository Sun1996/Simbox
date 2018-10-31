//
//  DepartmentTableCell.m
//  Simbox
//
//  Created by Sun on 2018/7/6.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "DepartmentTableCell.h"
#import <QuartzCore/QuartzCore.h>

#import "Masonry.h"
#import "UIColor+Extensions.h"
#import "NSLable.h"

@interface DepartmentTableCell ()
@property(nonatomic,strong) NSLable        *lable;
@property(nonatomic,strong) CATextLayer     *title;

@end

@implementation DepartmentTableCell

-(instancetype)init{
    self = [super init];
    
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor clearColor].CGColor;
    
//    [self.layer addSublayer:self.title];
    [self addSubview:self.lable];
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

}


#pragma mark - Setter and Getter
-(void)setName:(NSString *)name{
    _lable.stringValue = name;
//    _title.string = name;
}

-(CALayer *)title{
    if (!_title) {
        _title = [CATextLayer layer];
        _title.frame = CGRectMake(0, 6, 148, 28);
        _title.cornerRadius = 6;
        _title.backgroundColor = [NSColor redColor].CGColor;
//        _title.string = @"楼宇事业部";
        _title.font = (__bridge CFTypeRef)([NSFont fontWithName:@"PingFangSC-Medium" size:14]);
        _title.fontSize = 14.0f;
//        _title.alignmentMode = kCAAlignmentLeft;                       //字体的对齐方式
        _title.contentsGravity = kCAGravityCenter;
        _title.foregroundColor =[NSColor colorWithHexString:@"0x50545D"].CGColor;              //字体的颜色
        _title.wrapped = YES;                        //设置文字是不是只限制在frame中
        _title.contentsScale = 2.0;                    //2不模糊
    }
    return _title;
}

-(NSLable *)lable{
    if (!_lable) {
        _lable = [[NSLable alloc]init];
        _lable.frame = CGRectMake(10, 6, 130, 28);
        _lable.backgroundColor = [NSColor clearColor]; //控件背景色
        _lable.font = [NSFont fontWithName:@"PingFangSC-Medium" size:14];
        _lable.textColor = [NSColor colorWithHexString:@"0x50545D"];
        
    }
    return _lable;
}


@end

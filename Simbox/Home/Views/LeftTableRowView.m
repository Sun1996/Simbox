//
//  LeftTableRowView.m
//  Simbox
//
//  Created by Sun on 2018/7/9.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "LeftTableRowView.h"
#import "UIColor+Extensions.h"

@implementation LeftTableRowView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
}

-(void)drawSelectionInRect:(NSRect)dirtyRect{
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        NSRect selectionRect = NSInsetRect(self.bounds, 5 , 5);
        
        [[NSColor colorWithWhite:0.9 alpha:1] setStroke];  //设置边框颜色
        [[NSColor redColor] setFill];
//        [[NSColor colorWithHexString:@"0x18191a" alpha:0.03] setFill];  //设置填充背景颜色
        
        NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:5.f yRadius:5.f];
        [path fill];
//        [path stroke];
    }
}


@end

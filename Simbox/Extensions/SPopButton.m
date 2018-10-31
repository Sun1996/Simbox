//
//  SPopButton.m
//  Simbox
//
//  Created by 孙一峰 on 2018/7/14.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "SPopButton.h"
#import "Masonry.h"

@interface SPopButton()

@property (nonatomic, strong) NSImageView *imageView;

@end

@implementation SPopButton

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if (self.backgroundNormalColor) {
        [self.backgroundNormalColor set];
        NSRectFill(self.bounds);
    }
    
    if (self.normalColor != nil) {
        NSColor *color =self.normalColor ? self.normalColor : [NSColor blackColor];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
        [paraStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
        [paraStyle setAlignment:NSTextAlignmentLeft];

        //[paraStyle setLineBreakMode:NSLineBreakByTruncatingTail];

        NSDictionary *attrButton = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Verdana"size:14],NSFontAttributeName, color,NSForegroundColorAttributeName, paraStyle,NSParagraphStyleAttributeName,nil];
        NSAttributedString *btnString = [[NSAttributedString alloc]initWithString:self.title attributes:attrButton];
        [btnString drawInRect:NSMakeRect(12,7,self.frame.size.width - 50,self.frame.size.height)];
    }
}

-(void)initUI{
    
    [self addSubview:self.imageView];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.height.equalTo(self);
        make.width.equalTo(@40);
    }];
}


-(NSImageView *)imageView{
    if (!_imageView) {
        _imageView = [[NSImageView alloc]init];

        _imageView.wantsLayer = YES;
        _imageView.layer.backgroundColor = [NSColor clearColor].CGColor;
        
        _imageView.image = [NSImage imageNamed:@"icon_32_jiantou_down"];
        _imageView.imageAlignment = NSImageAlignCenter;

    }
    return _imageView;
}

-(void)setRightImage:(NSImage *)rightImage{
    self.imageView.image = rightImage;
}
@end

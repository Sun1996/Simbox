//
//  NSBaseButton.m
//  Simbox
//
//  Created by Sun on 2018/7/11.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "NSBaseButton.h"

@interface NSBaseButton ()

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL hover;
@property (nonatomic, assign) BOOL mouseUp;

@property (nonatomic, strong) NSTrackingArea *trackingArea;

@end

@implementation NSBaseButton

- (void)viewWillMoveToSuperview:(NSView *)newSuperview {
    
    [super viewWillMoveToSuperview:newSuperview];
    [self updateButtonApperaceWithState:self.buttonState];
}

-(void)updateTrackingAreas{
    [super updateTrackingAreas];
    if(self.trackingArea) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }
    NSTrackingAreaOptions options = NSTrackingInVisibleRect|NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways;
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:CGRectZero options:options owner:self userInfo:nil];
    
    [self addTrackingArea:self.trackingArea];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if (self.backgroundColor) {
        [self.backgroundColor set];
        NSRectFill(self.bounds);
    }
    
    if (self.title != nil) {
        NSColor *color =self.titleColor ? self.titleColor : [NSColor blackColor];
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
        
        [paraStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
        
        [paraStyle setAlignment:NSTextAlignmentCenter];
        
        //[paraStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        
        NSDictionary *attrButton = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Verdana"size:14],NSFontAttributeName, color,NSForegroundColorAttributeName, paraStyle,NSParagraphStyleAttributeName,nil];
        
        NSAttributedString *btnString = [[NSAttributedString alloc]initWithString:self.title attributes:attrButton];
        
        [btnString drawInRect:NSMakeRect(0,0,self.frame.size.width,self.frame.size.height)];
    }
}

- (void)mouseEntered:(NSEvent *)event{
    
    self.hover = YES;
    if (!self.selected) {
        self.buttonState = AnswerButtonHoverState;
    }
}

-(void)mouseExited:(NSEvent *)event{
    self.hover = NO;
    if (!self.selected) {
        [self setButtonState:AnswerButtonNormalState];
    }
}

-(void)mouseDown:(NSEvent *)event{
    self.hover = YES;
    if (!self.selected) {
        [self setButtonState:AnswerButtonHighlightState];
    }
}

- (void)updateButtonApperaceWithState:(AnswerButtonState)state {
    CGFloat cornerRadius = 0.f;//圆角弧度
    CGFloat borderWidth = 0.f;//边框宽度
    NSColor *borderColor = nil;//边框颜色
    NSColor *themeColor = nil;//字体颜色
    NSColor *backgroundColor = nil;
    
    switch (state) {
        case AnswerButtonNormalState: {
//            cornerRadius = self.cornerNormalRadius;
//            borderWidth = self.borderNormalWidth;
            borderColor = [NSColor whiteColor];
            themeColor = [NSColor whiteColor];
            backgroundColor = self.backgroundColor;
//            if (self.normalImage != nil) {
//                self.defaultImage = self.normalImage;
//            }
            break;
        }
        case AnswerButtonHoverState: {
//            cornerRadius = self.cornerHoverRadius;
//            borderWidth = self.borderHoverWidth;
            borderColor = [NSColor redColor];
            themeColor = self.titleColor;
            backgroundColor = self.backgroundColor;
//            if (self.hoverImage != nil) {
//                self.defaultImage = self.hoverImage;
//            }
        }
            break;
        case AnswerButtonHighlightState: {
            borderColor = [NSColor yellowColor];
            themeColor = [NSColor yellowColor];
            backgroundColor = self.backgroundColor;
            break;
        }
        case AnswerButtonSelectedState: {
            
            break;
        }
    }
    
    [self setFontColor:themeColor];
    
    self.layer.borderColor = borderColor.CGColor;
    self.layer.backgroundColor = backgroundColor.CGColor;
}

- (void)setFontColor:(NSColor *)color {
    
    NSMutableAttributedString *colorTitle = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedTitle]];
    if (colorTitle.length == 0) {
        return;
    }
    NSDictionary *attributes = [colorTitle attributesAtIndex:0 effectiveRange:nil];
    if ( [attributes[NSForegroundColorAttributeName] isEqual:color]) {
        return;
    }
    NSRange titleRange = NSMakeRange(0, [colorTitle length]);
    [colorTitle addAttribute:NSForegroundColorAttributeName value:color range:titleRange];
    [self setAttributedTitle:colorTitle];
}

#pragma mark - Setter
- (void)setButtonState:(AnswerButtonState)state {
    
    if (_buttonState == state) {
        return;
    }
    _buttonState = state;
    self.selected = (state == AnswerButtonSelectedState);
    [self updateButtonApperaceWithState:state];
}

@end

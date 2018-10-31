//
//  NSBaseButton.m
//  SWST_MAC
//
//  Created by Sun on 2018/4/13.
//  Copyright © 2018年 cvte. All rights reserved.
//

#import "NSBaseButton.h"
#import "UIColor+Extensions.h"
#import "NSLable.h"

@interface NSBaseButton ()

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL hover;
@property (nonatomic, assign) BOOL mouseUp;

@property (nonatomic, strong) NSTrackingArea *trackingArea;
@property (nonatomic, strong) NSImage *defaultImage;

@end

@implementation NSBaseButton

- (instancetype)initWithFrame:(NSRect)frameRect {
    
    self = [super initWithFrame:frameRect];
    if (self) {
        [self commonInitialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInitialize];
    }
    return self;
}

- (void)viewWillMoveToSuperview:(NSView *)newSuperview {
    [super viewWillMoveToSuperview:newSuperview];
    
    [self otherInitialize];
    [self updateButtonApperaceWithState:self.buttonState];
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    
    if(self.trackingArea) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }
    NSTrackingAreaOptions options = NSTrackingInVisibleRect|NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways;
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:CGRectZero options:options owner:self userInfo:nil];
    
    [self addTrackingArea:self.trackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    
    self.hover = YES;
    if (!self.selected && self.canHover) {
        self.buttonState = NSBaseButtonHoverState;
        
//        NSPoint point = [NSEvent mouseLocation];
//        NSLable *lable = [[NSLable alloc]initWithFrame:NSMakeRect(point.x + 20, point.y, 40, 25)];
////        NSLog(@"%f---%f",self.frame.origin.x, self.frame.origin.y);
//        NSLog(@"%f---%f",point.x, point.y);
//        lable.stringValue = @"提示";
//        [self.window.contentView addSubview:lable];
    }
}

- (void)mouseExited:(NSEvent *)theEvent {
    
    self.hover = NO;
    if (!self.selected) {
        [self setButtonState:NSBaseButtonNormalState];
    }
}

- (void)mouseDown:(NSEvent *)event {
    
    self.mouseUp = NO;
    if (self.enabled && !self.selected) {
        self.buttonState = NSBaseButtonHighlightState;
    }
}

- (void)mouseUp:(NSEvent *)event {
    
    self.mouseUp = YES;
    if (self.enabled) {
        if (self.canSelected && self.hover) {
            self.selected = !self.selected;
            self.buttonState = self.selected ? NSBaseButtonSelectedState : NSBaseButtonNormalState;
        } else {
            if (!self.selected) {
                self.buttonState = NSBaseButtonNormalState;
            }
        }
        if (self.hover && self.enabled) {
            NSString *selString = NSStringFromSelector(self.action);
            if ([selString hasSuffix:@":"]) {
                [self.target performSelector:self.action withObject:self afterDelay:0.f];
            } else {
                [self.target performSelector:self.action withObject:nil afterDelay:0.f];
            }
        }
    }
}

#pragma mark - Private Methods

- (void)commonInitialize {
    self.cornerNormalRadius = (!_cornerNormalRadius) ? 2.f : _cornerNormalRadius;

    self.borderNormalWidth = (_borderNormalWidth == 0.f) ? 1.f : _borderNormalWidth;

    self.borderNormalColor = (!_borderNormalColor) ? [NSColor colorWithHexString:@"0xD8D8D8"] : _borderNormalColor;

    self.normalColor = (!_normalColor) ? [NSColor colorWithHexString:@"0x18191A" alpha:0.7] : _normalColor;

    self.backgroundNormalColor = (!_backgroundNormalColor) ? [NSColor clearColor] : _backgroundNormalColor;
    
    
    self.hasBorder = YES;
    [self initializeUI];
}
- (void)otherInitialize {
    self.cornerHoverRadius = (!_cornerHoverRadius ) ? _cornerNormalRadius : _cornerHoverRadius;
    self.cornerHighlightRadius = (!_cornerHighlightRadius) ? _cornerNormalRadius : _cornerHighlightRadius;
    self.cornerSelectedRadius = (!_cornerSelectedRadius) ? _cornerNormalRadius : _cornerSelectedRadius;
    
    self.borderHoverWidth = (_borderHoverWidth == 0.f) ? self.borderNormalWidth : _borderHoverWidth;
    self.borderHighlightWidth = (_borderHighlightWidth == 0.f) ? self.borderNormalWidth : _borderHighlightWidth;
    self.borderSelectedWidth = (_borderSelectedWidth == 0.f) ? self.borderNormalWidth : _borderSelectedWidth;
    
    self.borderHoverColor = (!_borderHoverColor) ? _borderNormalColor : _borderHoverColor;
    self.borderHighlightColor = (!_borderHighlightColor) ? _borderNormalColor : _borderHighlightColor;
    self.borderSelectedColor = (!_borderSelectedColor ) ? _borderNormalColor : _borderSelectedColor;
    
    self.hoverColor = (!_hoverColor) ? _normalColor : _hoverColor;
    self.highlightColor = (!_highlightColor) ? _normalColor : _highlightColor;
    self.selectedColor = (!_selectedColor) ? _normalColor : _selectedColor;
    
    
    self.backgroundHoverColor = (!_backgroundHoverColor) ? _backgroundNormalColor : _backgroundHoverColor;
    self.backgroundHighlightColor = (!_backgroundHighlightColor) ? _backgroundNormalColor : _backgroundHighlightColor;
    self.backgroundSelectedColor = (!_backgroundSelectedColor) ? _backgroundNormalColor : _backgroundSelectedColor;
}


- (void)initializeUI {
    self.wantsLayer = YES;
    [self setButtonType:NSButtonTypeMomentaryPushIn];
    self.bezelStyle = NSBezelStyleTexturedSquare;
    self.bordered = NO;
    self.font = [NSFont systemFontOfSize:14];
    [self setFontColor:self.normalColor];
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

- (void)updateButtonApperaceWithState:(NSBaseButtonState)state {
    CGFloat cornerRadius = self.cornerNormalRadius;
    CGFloat borderWidth = self.borderNormalWidth;
    NSColor *borderColor = self.borderNormalColor;
    NSColor *themeColor = self.normalColor;
    NSColor *backgroundColor = self.backgroundNormalColor;
    switch (state) {
        case NSBaseButtonNormalState: {
            cornerRadius = self.cornerNormalRadius;
            borderWidth = self.borderNormalWidth;
            borderColor = self.borderNormalColor;
            themeColor = self.normalColor;
            backgroundColor = self.backgroundNormalColor;
            if (self.normalImage != nil) {
                self.defaultImage = self.normalImage;
            }
            break;
        }
        case NSBaseButtonHoverState: {
            cornerRadius = (!self.cornerHoverRadius) ? self.cornerNormalRadius : self.cornerHoverRadius;
            borderWidth = self.borderHoverWidth;
            borderColor = self.borderHoverColor;
            themeColor = self.hoverColor;
            backgroundColor = self.backgroundHoverColor;
            if (self.hoverImage != nil) {
                self.defaultImage = self.hoverImage;
            }
        }
            break;
        case NSBaseButtonHighlightState: {
            cornerRadius = (!self.cornerHighlightRadius) ? self.cornerNormalRadius : self.cornerHighlightRadius;
            borderWidth = self.borderHighlightWidth;
            borderColor = self.borderHighlightColor;
            themeColor = self.highlightColor;
            backgroundColor = self.backgroundHighlightColor;
            if (self.highlightImage != nil) {
                self.defaultImage = self.highlightImage;
            }
        }
            break;
        case NSBaseButtonSelectedState: {
            cornerRadius = (!self.cornerSelectedRadius) ? self.cornerNormalRadius : self.cornerSelectedRadius;
            borderWidth = self.borderSelectedWidth;
            borderColor = self.borderSelectedColor;
            themeColor = self.selectedColor;
            backgroundColor = self.backgroundSelectedColor;
            if (self.selectedImage != nil) {
                self.defaultImage = self.selectedImage;
            }
        }
            break;
    }
    if (self.defaultImage != nil) {
        self.image = self.defaultImage;
    }
    [self setFontColor:themeColor];
    
    if (self.hasBorder) {
        if (cornerRadius) {
            self.layer.cornerRadius = cornerRadius;
            self.layer.borderWidth = borderWidth;
            self.layer.borderColor = borderColor.CGColor;
        }
    } else {
        self.layer.cornerRadius = 0.f;
        self.layer.borderWidth = 0.f;
        self.layer.borderColor = [NSColor clearColor].CGColor;
    }
    self.layer.backgroundColor = backgroundColor.CGColor;
}

#pragma mark - Setter

- (void)setCanSelected:(BOOL)canSelected {
    
    _canSelected = canSelected;
    [self updateButtonApperaceWithState:self.buttonState];
}

- (void)setHasBorder:(BOOL)hasBorder {
    
    _hasBorder = hasBorder;
    [self updateButtonApperaceWithState:self.buttonState];
}

-(void)setCanHover:(BOOL)canHover{
    _canHover = canHover;
    [self updateButtonApperaceWithState:self.buttonState];
}

- (void)setButtonState:(NSBaseButtonState)state {
    if (_buttonState == state) {
        return;
    }
    _buttonState = state;
    self.selected = (state == NSBaseButtonSelectedState);
    [self updateButtonApperaceWithState:state];
}

- (void)setTitle:(NSString *)title {
    
    [super setTitle:title];
    [self setFontColor:self.normalColor];
}

@end

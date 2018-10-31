//
//  NSBaseButton.h
//  Simbox
//
//  Created by Sun on 2018/7/11.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, AnswerButtonState) {
    AnswerButtonNormalState      = 0,
    AnswerButtonHoverState       = 1,
    AnswerButtonHighlightState   = 2,
    AnswerButtonSelectedState    = 3
};

@interface NSBaseButton : NSButton

@property (nonatomic,strong) NSColor *backgroundColor;
@property (nonatomic,strong) NSColor *titleColor;

@property (nonatomic, assign) AnswerButtonState buttonState;

@end

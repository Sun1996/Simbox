//
//  UIColor+Extensions.m
//  SmartEasyStore
//
//  Created by westke on 16/3/9.
//  Copyright © 2016年 hikvision. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation NSColor (Extensions)

+ (NSColor *)colorWithHexString:(NSString *)hexString {
    NSAssert(hexString.length > 0, @"hexString cannot be nil");
    return [self colorWithHexString:hexString alpha:1.0];
}

+ (NSColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSAssert(hexString.length > 0, @"hexString cannot be nil");
    if ([hexString hasPrefix:@"#"]) {
        hexString = [NSString stringWithFormat:@"0x%@", [hexString substringFromIndex:1]];
    }
    return [NSColor colorWithRed:((float)((strtol([hexString UTF8String], 0, 16) & 0xFF0000) >> 16))/255.0 green:((float)((strtol([hexString UTF8String], 0, 16) & 0xFF00) >> 8))/255.0 blue:((float)(strtol([hexString UTF8String], 0, 16) & 0xFF))/255.0 alpha:alpha];
}

+ (NSColor *)defaultBackgroundColor {
   return [self colorWithHexString:@"0xF5F5F5" alpha:1.0];
}

@end

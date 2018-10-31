//
//  UIColor+Extensions.h
//  SmartEasyStore
//
//  Created by westke on 16/3/9.
//  Copyright © 2016年 hikvision. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (Extensions)

/**
 * 根据十六进制数字来获取颜色
 */
+ (NSColor *)colorWithHexString:(NSString *)hexString;
/**
 * 根据十六进制数字来获取颜色，并且可以指定alpha通道
 */
+ (NSColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
/**
 * 连锁的默认背景色
 */
+ (NSColor *)defaultBackgroundColor;

@end

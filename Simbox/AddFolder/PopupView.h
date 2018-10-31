//
//  PopupView.h
//  Simbox
//
//  Created by 孙一峰 on 2018/8/8.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DepartmentData.h"

@interface PopupView : NSView

@property (nonatomic, strong) DepartmentData      *dept;           // 部门

@end

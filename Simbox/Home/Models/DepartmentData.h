//
//  DepartmentData.h
//  HikPlugin
//
//  Created by Sun on 2018/6/1.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DepartmentData : NSObject

@property (nonatomic, assign) NSUInteger    departmentID;       // 部门的id
@property (nonatomic, strong) NSString      *name;              // 部门的名称
@property (nonatomic, strong) NSString      *parentID;          // 部门的父节点
@property (nonatomic, strong) NSString      *creator;           // 创建人
@property (nonatomic, strong) NSImage       *thumbImage;          // 缩略图

- (instancetype)initWithDepartmentID:(NSUInteger)departmentID name:(NSString *)name parentID:(NSString *)parentID creator:(NSString *)creator thumbImage:(NSImage *)thumbImage;

@end

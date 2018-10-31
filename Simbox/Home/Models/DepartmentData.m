//
//  DepartmentData.m
//  HikPlugin
//
//  Created by Sun on 2018/6/1.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "DepartmentData.h"

@implementation DepartmentData

- (instancetype)initWithDepartmentID:(NSUInteger)departmentID name:(NSString *)name parentID:(NSString *)parentID creator:(NSString *)creator thumbImage:(NSImage *)thumbImage{
    if (self = [super init]) {
        self.departmentID = departmentID;
        self.name = name;
        self.parentID = parentID;
        self.creator = creator;
        self.thumbImage = thumbImage;
    }
    return self;
}

@end

//
//  DetailInfoResult.h
//  Simbox
//
//  Created by Sun on 2018/7/9.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailInfoResult : NSObject

@property (nonatomic, copy) NSString        *nodeId;
@property (nonatomic, copy) NSString        *nodeName;
@property (nonatomic, copy) NSString        *parentId;
@property (nonatomic, strong) NSString      *creator;           // 创建人
@property (nonatomic, strong) NSString      *createTime;        // 创建时间
@property (nonatomic, assign) NSInteger     type;
@property (nonatomic, copy) NSString        *filePath;
@property (nonatomic, strong) NSArray    *leafArray;

@property (nonatomic, assign) BOOL        isNew;

@end

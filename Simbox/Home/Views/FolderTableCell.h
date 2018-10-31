//
//  FolderTableCell.h
//  Simbox
//
//  Created by Sun on 2018/7/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DetailInfoResult.h"

@interface FolderTableCell : NSView

@property (nonatomic, strong) DetailInfoResult      *data;
@property (nonatomic, strong) NSString      *name;
@property (nonatomic, assign) NSInteger     type;
@property (nonatomic, strong) NSString      *createTime;        // 创建时间
@property (nonatomic, strong) NSString      *creator;           // 创建人
@property (nonatomic, assign) BOOL          isUpdate;           // 是否已更新

@end

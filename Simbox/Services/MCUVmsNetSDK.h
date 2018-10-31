//
//  MCUVmsNetSDK.h
//  HikPlugin
//
//  Created by Sun on 2018/4/26.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MCUVmsNetSDK : NSObject

+ (MCUVmsNetSDK*)shareInstance;

/**
 *  获取事业部列表
 */
- (void)getDaptWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *json))success failure:(void (^)(NSError *error))failure;

/**
 *  获取文件列表
 */
- (void)getFileWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *json))success failure:(void (^)(NSError *error))failure;
/**
 *  获取文件夹层级列表
 */
- (void)getDirListWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *json))success failure:(void (^)(NSError *error))failure;

/**
 *  上传
 */
- (void)uploadWithPath:(NSString *)pathUrl params:(NSDictionary *)params success:(void (^)(NSDictionary *json))success failure:(void (^)(NSError *error))failure;

/**
 *  下载
 */
- (void)downloadWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *json))success failure:(void (^)(NSError *error))failure;
@end

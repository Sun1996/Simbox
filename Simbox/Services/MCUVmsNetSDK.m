//
//  MCUVmsNetSDK.m
//  HikPlugin
//
//  Created by Sun on 2018/4/26.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "MCUVmsNetSDK.h"
#import "AFNetworking.h"

@implementation MCUVmsNetSDK

+ (MCUVmsNetSDK*)shareInstance{
    
    static dispatch_once_t once = 0;
    static MCUVmsNetSDK *vmsNetSDK = nil;
    dispatch_once(&once,^{
        vmsNetSDK = [[self alloc]init];
    });
    
    return vmsNetSDK;
}

- (void)getDaptWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *json))success failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://10.11.65.43:8082/api/dept/list" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        //进度回调
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"获取事业部列表成功.");
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取事业部列表失败.%@",error);
        failure(error);
    }];
}

- (void)getFileWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *json))success failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://10.11.65.43:8082/api/file/list" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        //进度回调
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"获取文件列表成功.");
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取文件列表失败.%@",error);
        failure(error);
    }];
}

- (void)getDirListWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *json))success failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://10.11.65.43:8082/api/file/dirList" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        //进度回调
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"获取文件夹层级列表成功.");
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取文件夹层级列表失败.%@",error);
        failure(error);
    }];
}



- (void)uploadWithPath:(NSString *)pathUrl params:(NSDictionary *)params success:(void (^)(NSDictionary *json))success failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:@"http://10.11.65.43:8082/api/file/upload" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:pathUrl] name:@"file" fileName:@"xxx.sketch" mimeType:@"sketch" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //进度回调
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功.");
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败.%@",error);
        failure(error);
    }];
    
}

- (void)downloadWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *json))success failure:(void (^)(NSError *error))failure{
    
    
}

@end

//
//  SuSNetwork.h
//  SuS
//
//  Created by HZwu on 14-11-29.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFHTTPRequestOperationManager.h"
#import <AFNetworking/AFNetworking.h>
#import "ZWConstant.h"

@interface NetworkClient : NSObject

//+ (instancetype)client;

//- (AFHTTPRequestOperation*)request:(NSString*)method
//                               url:(NSString*)url
//                        parameters:(NSDictionary *)parameters
//                       cachePolicy:(NSURLRequestCachePolicy)cachePolicy
//                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//- (AFHTTPRequestOperation *)requestGetByParamsString:(NSString *)paramsString
//                                          parameters:(NSDictionary *)parameters
//                                         cachePolicy:(NSURLRequestCachePolicy)cachePolicy
//                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//- (AFHTTPRequestOperation *)requestPostByParamsString:(NSString *)paramsString
//                                           parameters:(NSDictionary *)parameters
//                                          cachePolicy:(NSURLRequestCachePolicy)cachePolicy
//                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//
//- (AFHTTPRequestOperation *)requestDeleteByParamsString:(NSString *)paramsString
//                                           parameters:(NSDictionary *)parameters
//                                          cachePolicy:(NSURLRequestCachePolicy)cachePolicy
//                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+ (nullable NSURLSessionDataTask *)requestGetByUrlString:(NSString * _Nullable)urlString
                        parameters:(NSDictionary * _Nullable)parameters
                            success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable))success
                            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

+ (nullable NSURLSessionDataTask *)requestDeleteByUrlString:(nullable NSString *)urlString
                        parameters:(NSDictionary * _Nullable)parameters
                            success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable))success
                            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

+ (nullable NSURLSessionDataTask *)requestPostByUrlString:(NSString * _Nullable)urlString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

@end

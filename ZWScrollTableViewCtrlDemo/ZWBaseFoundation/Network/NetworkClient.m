//
//  SuSNetwork.m
//  SuS
//
//  Created by HZwu on 14-11-29.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import "NetworkClient.h"
#import "NSString+ThreeDES.h"
#import "NSString+MD5Encrypt.h"
#import "RSAEncryptor.h"

@implementation NetworkClient

//+ (instancetype)client
//{
//    static NetworkClient *_sharedClient = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedClient = [[self alloc] init];
//    });
//    
//    return _sharedClient;
//}

//- (instancetype)init
//{
//    self = [super init];
//    if(self) {
//        self.requestSerializer = [AFJSONRequestSerializer serializer];
//        self.responseSerializer = [AFJSONResponseSerializer serializer];
//    }
//    return self;
//}

#pragma mark 通用网络请求接口
//- (AFHTTPRequestOperation *)request:(NSString*)method
//                                url:(NSString*)url
//                         parameters:(NSDictionary *)parameters
//                        cachePolicy:(NSURLRequestCachePolicy)cachePolicy
//                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//    NSMutableURLRequest *request =
//    [self.requestSerializer requestWithMethod:method
//                                    URLString:url
//                                   parameters:parameters
//                                        error:nil];
//    request.cachePolicy = cachePolicy;
//    
//    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
//    [self.operationQueue addOperation:operation];
//    
//    return operation;
//    
//    NSError *error;
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer requestWithMethod:method URLString:url parameters:parameters error:&error];
//}

#pragma mark 网络请求GET类方法
+ (nullable NSURLSessionDataTask *)requestGetByUrlString:(NSString * _Nullable)urlString
                            parameters:(NSDictionary * _Nullable)parameters
                            success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable))success
                            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    manager.requestSerializer.timeoutInterval = 60.0; // 超时请求，默认60秒
    
    return [manager GET:[[NSString stringWithFormat:@"%@%@", kMainAPIDomain, urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil progress:nil success:success failure:failure];
}

#pragma mark 网络请求DELETE类方法
+ (nullable NSURLSessionDataTask *)requestDeleteByUrlString:(nullable NSString *)urlString
                            parameters:(NSDictionary * _Nullable)parameters
                            success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable))success
                            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    manager.requestSerializer.timeoutInterval = 60.0; // 超时请求，默认60秒
    
    return [manager DELETE:[[NSString stringWithFormat:@"%@%@", kMainAPIDomain, urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:success failure:failure];
}

#pragma mark 当前时间戳 des3加密
NSString* tokenDes() {
    NSDate *today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:today];
    NSDate *localeDate = [today dateByAddingTimeInterval:interval];
    // 时间转换成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)[localeDate timeIntervalSince1970] * 1000];
    NSString *token = [NSString threeDesEncrypt:timeSp];
//    NSLog(@"timeSp : %@", timeSp);
//    NSLog(@"timeSp 3DES : %@", token);
    
    return token;
}

#pragma mark 将所有未加密参数键进行根据首字母排序，然后按 mkey = (参数键=参数值DES3)加密，(参数值=参数键)DES3加密，.....
NSString* compareKey(NSMutableDictionary *parameters) {
    // 取出所有key
    NSArray *keys = parameters.allKeys;
    // 重新排序
    NSArray *compareKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
    
    NSInteger i = 1;
    NSString *value;
    NSString *valueString;
    // 最后需要MD5加密的字符串
    NSMutableString *contentString = [NSMutableString string];
    
//    RSAEncryptor *rsaEncryptor = [RSAEncryptor rsa];
    
    for (NSString *key in compareKeys) {
        if ([key isEqualToString:@"mKey"]) continue;
        
        NSString *keyString;
        NSString *str = [NSString stringWithFormat:@"%@", parameters[key]];
        // key带"#"表示该参数值不需要进行RSA加密
        if ([key rangeOfString:@"#"].location == NSNotFound) {
            keyString = key;
            value = str; // [rsaEncryptor rsaEncryptString:str];
            
        } else {
            // 去掉末尾的"#"
            keyString = [key substringToIndex:key.length - 1];
            value = str;
            
            // 删除原本带有"#"的参数键和参数值
            [parameters removeObjectForKey:key];
        }
        
        // 更新或添加参数键和参数值
        [parameters setObject:value forKey:keyString];
        
        if (i % 2 == 0) {
            valueString = [NSString stringWithFormat:@",%@=%@", value, keyString];
        } else if (i == 1) {
            valueString = [NSString stringWithFormat:@"%@=%@", keyString, value];
        } else {
            valueString = [NSString stringWithFormat:@",%@=%@", keyString, value];
        }
        
        i++;
        
        [contentString appendString:[valueString threeDesEncrypt]];
//        [contentString appendString:valueString];
    }
    
    return [contentString md5Encrypt_32Bit];
}

#pragma mark 网络请求POST类方法
+ (nullable NSURLSessionDataTask *)requestPostByUrlString:(NSString * _Nullable)urlString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    manager.requestSerializer.timeoutInterval = 60.0; // 超时请求，默认60秒
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    // port：端口参数；port 1安卓 2苹果
//    [dict setObject:@"2" forKey:@"port#"]; // 加密情况下使用
    [dict setObject:@"2" forKey:@"port"];
    
//    // token：时间戳
//    NSString *token = tokenDes();
//    [dict setObject:token forKey:@"token#"];
//    
//    // mKey：参数值和参数键加密
//    NSString *mKey = compareKey(dict);
////    NSLog(@"mKey : %@", mKey);
//    [dict setObject:mKey forKey:@"mKey"];
    
    return [manager POST:[[NSString stringWithFormat:@"%@%@", kMainAPIDomain, urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:dict progress:uploadProgress success:success failure:failure];
}

@end

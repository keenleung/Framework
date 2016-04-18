//
//  YYHttpTool.h
//网络请求工具类，负责整个项目中所有的Http网络请求

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface YYHttpTool : NSObject
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 *
 *  @return NSURLSessionDataTask对象
 */
+ (NSURLSessionDataTask *)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  上传本地文件
 *
 *  @param url      请求路径
 *  @param params   请求参数
 *  @param filePath 上传文件路径
 *  @param progress 上传进度,completedUnitCount:已经上传的字节数;totalUnitCount:总共要上传的字节数
 *  @param success  请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure  请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 *
 *  @return NSURLSessionDataTask对象
 */
+(NSURLSessionDataTask *)upload:(NSString *)url params:(NSDictionary *)params filePath:(NSString *)filePath progress:(void(^)(NSInteger completedUnitCount,NSInteger totalUnitCount))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
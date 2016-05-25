//
//  YYHttpTool.m
//

#import "YYHttpTool.h"
#import <AFNetworking.h>


@implementation YYHttpTool
+(void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.发送Get请求
    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(NSURLSessionDataTask *)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    
    //    NSSet *set = manager.responseSerializer.acceptableContentTypes;
    //    NSMutableSet *setM = [NSMutableSet setWithSet:set];
    //    [setM addObject:@"text/plain"];
    //    AFHTTPResponseSerializer *responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    //    responseSerializer.acceptableContentTypes = setM;
    //    manager.responseSerializer = responseSerializer;
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    return dataTask;
}


+(NSURLSessionDataTask *)uploadWithURL:(NSString *)url params:(NSDictionary *)params filePath:(NSString *)filePath progress:(void(^)(NSInteger completedUnitCount,NSInteger totalUnitCount))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //NSURL *fileUrl = [NSURL fileURLWithPath:@"/Users/apple/Desktop/300-2.jpeg"];
        //FileURL:要上传的文件的URL路径
        //[formData appendPartWithFileURL:fileUrl name:@"file" fileName:@"1233.png" mimeType:@"image/png" error:nil];
        
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        
        //该方法是简单版本,该方法内部会自动的得到文件的名称以及文件的类型
        [formData appendPartWithFileURL:fileUrl name:@"file" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    NSURLSessionDataTask *dataTask;
    
    
    return dataTask;
}

@end
//
//  PhotoTool.m
//  Framework
//
//  Created by Apple on 16/4/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "PhotoTool.h"

#import <SVProgressHUD.h>
// 系统框架 Photos
#import <Photos/Photos.h>
// 第三方框架 CTAssetsPickerController
#import <CTAssetsPickerController/CTAssetsPickerController.h>

#pragma mark ---------- 宏 ----------------

/**
 *  延迟执行时间
 */
#define TIME_DELAY 0.1

/**
 *  单张图片
 */
typedef void (^PickerPicture)(UIImage *image);

/**
 *  多张图片
 */
typedef void (^PickerPictures)(NSArray<UIImage *> *images);

#pragma mark ----------- @interface ---------------

@interface PhotoTool()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate,CTAssetsPickerControllerDelegate>

@property(nonatomic, strong) UIImage *image;

// 选取单张图片后要执行的操作
@property(nonatomic, strong) PickerPicture completion;

// 选取多张图片后要执行的操作
@property(nonatomic, strong) PickerPictures completions;

// 最多选取多少张图片
@property(nonatomic, assign) NSInteger maxCount;

@end

@implementation PhotoTool

#pragma mark ---------- 单例 ----------------

+(instancetype)sharePhotoTool{
    PhotoTool *instance = [[PhotoTool alloc] init];
    return instance;
}
static  PhotoTool *_instance = nil;
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

#pragma mark ---------- 保存图片到应用程序图片目录 ----------------

/**
 *  获得刚才添加到【相机胶卷】中的图片
 */
- (PHFetchResult<PHAsset *> *)createdAssets{
    __block NSString *createdAssetId = nil;
    
    // 添加图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdAssetId = [PHAssetChangeRequest creationRequestForAssetFromImage:self.image].placeholderForCreatedAsset.localIdentifier;
    } error:nil];
    
    if (createdAssetId == nil) return nil;
    
    // 在保存完毕后取出图片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[createdAssetId] options:nil];
}

/**
 *  获得【自定义相册】
 */
- (PHAssetCollection *)createdCollection{
    // 获取软件的名字作为相册的标题
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    // 获得所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    // 代码执行到这里，说明还没有自定义相册
    
    __block NSString *createdCollectionId = nil;
    
    // 创建一个新的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    if (createdCollectionId == nil) return nil;
    
    // 创建完毕后再取出相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionId] options:nil].firstObject;
}

/**
 *  保存图片到相册
 */
- (void)saveImageIntoAlbum{
    // 获得相片
    PHFetchResult<PHAsset *> *createdAssets = [self createdAssets];
    
    // 获得相册
    PHAssetCollection *createdCollection = [self createdCollection];
    
    if (createdAssets == nil || createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
        return;
    }
    
    // 将相片添加到相册
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    // 保存结果
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}

/**
 *  保存图片到应用程序图片目录
 */
+ (void) savePhotoToAppAlbum: (UIImage *)image{
    
    PhotoTool *tool = [self sharePhotoTool];
    tool.image = image;
    
    /*
     requestAuthorization方法的功能
     1.如果用户还没有做过选择，这个方法就会弹框让用户做出选择
     1> 用户做出选择以后才会回调block
     
     2.如果用户之前已经做过选择，这个方法就不会再弹框，直接回调block，传递现在的授权状态给block
     */
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusAuthorized: {
                //  保存图片到相册
                [tool saveImageIntoAlbum];
                break;
            }
                
            case PHAuthorizationStatusDenied: {
                if (oldStatus == PHAuthorizationStatusNotDetermined) return;
                
                // 刷新 UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提醒" message:@"请打开应用访问开关:设置->隐私->照片" preferredStyle:UIAlertControllerStyleAlert];
                    [alertVC addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
                    
                });
                
                
                break;
            }
                
            case PHAuthorizationStatusRestricted: {
                [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
                break;
            }
                
            default:
                break;
        }
    }];
}



#pragma mark --------- 获取单张照片 -----------------

+ (void)takePictureWithCompletion: (PickerPicture)completion{
    
    // 直接返回，不做任何操作
    if (completion == nil) {
        return;
    }
    
    PhotoTool *tool = [self sharePhotoTool];
    
    tool.completion = completion;
    
    [tool pickerPicture];
}

/**
 *  选取单张图片
 */
- (void)pickerPicture{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - <UIImagePickerControllerDelegate>

/**
 *  已经完成选择
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 关闭选择图片界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 选取的照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    PhotoTool *tool = [PhotoTool sharePhotoTool];
    
    if (tool.completion) {
        tool.completion(image);
    }
}

/**
 * 点击了Cancel
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    // 关闭选择图片界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ---------- 获取多张照片 ----------------

+(void) takePicturesWithCompletion:(PickerPictures)completion{
    
    [self takePicturesWithMaxCount:0 showsSelectionIndex:NO completion:completion];
}

+ (void) takePicturesWithMaxCount:(NSInteger)maxCount showsSelectionIndex:(BOOL)showsSelectionIndex  completion:(PickerPictures)completion{
    
    if (completion == nil) {
        return;
    }
    
    PhotoTool *tool = [self sharePhotoTool];
    tool.completions = completion;
    tool.maxCount = maxCount;
    [tool pickerPicturesShouldShowSelectionIndex: showsSelectionIndex];
}

/**
 *  选取多张照片
 */
- (void) pickerPicturesShouldShowSelectionIndex:(BOOL)showsSelectionIndex {
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        
        switch (status) {
                
                // 允许
            case PHAuthorizationStatusAuthorized: {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                    picker.delegate = self;
                    // 显示选择的索引
                    picker.showsSelectionIndex = showsSelectionIndex;
                    // 设置相册的类型：相机胶卷 + 自定义相册
                    picker.assetCollectionSubtypes = @[
                                                       @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                                       @(PHAssetCollectionSubtypeAlbumRegular)];
                    // 不需要显示空的相册
                    picker.showsEmptyAlbums = NO;
                    
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
                });
                break;
            }
                
                // 不允许
            case PHAuthorizationStatusDenied: {
                if (oldStatus == PHAuthorizationStatusNotDetermined) return;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提醒" message:@"请打开应用访问开关:设置->隐私->照片" preferredStyle:UIAlertControllerStyleAlert];
                    [alertVC addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
                    
                });
                
                break;
            }
                
                // 锁定
            case PHAuthorizationStatusRestricted: {
                [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
                break;
            }
                
            default:
                break;
        }
        
    }];
}

#pragma mark - <CTAssetsPickerControllerDelegate>

/**
 *  是否可选
 */
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    
    PhotoTool *tool = [PhotoTool sharePhotoTool];
    NSInteger max = tool.maxCount;
    
    if (max > 0 && picker.selectedAssets.count >= max) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%zd张图片", max] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
        [picker presentViewController:alert animated:YES completion:nil];
        // 这里不能使用self来modal别的控制器，因为此时self.view不在window上
        return NO;
    }
    
    return YES;
}

/**
 *  选择完毕
 */
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray<PHAsset *> *)assets{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    PhotoTool *tool = [PhotoTool sharePhotoTool];
    
    // 基本配置
    CGFloat scale = [UIScreen mainScreen].scale;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    NSMutableArray *images = [NSMutableArray array];
    
    // 遍历选择的所有图片
    [assets enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger index, BOOL * _Nonnull stop) {
        
        CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);

        // 获取图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
            
            [images addObject:image];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(TIME_DELAY * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (index == assets.count - 1) {
                    
                    if (tool.completions) {
                        tool.completions(images);
                    }
                }
            });
            
        }];
        
        
    }];
    
}


@end

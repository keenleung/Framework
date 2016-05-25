//
//  UIImage+Extension.m
//  Tools
//
//  Created by Magic_Unique on 15/8/21.
//  Copyright (c) 2015年 Unique. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Scale)

- (CGSize)CGSize {
    return CGSizeMake(CGImageGetWidth(self.CGImage), CGImageGetHeight(self.CGImage));
}

+ (instancetype)imageWithImage:(UIImage *)image toNewSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGRect frame = CGRectZero;
    frame.size = size;
    [image drawInRect:frame];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)imageWithImage:(UIImage *)image toPercentScale:(NSUInteger)percentScale {
    CGSize size = image.size;
    size.width *= percentScale / 100.0;
    size.height *= percentScale / 100.0;
    return [self imageWithImage:image toNewSize:size];
}

+ (instancetype)imageWithImage:(UIImage *)image outOfCircumscribedSize:(CGSize)size {
    NSUInteger wScale = size.width / image.size.width * 100;
    NSUInteger hScale = size.height / image.size.height * 100;
    return [self imageWithImage:image toPercentScale:MAX(wScale, hScale)];
}

+ (instancetype)imageWithImage:(UIImage *)image inOfCircumscribedSize:(CGSize)size {
    NSUInteger wScale = size.width / image.size.width * 100;
    NSUInteger hScale = size.height / image.size.height * 100;
    return [self imageWithImage:image toPercentScale:MIN(wScale, hScale)];
}

@end


@implementation UIImage (Create)

+ (instancetype)imageWithColor:(UIColor *)color andSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    [color setFill];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, size.width, size.height), kCGBlendModeXOR);
    CGImageRef cgImageRef = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    
    UIGraphicsEndImageContext();
    return [UIImage imageWithCGImage:cgImageRef];
}

+ (instancetype)imageWithImage:(UIImage *)image mask:(UIImage *)mask option:(UIImageMaskOption)option {
    UIGraphicsBeginImageContextWithOptions(mask.CGSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectZero;
    rect.size = mask.CGSize;
    CGContextClipToMask(context, rect, mask.CGImage);
    CGSize imageSize = image.CGSize;
    CGSize maskSize = mask.CGSize;
    
    //调整图片rect
    switch (option) {
        case UIImageMaskOptionFillWithScale:
            break;
        case UIImageMaskOptionCenterWithoutScale: {
            rect.origin.x = (imageSize.width - maskSize.width) * 0.5 * -1;
            rect.origin.y = (imageSize.height - maskSize.height) * 0.5 * -1;
            rect.size = imageSize;
            break;
        }
        case UIImageMaskOptionCircumscribedIn: {
            NSUInteger wScale = rect.size.width / image.size.width * 100;
            NSUInteger hScale = rect.size.height / image.size.height * 100;
            NSUInteger scale = MIN(wScale, hScale);
            rect.size.width = scale / 100.0 * image.size.width;
            rect.size.height = scale / 100.0 * image.size.height;
            if (rect.size.width > rect.size.height) {
                rect.origin.x = 0;
                rect.origin.y = (mask.size.height - rect.size.height) * 0.5;
            } else {
                rect.origin.y = 0;
                rect.origin.x = (mask.size.width - rect.size.width) * 0.5;
            }
            break;
        }
        case UIImageMaskOptionCircumscribedOut: {
            NSUInteger wScale = rect.size.width / image.size.width * 100;
            NSUInteger hScale = rect.size.height / image.size.height * 100;
            NSUInteger scale = MAX(wScale, hScale);
            rect.size.width = scale / 100.0 * image.size.width;
            rect.size.height = scale / 100.0 * image.size.height;
            if (rect.size.width > rect.size.height) {
                rect.origin.y = 0;
                rect.origin.x = (mask.size.width - rect.size.width) * 0.5;
            } else {
                rect.origin.x = 0;
                rect.origin.y = (mask.size.height - rect.size.height) * 0.5;
            }
            break;
        }
        default:
            break;
    }
    
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    newImage = [UIImage imageWithCGImage:newImage.CGImage scale:mask.scale orientation:UIImageOrientationUp];
    return newImage;
}


@end




@implementation UIImage (Extension)

- (instancetype)imageWithRenderingColor:(UIColor *)color {
    return [UIImage imageWithColor:color andSize:self.size];
}

- (instancetype)imageWithNewSize:(CGSize)size {
    return [UIImage imageWithImage:self toNewSize:size];
}

- (instancetype)imageWithPercentScale:(NSUInteger)percentScale {
    return [UIImage imageWithImage:self toPercentScale:percentScale];
}

- (instancetype)imageWithOutOfCircumscribedSize:(CGSize)size {
    return [UIImage imageWithImage:self outOfCircumscribedSize:size];
}

- (instancetype)imageWithInOfCircumscribedSize:(CGSize)size {
    return [UIImage imageWithImage:self inOfCircumscribedSize:size];
}

- (instancetype)imageWithMask:(UIImage *)mask option:(UIImageMaskOption)option {
    return [UIImage imageWithImage:self mask:mask option:option];
}

+ (UIImage *)imageInOriginalModeWithName:(NSString *)imageName{
    
    // 加载图片
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)imageInOriginalMode{
    
    // 加载图片
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


+ (UIImage *)imageByStretchInCenterPoint: (UIImage *)image{
    
    UIImage *stretchImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    return stretchImage;
}

- (UIImage *)imageByStretchInCenterPoint{
    
    UIImage *stretchImage = [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
    return stretchImage;
}

- (UIImage *)circleImage{
    
    // 裁剪图片
    // 1.开启图形上下文
    // scale:比例因素 点:像素比例 0:自动识别比例因素
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 2.描绘图形裁剪路径
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.设置裁剪区域
    [clipPath addClip];
    // 4.绘制
    [self drawAtPoint:CGPointZero];
    // 5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下恩
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)circleImageWithBorder:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor{
    
    // 2.开启上下文
    CGFloat imageW = self.size.height + 2 * borderWidth;
    CGFloat imageH = self.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [self drawInRect:CGRectMake(borderWidth, borderWidth, self.size.height, self.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (instancetype)roundedWithRadius:(CGFloat)radius {
    // the size of CGContextRef
    int w = self.size.width;
    int h = self.size.height;
    
    UIImage *img = self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *image = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    return image;
}

void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                          float ovalHeight) {
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (instancetype)cutWithRect:(CGRect)rect {
    CGImageRef imageRef = self.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, subImageRef);
    UIImage *image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return image;
}

- (UIImage *)scaleToSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        } else {
            scaleFactor = heightFactor; // scale to fit width
        }
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) {
    }
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)scaleToFitScreen {
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat maxWidth = screenW * 2;
    if (self.size.width < maxWidth) {
        return self;
    }
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (self.size.width > self.size.height) {
        btHeight = maxWidth;
        btWidth = self.size.width * (maxWidth / self.size.height);
    } else {
        btWidth = maxWidth;
        btHeight = self.size.height * (maxWidth / self.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self scaleToSize:targetSize];
}


@end

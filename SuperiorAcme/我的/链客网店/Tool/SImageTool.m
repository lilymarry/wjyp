//
//  SImageTool.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SImageTool.h"
#import "ZLPhoto.h"

@interface SImageTool ()<ZLPhotoPickerBrowserViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation SImageTool
//从系统相册获取图片
-(void)ChoiceImageFromAlbums{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 1;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.photoStatus = PickerPhotoStatusPhotos;
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.isShowCamera = YES;
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        NSLog(@"sss:%@",status.mutableCopy);
        
        UIImage * selectImage = nil;
        for (int i = 0; i < status.count; i++) {
            id assets = status[i];
            if ([assets isKindOfClass:[ZLPhotoAssets class]]) {
                ZLPhotoAssets * ddd = (ZLPhotoAssets *)assets;
                selectImage = [self compressImage2Quality:ddd.originImage toByte:102400];
                
            }else{
                ZLCamera * ddd = (ZLCamera *)assets;
                selectImage = [self compressImage2Quality:ddd.photoImage toByte:102400];
            }
            self.reSetShopIconImage = selectImage;
        }
        //将选择的图片回调
        if (self.choiceImageCallBackBlock) {
            self.choiceImageCallBackBlock(self.reSetShopIconImage);
        }
    };
    [pickerVc showPickerVc:_vc];
    
}

//拍照获取图片
- (void)ChoiceImageFromCamera{
    //判断摄像头是否可用
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return;
    }
    
    UIImagePickerController * imagePickerCamera = [[UIImagePickerController alloc] init];
    imagePickerCamera.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        CGAffineTransform cameraTransform = CGAffineTransformMakeScale(1.25, 1.25);
        imagePickerCamera.cameraViewTransform = cameraTransform;
        
        imagePickerCamera.allowsEditing = YES;
        [_vc presentViewController:imagePickerCamera animated:YES completion:nil];
    }
}
//拍照获取图片的代理回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //设置只可拍照
        picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
        NSString * sourceType = [info objectForKey:UIImagePickerControllerMediaType];
        
        if ([sourceType isEqualToString:(NSString *)kUTTypeImage]) {
            
            UIImage * imageCamera = info[UIImagePickerControllerEditedImage];
            UIImage * selectImage = [self compressImage2Quality:imageCamera toByte:102400];
            
            self.reSetShopIconImage = selectImage;
            //将选择的图片回调
            if (self.choiceImageCallBackBlock) {
                self.choiceImageCallBackBlock(self.reSetShopIconImage);
            }
            [_vc dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
}
//压缩图片
- (UIImage *)compressImage2Quality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compressQuality = 1;
    NSData *data = UIImageJPEGRepresentation(image, compressQuality);
    if (data.length < maxLength) {
        //质量小于压缩大小
        return image;
    }
    /*压缩质量*/
    //指定大小压缩比例
    compressQuality = (CGFloat)maxLength/(CGFloat)data.length;
    data = UIImageJPEGRepresentation(image, compressQuality);
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) {
        //质量小于压缩大小
        return resultImage;
    }
    /*压缩大小*/
    NSUInteger lastDataLenth = 0;
    while (data.length > maxLength && data.length != lastDataLenth) {
        lastDataLenth = data.length;
        //计算压缩比例
        CGFloat compressSize = (CGFloat) maxLength/(CGFloat)data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(compressSize)), (NSUInteger)(resultImage.size.height * sqrtf(compressSize)));
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return resultImage;
}
@end

//
//  HJPhotoFetchManager.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/16.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJPhotoFetchManager.h"
#import <Photos/Photos.h>

@interface HJPhotoFetchManager ()

@end

@implementation HJPhotoFetchManager

+ (instancetype)shareManager {
    static HJPhotoFetchManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [HJPhotoFetchManager new];
    });
    return instance;


}


- (NSArray<PHAssetCollection *> *)fetchAssetCollections {
    PHFetchOptions * option = [[PHFetchOptions alloc] init];
    PHFetchResult * result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:option];

    
    return nil;
}


- (NSArray<PHAsset *> *)fetchPhotosWithAssetCollection:(PHAssetCollection *)assetCollection {
    PHFetchOptions * option = [PHFetchOptions new];
    PHFetchResult * result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    return nil;
}

@end

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

@property (nonatomic , strong) PHCachingImageManager * imageManager;

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


/**
 fetch asset collections

 @return <#return value description#>
 */
- (NSArray *)fetchAssetCollections {
 
    //smaralbums
    PHFetchResult * smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    NSMutableArray * fetchCollections = [NSMutableArray arrayWithCapacity:0];
    NSArray * mediaType = @[@(PHAssetMediaTypeImage)];
    // fetch all photo
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
    //predicate limit the mediaType and sort by createDate
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType in %@", mediaType];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsWithOptions:options];
    NSDictionary * dic = @{@"title":@"全部照片",@"fetchResult":assetsFetchResult};
        [fetchCollections addObject:dic];

    
    // fetch the smartAlbums
    for(PHCollection *collection in smartAlbums)
    {
        if ([collection isKindOfClass:[PHAssetCollection class]] && ![collection.localizedTitle isEqualToString:@"Videos"])
        {
            PHFetchOptions *options = [[PHFetchOptions alloc] init];
            options.predicate = [NSPredicate predicateWithFormat:@"mediaType in %@", mediaType];
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
            if (assetsFetchResult.count > 0) {
                NSLog(@"%@",assetCollection.localizedTitle);
                NSDictionary * dic1 = @{@"title":assetCollection.localizedTitle,@"fetchResult":assetsFetchResult};
                [fetchCollections addObject:dic1];
                
            }
        }
    }
    return fetchCollections;
}


- (NSMutableArray<UIImage *> *)fetchPhotosWithAssetCollectionFetchResult:(PHFetchResult *)fetchResult {
    
    return nil;
    
}



/**
 fetch the image use asset and  image size

 @param asset PHAsset
 @param size image size
 @return image
 */
- (UIImage *)fetchImageWithAsset:(PHAsset *)asset withSize:(CGSize )size{
   __block UIImage * image ;
    PHImageRequestOptions * options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    
    
    [self.imageManager requestImageForAsset:asset targetSize:size.width !=0 ? size: PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        image = result;
    }];
    return image;

}


/**
 fetch all photo

 @return all photos
 */
- (NSMutableArray *)getAllPhoto{
    NSMutableArray *arr = [NSMutableArray array];
    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        PHCollection *collection = smartAlbums[i];
        //遍历获取相册
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            PHAsset *asset = nil;
            if (fetchResult.count != 0) {
                for (NSInteger j = 0; j < fetchResult.count; j++) {
                    //从相册中取出照片
                    asset = fetchResult[j];
                    PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
                    opt.synchronous = YES;
                    PHImageManager *imageManager = [[PHImageManager alloc] init];
                    [imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                        if (result) {
                            [arr addObject:result];
                        }
                    }];
                }
            }
        }
    }
    
    //返回所有照片
    return arr;
}


#pragma mark-
#pragma mark- setter && getter
- (PHCachingImageManager *)imageManager {
    if (!_imageManager) {
        _imageManager = [[PHCachingImageManager alloc] init];
    }
    return _imageManager;

}

@end

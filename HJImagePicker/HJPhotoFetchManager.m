//
//  HJPhotoFetchManager.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/16.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJPhotoFetchManager.h"
#import <Photos/Photos.h>
#import <Photos/PHImageManager.h>
@interface HJPhotoFetchManager ()

//@property (nonatomic , strong) HJPhotoFetchManager * imageManager;

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
  
    
    //smaralbums
    PHFetchResult * smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    NSMutableArray * fetchCollections = [NSMutableArray arrayWithCapacity:0];
    
    // fetch all photo
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsWithOptions:options];
    NSDictionary * dic = @{@"title":@"全部照片",@"fetchResult":assetsFetchResult};
        [fetchCollections addObject:dic];


    
//   fetch folder user album
//  PHFetchResult * albumResult =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//    
//    
//    for(PHCollection *collection in albumResult)
//    {
//        if ([collection isKindOfClass:[PHAssetCollection class]])
//        {
//            PHFetchOptions *options = [[PHFetchOptions alloc] init];
//            //  options.predicate = [NSPredicate predicateWithFormat:@"mediaType in %@", PHAssetMediaTypeImage];
//            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
//            
//            //Albums collections are allways PHAssetCollectionType=1 & PHAssetCollectionSubtype=2
//            
//            PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
//            [arr addObject:assetsFetchResult];
//            
//        }
//    }

    
    // fetch the smartAlbums
    for(PHCollection *collection in smartAlbums)
    {
        if ([collection isKindOfClass:[PHAssetCollection class]] && ![collection.localizedTitle isEqualToString:@"Videos"])
        {
            PHFetchOptions *options = [[PHFetchOptions alloc] init];
            
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
            if (assetsFetchResult.count > 0) {
                NSLog(@"%@",assetCollection.localizedTitle);
                NSDictionary * dic1 = @{@"title":assetCollection.localizedTitle,@"fetchResult":assetsFetchResult};
                [fetchCollections addObject:dic1];
                
            }
        }
    }

    [self fetchPhotosWithAssetCollectionFetchResult:fetchCollections[0][@"fetchResult"]];
    return fetchCollections;
}


- (NSMutableArray<UIImage *> *)fetchPhotosWithAssetCollectionFetchResult:(PHFetchResult *)fetchResult {
    
   __block NSMutableArray * imageArr = [NSMutableArray arrayWithCapacity:0];
    
    
    [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAsset * asset = (PHAsset *) obj;
     [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(330.f, 330.f) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
         [imageArr addObject:result];
     }];
        
        
    }];
    return imageArr;
}

@end

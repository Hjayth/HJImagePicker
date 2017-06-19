//
//  HJPhotoFetchManager.h
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/16.
//  Copyright © 2017年 Hjay. All rights reserved.
//
/**
 photo fetch manager
 */
#import <Foundation/Foundation.h>
@class PHAsset;
@class PHAssetCollection;
@interface HJPhotoFetchManager : NSObject

/**
 singleInstance

 @return singleInstance photo fetch manager
 */
+ (instancetype)shareManager;



/**
 fetch the system ablum

 @return photo ablum arr
 */
- (NSArray<PHAssetCollection *> *)fetchAssetCollections;


/**
 fetch the ablum photos asset

 @param assetCollection asset collection
 @return ablum photos asset
 */
- (NSArray<PHAsset *> *)fetchPhotosWithAssetCollection:(PHAssetCollection *)assetCollection;

- (NSDictionary *)fetchAblumInfo:()

@end

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
#import <UIKit/UIKit.h>
@class PHAsset;
@class PHAssetCollection;
@class PHFetchResult;
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
- (NSMutableArray <PHAssetCollection *> *)fetchAssetCollections;


/**
 fetch the ablum photos asset

 @param fetchResult asset collection fetch result
 @return ablum photos asset
 */
- (NSMutableArray<UIImage *> *)fetchPhotosWithAssetCollectionFetchResult:(PHFetchResult *)fetchResult;

//- (NSDictionary *)fetchAblumInfo:()

@end

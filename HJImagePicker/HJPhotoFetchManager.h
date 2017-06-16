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


@interface HJPhotoFetchManager : NSObject

/**
 singleInstance

 @return singleInstance photo fetch manager
 */
- (instancetype)shareManager;



/**
 fetch the system ablum

 @return photo ablum arr
 */
- (NSArray *)fetchPhotoCollections;

@end

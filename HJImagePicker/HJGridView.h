//
//  HJGridView.h
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJNavigationView;
@class HJImagePickerBottomView;
@class HJImagePickerViewController;

/**
 show photo gridView
 */
@interface HJGridView : UIView


/**
 show photo collectionView
 */
@property (nonatomic , strong ) UICollectionView * collectionView;


/**
 navigationView
 */
@property (nonatomic , strong) HJNavigationView * navigationView;


/**
 ImagePickerBottomView
 */
@property (nonatomic , strong) HJImagePickerBottomView * bottomView;

/**
 imagePickerType
 */
@property (nonatomic , assign) int isAllowMulti;

@end

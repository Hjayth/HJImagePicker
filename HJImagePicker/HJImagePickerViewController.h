//
//  HJImagePickerViewController.h
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>



/**
 imagePicker  image  selcted type

 - HJImagePickerTpyeSingleSelection: chose singel image
 - HJImagePickerTypeMultiSelection: chose multi images
 */
typedef  NS_ENUM(NSInteger,HJImagePickerType){
    /**
     chose singel image
     */
    HJImagePickerTpyeSingleSelection = 0,
    
    /**
     chose multi images
     */
    HJImagePickerTypeMultiSelection = 1,
 
};

@class PHAsset;
@class HJImagePickerViewController;
@protocol HJImagePickerDelegate <NSObject>;


@required

/**
 confim the selectedImages to the DelegateVC
 
 @param imagePicker imagePicker
 @param imagesArr  image in the imagesArr is kind of uiimage
 */
- (void)imagePicker:(HJImagePickerViewController *)imagePicker
       didFinishedSelectedImages:(NSArray *)imagesArr;




/**
 cancel choice and go back last vc

 @param imagePicker imagePicker
 */
- (void)didCancelimagePicker:(HJImagePickerViewController *)imagePicker;


@optional

/**
 confim the selectedImages to the DelegateVC
 
 @param imagePicker imagePicker
 @param imageAssets image in the imageAssets is kind of PHAsset,you shoulde use PHImageManager to fetch the image
 */
- (void)imagePicker:(HJImagePickerViewController *)imagePicker didFinishedSelectedImageAssets:(NSArray <PHAsset *> *)imageAssets;

@end

@interface HJImagePickerViewController : UIViewController


/**
 HJImagePickerDelegate
 */
@property (nonatomic , weak ) id <HJImagePickerDelegate> delegate;

/**
 limit multi image selected count
 */
@property (nonatomic , assign) NSInteger limitSelctedCount;


/**
 nav right item
 */
@property (nonatomic , strong ) UIButton * navRightItem;


/**
 nav center item
 */
@property (nonatomic , strong ) UIButton * navCenterItem;

/**
 nav left item
 */
@property (nonatomic , strong) UIButton * navleftItem;


/**
 show the photo limited to the size
 */
@property (nonatomic , assign) CGSize photoSize;


/**
 the imagePicker include the media types
 */
@property (nonatomic , strong) NSArray * mediaType;



/**
 imagePickerType
 */
@property (nonatomic , assign) HJImagePickerType  imagePickerType;



/**
 init method

 @param imagePickerType imagePickerType
 @return HJImagePickerViewController instance
 */
- (HJImagePickerViewController *)initWithImagePickerType:(HJImagePickerType)imagePickerType;


@end

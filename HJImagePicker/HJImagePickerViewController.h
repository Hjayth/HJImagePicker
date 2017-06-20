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

 - HJImagePickerSelectedSingle: chose singel image
 - HJImagePickerSelectedMulti: chose multi images
 */
typedef  NS_ENUM(NSInteger,HJImagePickerSelectedType){
    /**
     chose singel image
     */
    HJImagePickerSelectedSingle,
    
    /**
     chose multi images
     */
    HJImagePickerSelectedMulti,
 
};

@class PHAsset;
@class HJImagePickerViewController;
@protocol HJImagePickerDelegate <NSObject>;


/**
 confim the selectedImages to the DelegateVC
 
 @param imagePicker imagePicker
 @param imagesArr  image in the imagesArr is kind of uiimage
 */
- (void)imagePicker:(HJImagePickerViewController *)imagePicker
       selectedImages:(NSArray *)imagesArr;


/**
 confim the selectedImages to the DelegateVC

 @param imagePicker imagePicker
 @param imageAssets image in the imageAssets is kind of PHAsset,you shoulde use PHImageManager to fetch the image
 */
- (void)imagePicker:(HJImagePickerViewController *)imagePicker selectedImageAssets:(NSArray <PHAsset *> *)imageAssets;

/**
 cancel choice and go back last vc

 @param imagePicker imagePicker
 */
- (void)didCancelimagePicker:(HJImagePickerViewController *)imagePicker;

@end

@interface HJImagePickerViewController : UIViewController

@property (nonatomic , weak ) id <HJImagePickerDelegate> delegate;


/**
 image  selcted type
 */
@property (nonatomic , assign) HJImagePickerSelectedType * imagePickerSelectedType;

/**
 limit multi image selected count
 */
@property (nonatomic , assign) NSInteger limitSelctedCount;


/**
 nav right item
 */
@property (nonatomic , strong) UIButton * navRightItem;


/**
 nav center item
 */
@property (nonatomic , strong) UIButton * navCenterItem;

/**
 nav left item
 */
@property (nonatomic , strong) UIButton * navleftItem;


/**
 show the photo limited to the size
 */
@property (nonatomic , assign) CGSize photoSize;




@end

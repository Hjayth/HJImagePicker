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

- (void)imagePicker:(HJImagePickerViewController *)imagePicker
       selectImages:(NSArray *)imagesArr;

- (void)imagePicker:(HJImagePickerViewController *)imagePicker selectImageAssets:(NSArray <PHAsset *> *)imageAssets;

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

@end

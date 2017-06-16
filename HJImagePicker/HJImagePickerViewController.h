//
//  HJImagePickerViewController.h
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@class PHAsset;
@class HJImagePickerViewController;
@protocol HJImagePickerDelegate <NSObject>;

- (void)imagePicker:(HJImagePickerViewController *)imagePicker
       selectImages:(NSArray *)imagesArr;

- (void)imagePicker:(HJImagePickerViewController *)imagePicker selectImageAssets:(NSArray <PHAsset *> *)imageAssets;

@end

@interface HJImagePickerViewController : UIViewController

@property (nonatomic , weak ) id <HJImagePickerDelegate> delegate;

@end

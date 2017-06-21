//
//  HJImagePickerBottomView.h
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 19/06/2017.
//  Copyright © 2017 Hjay. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 confim block
 */
typedef void(^confirmBlock)();

/**
 imagePickerBottomView
 */
@interface HJImagePickerBottomView : UIView


/**
 selcted count
 */
@property (nonatomic , assign)  NSInteger  count;


/**
 confim but
 */
@property (nonatomic , strong) UIButton * confirmBut;

/**
 selectedCountLabel
 */
@property (nonatomic , strong) UILabel * selectedCountLabel;

/**
 confim

 @param confim confim block
 */
- (void)confirm:(confirmBlock)confim;

@end

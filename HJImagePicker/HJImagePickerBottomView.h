//
//  HJImagePickerBottomView.h
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 19/06/2017.
//  Copyright © 2017 Hjay. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^confirmBlock)();

@interface HJImagePickerBottomView : UIView

@property (nonatomic , assign)  NSInteger  count;

@property (nonatomic , strong) UIButton * confirmBut;

- (void)confirm:(confirmBlock)confim;

@end

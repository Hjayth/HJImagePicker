//
//  ViewController.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "ViewController.h"
#import "HJImagePickerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * but = [UIButton new];
    but.frame = CGRectMake(100, 100, 100, 30);
    but.backgroundColor = [UIColor redColor];
    [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    but.titleLabel.text = @"图片";
    [but addTarget:self action:@selector(pushPhotoView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];

}


- (void)pushPhotoView {
 
    HJImagePickerViewController * hjVC = [[HJImagePickerViewController alloc] init];
    [self.navigationController pushViewController:hjVC
                                         animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

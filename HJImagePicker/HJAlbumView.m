//
//  HJAlbumView.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJAlbumView.h"
#import "HJAlbumTableViewCell.h"


@interface HJAlbumView ()

/**
 * @bref 显示album 的tableview
 */
@property (nonatomic , strong) UITableView * tableView;

@end


@implementation HJAlbumView



#pragma mark-
#pragma mark- setter && getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
    }
    return _tableView;
    
}


@end

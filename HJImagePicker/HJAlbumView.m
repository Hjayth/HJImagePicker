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



@end


@implementation HJAlbumView
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;

}

#pragma mark-
#pragma mark- configureUIAppearance
- (void)configureUIAppearance {
    [self addSubview:self.tableView];

}

#pragma mark-
#pragma mark- setter && getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[HJAlbumTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HJAlbumTableViewCell class])];
        
    }
    return _tableView;
    
}


@end

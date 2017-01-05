//
//  DDMCollectionViewCell.m
//  dropDownMenu
//
//  Created by wujin on 2016/10/23.
//  Copyright © 2016年 Individual Developer. All rights reserved.
//

#import "DDMCollectionViewCell.h"
#import "UIConstants.h"

@interface DDMCollectionViewCell ()

@end

@implementation DDMCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = nil;
        self.cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, (SCREEN_WIDTH-25)/4-10, 25)];
        // self.cellLabel.layer.cornerRadius = 12;
        self.cellLabel.font = [UIFont systemFontOfSize:14];
        self.cellLabel.clipsToBounds = YES;
        self.cellLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.cellLabel];
    }
    return self;
}

@end

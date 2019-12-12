//
//  CostumTableViewCell.m
//  Bookstore
//
//  Created by itsector on 04/03/2019.
//  Copyright © 2019 itsector. All rights reserved.
//

#import "CostumTableViewCell.h"

@implementation CostumTableViewCell


@synthesize Title = _Title;
@synthesize Date = _Date;
@synthesize CostumImageView = _CostumImageView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

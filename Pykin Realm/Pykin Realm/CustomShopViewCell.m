//
//  CustomShopViewCell.m
//  Pykin Realms
//
//  Created by IndyZa on 11/24/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "CustomShopViewCell.h"

@implementation CustomShopViewCell
@synthesize nameLabel = _nameLabel;
@synthesize star1 = _star1;
@synthesize star2 = _star2;
@synthesize star3 = _star3;
@synthesize star4 = _star4;
@synthesize star5 = _star5;
@synthesize background = _background;
@synthesize nextBtn = _nextBtn;
@synthesize objectId = _objectId;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

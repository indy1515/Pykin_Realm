//
//  HeaderViewController.m
//  Pykin Realms
//
//  Created by IndyZa on 11/11/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "HeaderViewController.h"

@implementation HeaderViewController
@synthesize pykinite;
@synthesize pykinite_icon;
@synthesize pykion;
@synthesize pykion_icon;
@synthesize name;


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        [self addSubview:
         [[[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                        owner:self
                                      options:nil] objectAtIndex:0]];
    }
    return self;
}

@end

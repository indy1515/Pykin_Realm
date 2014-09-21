//
//  MapScene.m
//  Pykin Realm
//
//  Created by IndyZa on 9/21/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "MapScene.h"
#import <GoogleMaps/GoogleMaps.h>
@implementation MapScene{
    NSUserDefaults* defaults;
}




-(id) initWithSize:(CGSize)size{
    defaults = [NSUserDefaults standardUserDefaults];
    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        NSLog(@"Entering MapScene");
//        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
//        NSLog(@"Fact1 Scene");
        
        SKSpriteNode *login = [SKSpriteNode spriteNodeWithImageNamed:@"login_facebook.png"];
        login.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)/4);
        login.name = @"login";
        
        
//        [self addChild:sn];
        [self addChild:login];
        
    }
    return self;
    
}


@end

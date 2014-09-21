//
//  MyAppMyScene.m
//  Pykin Realm
//
//  Created by IndyZa on 9/21/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "MyAppMyScene.h"
#import "MapScene.h"
#import "MapViewController.h"

@implementation MyAppMyScene{
     NSUserDefaults* defaults;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        // Replace @"Spaceship" with your background image:
        SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"pykin_splash.png"];
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.name = @"BACKGROUND";
        
        
        NSLog(@"App");
        
        SKSpriteNode *login = [SKSpriteNode spriteNodeWithImageNamed:@"login_facebook.png"];
        login.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)/4);
        login.name = @"login";


        [self addChild:sn];
        [self addChild:login];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    //if fire button touched, bring the rain
    if ([node.name isEqualToString:@"login"]) {
        //do whatever...
        [self toMapScene];
    }

}


-(void) toMapScene{
    MapScene *mapscene = [[MapScene alloc] initWithSize:CGSizeMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame))];
    SKTransition *transition = [SKTransition crossFadeWithDuration:0.7];
    [self removeAllSubView];
    // Note Notification name:  you should probably use a constant
    BOOL shouldHide = NO; // whether or not to hide
    
    // Update Here!
    NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:shouldHide], @"shouldHide", nil];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"toMapSceneNotification" // Better as constant!
                                                       object:self
                                                     userInfo:dict];
    
    
    [defaults setInteger:3 forKey:@"currentMode"];
//    [self.scene.view presentScene:mapscene transition:transition];
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void) removeAllSubView{
    for (UIView *view in self.view.subviews){
        
        [view removeFromSuperview];
    }
}

@end

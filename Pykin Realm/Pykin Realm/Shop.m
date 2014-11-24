//
//  Shop.m
//  Pykin Realm
//
//  Created by IndyZa on 9/22/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "Shop.h"
#import <GoogleMaps/GoogleMaps.h>
int const MAX_STAR = 5;
NSString *const REST = @"Restuarant";
NSString *const CAFE = @"Cafe";
@implementation Shop


-(id) init{
    if(self =[super init]){
        self.latLng = CLLocationCoordinate2DMake(0, 0);
        self.name = @"No Name";
        self.star = [[NSMutableDictionary alloc]init];
        for(int i = 1; i<= MAX_STAR;i++){
            [self.star setObject:[NSNumber numberWithBool:false]
                           forKey:[NSString stringWithFormat:@"star%d",i]];
        }
        self.type = REST;
        
    }
    
    return self;
}

-(id) initWithCLLocationCoordinate:(CLLocationCoordinate2D )latLng name:(NSString *)name{
    if(self = [super init]){
        self.latLng = latLng;
        self.name = name;
      
        
    }
    return self;
}

-(id) initWithCLLocationCoordinate:(CLLocationCoordinate2D )latLng name:(NSString *)name type:(NSString *)type{
    if(self = [super init]){
        self.latLng = latLng;
        self.name = name;
        self.type = type;
        
    }
    return self;
}

-(id) initWithCLLocationCoordinate:(CLLocationCoordinate2D )latLng name:(NSString *)name star:(NSMutableDictionary *)star{
    if(self = [super init]){
        self.latLng = latLng;
        self.name = name;
        self.star = star;
        
    }
    return self;
}

-(id) initWithCLLocationCoordinate:(CLLocationCoordinate2D)latLng name:(NSString *)name type:(NSString *)type objectId:(NSString *)objectId{
    if(self = [super init]){
        self.latLng = latLng;
        self.name = name;
        self.type = type;
        self.objectId = objectId;
        
    }
    return self;
}
-(id) initWithCLLocationCoordinate:(CLLocationCoordinate2D)latLng name:(NSString *)name type:(NSString *)type objectId:(NSString *)objectId isCanteen:(NSString*)isCanteen{
    if(self = [super init]){
        self.latLng = latLng;
        self.name = name;
        self.type = type;
        self.objectId = objectId;
        self.isCanteen = isCanteen;
    }
    return self;
}

-(void) setCustomStar:(int) starNo: (Boolean) starred{
    [self.star setValue:[NSNumber numberWithBool:starred] forKey:[NSString stringWithFormat:@"star%d",starNo]];
}

-(Boolean) getStarNo:(int) starNo{
    if([self.star[[NSString stringWithFormat:@"star%d",starNo]] boolValue] == NO){
        return NO;
    }
    return YES;
}

@end

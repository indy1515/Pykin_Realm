//
//  Shop.h
//  Pykin Realm
//
//  Created by IndyZa on 9/22/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

extern NSString *const REST;
extern NSString *const CAFE;


@interface Shop : NSObject
@property CLLocationCoordinate2D latLng;
@property NSString *name;
@property NSMutableDictionary *star;
@property NSString *type;
@property NSString *objectId;
@property NSString *isCanteen;

- (id)initWithCLLocationCoordinate:(CLLocationCoordinate2D )latLng
               name:(NSString *)name
                 star:(NSMutableDictionary *)star;

-(id) initWithCLLocationCoordinate:(CLLocationCoordinate2D )latLng name:(NSString *)name;

-(id) initWithCLLocationCoordinate:(CLLocationCoordinate2D )latLng name:(NSString *)name type:(NSString *)type;

-(id) initWithCLLocationCoordinate:(CLLocationCoordinate2D)latLng name:(NSString *)name type:(NSString *)type objectId:(NSString *)objectId;

-(id) initWithCLLocationCoordinate:(CLLocationCoordinate2D)latLng name:(NSString *)name type:(NSString *)type objectId:(NSString *)objectId isCanteen:(NSString*)isCanteen;
@end

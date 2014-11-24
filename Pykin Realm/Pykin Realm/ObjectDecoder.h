//
//  ObjectDecoder.h
//  Pykin Realms
//
//  Created by IndyZa on 11/25/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectDecoder : NSObject

@property NSString *isCanteen;
@property NSString *objectId;

- (id) initWithObjectId:(NSString*)objectId isCanteen:(NSString*) isCanteenString;
+(NSString*) codeData:(NSString*)objectId isCanteen:(NSString*) isCanteen;
+(ObjectDecoder*) decodeData:(NSString*)codeString;
@end

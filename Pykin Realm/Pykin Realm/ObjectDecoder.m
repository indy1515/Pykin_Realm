//
//  ObjectDecoder.m
//  Pykin Realms
//
//  Created by IndyZa on 11/25/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "ObjectDecoder.h"

@implementation ObjectDecoder


+(NSString*) codeData:(NSString*)objectId isCanteen:(NSString*) isCanteen{
    
    return [NSString stringWithFormat:@"%@*%@",objectId,isCanteen];
}

+(ObjectDecoder*) decodeData:(NSString*)codeString{
    NSArray* stringArr = [codeString componentsSeparatedByString:@"*"];
    NSLog(@"DecodeData: @%, @%",stringArr[0],stringArr[1]);
    return [[ObjectDecoder alloc] initWithObjectId:stringArr[0] isCanteen:stringArr[1]];
}

- (id) initWithObjectId:(NSString*)objectId isCanteen:(NSString*) isCanteenString{
    self.objectId = objectId;
    self.isCanteen = isCanteenString;
    return self;
}

@end

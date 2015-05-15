//
//  GlobalVars.m
//  Jogo-Infantil
//
//  Created by Jose Dantas on 5/14/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import "GlobalVars.h"

@implementation GlobalVars

@synthesize vcOrigem = _vcOrigem;

+ (GlobalVars *)sharedInstance {
    static dispatch_once_t onceToken;
    static GlobalVars *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalVars alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        // Note these aren't allocated as [[NSString alloc] init] doesn't provide a useful object
        _vcOrigem = nil;
    }
    return self;
}

@end

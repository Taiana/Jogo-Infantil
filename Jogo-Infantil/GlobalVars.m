//
//  GlobalVars.m
//  Jogo-Infantil
//
//  Created by Jose Dantas on 5/14/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import "GlobalVars.h"
#import "NSObject+SBJson.h"

@implementation GlobalVars

@synthesize vcOrigem = _vcOrigem;

@synthesize playSound = _playSound;

@synthesize sound = _sound;

@synthesize imageName = _imageName;

@synthesize image = _image;

@synthesize soundOn = _soundOn;

@synthesize soundOff = _soundOff;

@synthesize imagem1 = _imagem1;

@synthesize imagens = _imagens;

NSURL* musicFile;

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
        _playSound = true;
        musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]                                                                                                               pathForResource:@"soundtrack" ofType:@"mp3"]];
        _sound = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile  error:nil];
        _sound.numberOfLoops = -1;
        _imageName = nil;
        _image = nil;
        _soundOn = @"";
        _soundOff = @"";
        
        _imagens = self.parseJson;
        
    }
    return self;
}

- (NSDictionary *)parseJson {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"desenhos" ofType:@"json"];
    
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    if (!myJSON) {
        NSLog(@"File couldn't be read!");
        return nil;
    }
    
    NSDictionary *json = [myJSON JSONValue];
    return json;
}

@end

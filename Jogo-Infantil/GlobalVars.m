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

@synthesize playSound = _playSound;

@synthesize sound = _sound;

@synthesize imageName = _imageName;

@synthesize image = _image;

@synthesize soundOn = _soundOn;

@synthesize soundOff = _soundOff;

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
        musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]                                                                                                               pathForResource:@"musica" ofType:@"mp3"]];
        _sound = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile  error:nil];
        _sound.numberOfLoops = -1;
        _imageName = nil;
        _image = nil;
        _soundOn = @"";
        _soundOff = @"";
    }
    return self;
}

@end

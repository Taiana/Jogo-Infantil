//
//  GlobalVars.h
//  Jogo-Infantil
//
//  Created by Jose Dantas on 5/14/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>

@interface GlobalVars : NSObject
{
    UIViewController *vcOrigem;
    bool *playSound;
    AVAudioPlayer *sound;
}

+ (GlobalVars *)sharedInstance;

@property(strong, nonatomic, readwrite) UIViewController *vcOrigem;

@property(nonatomic, readwrite) bool *playSound;

@property(nonatomic, readwrite) AVAudioPlayer *sound;

@end

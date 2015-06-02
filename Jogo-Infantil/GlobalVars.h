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
    NSString *imageName;
    UIImage *image;
    NSString *soundOn;
    NSString *soundOff;
    NSArray *imagem1;
    NSArray *numeroUm;
    NSArray *letraA;
    NSArray *abelha;
    NSArray *flor1;
    NSArray *carro1;
    NSArray *gato;
    NSArray *quadrado;
    NSMutableDictionary *imagens;
}

+ (GlobalVars *)sharedInstance;

@property(strong, nonatomic, readwrite) UIViewController *vcOrigem;

@property(nonatomic, readwrite) bool *playSound;

@property(nonatomic, readwrite) AVAudioPlayer *sound;

@property(strong, nonatomic, readwrite) NSString *imageName;

@property(strong, nonatomic, readwrite) UIImage *image;

@property(strong, nonatomic, readwrite) NSString *soundOn;

@property(strong, nonatomic, readwrite) NSString *soundOff;

@property(strong, nonatomic, readwrite) NSArray *imagem1;

@property(strong, nonatomic, readwrite) NSArray *numeroUm;

@property(strong, nonatomic, readwrite) NSArray *letraA;

@property(strong, nonatomic, readwrite) NSArray *abelha;

@property(strong, nonatomic, readwrite) NSArray *flor1;

@property(strong, nonatomic, readwrite) NSArray *carro1;

@property(strong, nonatomic, readwrite) NSArray *gato;

@property(strong, nonatomic, readwrite) NSArray *quadrado;

@property(strong, nonatomic, readwrite) NSMutableDictionary *imagens;

@end

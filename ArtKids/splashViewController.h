//
//  splashViewController.h
//  Jogo-Infantil
//
//  Created by Taiana Moreira on 06/06/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "globalVars.h"

GlobalVars *globals;

@interface splashViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *splashImageView;

@end

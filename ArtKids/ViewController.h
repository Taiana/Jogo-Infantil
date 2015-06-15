//
//  ViewController.h
//  Jogo-Infantil
//
//  Created by Taiana on 13/04/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "globalVars.h"

GlobalVars *globals;

@interface ViewController : UIViewController {

}

- (IBAction)doSwitchSound:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *noSoundImageView;

@end


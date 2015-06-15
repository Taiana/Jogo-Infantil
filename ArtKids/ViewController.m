//
//  ViewController.m
//  Jogo-Infantil
//
//  Created by Taiana on 13/04/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    globals = [GlobalVars sharedInstance];

    if (globals.playSound) {
        if (![globals.sound isPlaying]){
            [globals.sound play];
        }
    } else {
        self.noSoundImageView.hidden = NO;
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doSwitchSound:(id)sender {
    
    if (globals.playSound) {
        self.noSoundImageView.hidden = NO;
        [globals.sound stop];
        globals.playSound = false;
    } else {
        self.noSoundImageView.hidden = YES;
        [globals.sound play];
        globals.playSound = true;
    }
    
    
    
}
@end

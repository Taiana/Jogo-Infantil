//
//  animaisViewController.m
//  Jogo-Infantil
//
//  Created by Jose Dantas on 5/14/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import "animaisViewController.h"
#import "GlobalVars.h"

GlobalVars *globals;

@interface animaisViewController ()

@end

@implementation animaisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    globals = [GlobalVars sharedInstance];
    globals.vcOrigem = self;
    
    if (globals.playSound) {
        if (![globals.sound isPlaying]){
            [globals.sound play];
        }
        [_btnSound setTitle:globals.soundOff forState:UIControlStateNormal];
    } else {
        [_btnSound setTitle:globals.soundOn forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickButton:(id)sender {
    globals.image = [[(UIButton *)sender imageView] image];
    globals.imageName = [[(UIButton *)sender titleLabel] text];
    [self performSegueWithIdentifier:@"animaisParaJogo" sender:self];
}

- (IBAction)toggleSound:(id)sender {
    if (globals.playSound) {
        //self.noSoundImageView.hidden = NO;
        [_btnSound setTitle:globals.soundOn forState:UIControlStateNormal];
        [globals.sound stop];
        globals.playSound = false;
    } else {
        //self.noSoundImageView.hidden = YES;
        [_btnSound setTitle:globals.soundOff forState:UIControlStateNormal];
        [globals.sound play];
        globals.playSound = true;
    }
}

@end

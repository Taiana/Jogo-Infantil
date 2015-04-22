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
    // Do any additional setup after loading the view, typically from a nib.
//    SystemSoundID soundID;
//    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]                                                                                                               pathForResource:@"musica" ofType:@"mp3"]];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)musicFile, &soundID);
//    AudioServicesPlaySystemSound (soundID);

    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]                                                                                                               pathForResource:@"musica" ofType:@"mp3"]];
    sound = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile  error:nil];
    sound.numberOfLoops = -1;
    [sound play];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doSwitchSound:(id)sender {
    
    if (self.noSoundImageView.hidden) {
        self.noSoundImageView.hidden = NO;
        [sound stop];
    } else {
        self.noSoundImageView.hidden = YES;
        [sound play];
    }
    
    
    
}
@end

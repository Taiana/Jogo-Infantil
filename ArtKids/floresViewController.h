//
//  floresViewController.h
//  Jogo-Infantil
//
//  Created by Jose Dantas on 5/18/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface floresViewController : UIViewController

- (IBAction)clickButton:(id)sender;

- (IBAction)toggleSound:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSound;

@end

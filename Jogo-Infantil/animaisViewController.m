//
//  animaisViewController.m
//  Jogo-Infantil
//
//  Created by Jose Dantas on 5/14/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import "animaisViewController.h"
#import "GlobalVars.h"

@interface animaisViewController ()

@end

@implementation animaisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GlobalVars *globals = [GlobalVars sharedInstance];
    globals.vcOrigem = self;
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

@end

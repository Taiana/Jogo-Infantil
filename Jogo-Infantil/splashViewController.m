//
//  splashViewController.m
//  Jogo-Infantil
//
//  Created by Taiana Moreira on 06/06/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import "splashViewController.h"

@interface splashViewController ()

@end

@implementation splashViewController

- (void)viewDidLoad {
    
    //CGRect splashscreenmovieclipframe = CGRectMake(0.0f,0.0f,480.0f, 320.0f); //set co-ordinate here i use full screen
    
    //splashscreenmovieclip = [[UIImageView alloc] initWithFrame:splashscreenmovieclipframe];
    
    // load all the frames of our animation
    _splashImageView.animationImages = [NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"fundo_tela_inicio1.png"],
                                             [UIImage imageNamed:@"fundo_tela_inicio2.png"],
                                             [UIImage imageNamed:@"fundo_tela_inicio3.png"],
                                             [UIImage imageNamed:@"fundo_tela_inicio4.png"],
                                             [UIImage imageNamed:@"fundo_tela_inicio5.png"],
                                             nil];
    
    // all frames will execute in 1.75 seconds
    _splashImageView.animationDuration = 7;
    // repeat the annimation forever
    _splashImageView.animationRepeatCount = 0;
    // start animating
    [_splashImageView startAnimating];
    // add the animation view to the main window
    [self.view addSubview:_splashImageView];
    
    [NSTimer scheduledTimerWithTimeInterval:7.0f target:self selector:@selector(Gotomainmenuview:) userInfo:nil repeats:NO];

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)Gotomainmenuview:(NSTimer *)theTimer
{
    // write your code here for counter update
    [_splashImageView removeFromSuperview];
    //inicioVC
    [self performSegueWithIdentifier:@"inicioVC" sender:self];
    //newclasstojump *mmvc=[[newclasstojump alloc]initWithNibName:@"viewController" bundle:nil];
    //[self.view addSubview:mmvc.view];
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

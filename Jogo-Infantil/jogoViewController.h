//
//  jogoViewController.h
//  Jogo Infantil
//
//  Created by Taiana on 22/03/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

NSArray* colors;

int cols;
int rows;

UIView *buttonView;

UITapGestureRecognizer *tapGesture;

//UISegmentedControl *seletor;

@interface jogoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *viewAnterior;

-(void) cols:(int)numCols rows:(int)numRows;

@property (weak, nonatomic) IBOutlet UIImageView *topImage;

-(UIImage *)imageWithColor:(UIColor *)color;

- (IBAction)voltar:(id)sender;

- (IBAction)btnTap:(id)sender;
- (IBAction)brownColor:(id)sender;
- (IBAction)orangeColor:(id)sender;
- (IBAction)yellowColor:(id)sender;
- (IBAction)redColor:(id)sender;
- (IBAction)magentaColor:(id)sender;
- (IBAction)blackColor:(id)sender;
- (IBAction)blueColor:(id)sender;
- (IBAction)cianColor:(id)sender;
- (IBAction)greenColor:(id)sender;
- (IBAction)lightGrayColor:(id)sender;
- (IBAction)grayColor:(id)sender;
- (IBAction)whiteColor:(id)sender;

- (IBAction)limpaTabuleiro:(id)sender;

@end

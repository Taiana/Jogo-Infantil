//
//  jogoViewController.h
//  Jogo Infantil
//
//  Created by Taiana on 22/03/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

NSArray* colors;

AVAudioPlayer *sound;
AVAudioPlayer *soundWin;
AVAudioPlayer *soundLose;
NSURL* musicFile;

int cols;
int rows;

UIView *buttonView;

UITapGestureRecognizer *tapGesture;

NSMutableArray *desenho;

/*
 Tabela de cores
 0=Branco
 1=Preto
 2=Cinza escuro
 3=Cinza claro
 4=Verde claro
 5=Verde escuro
 6=Azul claro
 7=Azul escuro
 8=Rosa
 9=Lilás
 A=Vermelho
 B=Amarelo
 C=Laranja
 D=Marrom
*/
NSString *colorCode;

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
- (IBAction)roseColor:(id)sender;
- (IBAction)blackColor:(id)sender;
- (IBAction)blueColor:(id)sender;
- (IBAction)cianColor:(id)sender;
- (IBAction)greenColor:(id)sender;
- (IBAction)darkGreenColor:(id)sender;
- (IBAction)lightGrayColor:(id)sender;
- (IBAction)grayColor:(id)sender;
- (IBAction)whiteColor:(id)sender;

- (IBAction)limpaTabuleiro:(id)sender;

- (IBAction)toggleSound:(id)sender;

- (IBAction)comparaImagem:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *percentualAcerto;

@property (weak, nonatomic) IBOutlet UIButton *btnSound;

@end

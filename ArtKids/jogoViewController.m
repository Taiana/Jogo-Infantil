//
//  jogoViewController.m
//  Jogo Infantil
//
//  Created by Taiana on 22/03/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import "jogoViewController.h"
#import "GlobalVars.h"
#import "CNPPopupController.h"
#import <Foundation/Foundation.h>

BOOL firstRun = TRUE;

NSArray *selectedImage;
int contaAcertos=0;
int contaPontos=0;
float percentual=0.0;

bool pausaSom = false;

UIColor *selectedColor;

UIViewController *nuVC;

NSError *error;

GlobalVars *globals;

int tamanhoQuadrado = 19;

CGFloat delta_x = 0.0;
CGFloat delta_y = 0.0;

@interface jogoViewController () <CNPPopupControllerDelegate>

@property (nonatomic, strong) CNPPopupController *popupController;

@property (nonatomic, retain) IBOutlet NSMutableArray* board;

@property (nonatomic) UIImage* imageWithColor;

@end

@implementation jogoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    desenho = [[NSMutableArray alloc] initWithCapacity:1024];
    
    /*
     Tabela de cores
     0=Branco - 1=Preto - 2=Cinza escuro - 3=Cinza claro - 4=Verde claro - 5=Verde escuro - 6=Azul claro
     7=Azul escuro - 8=Rosa - 9=Lilás - A=Vermelho - B=Amarelo - C=Laranja - D=Marrom
     */
    selectedColor = [UIColor brownColor];
    colorCode = @"D";
    
    globals = [GlobalVars sharedInstance];
    nuVC = globals.vcOrigem;
    
    //=============== TENTANDO PEGAR O ARRAY DA IMAGEM SELECIONADA =================
    NSDictionary *dic = globals.imagens;
//    NSLog(@"imageName: %@", globals.imageName);
    selectedImage = [dic valueForKey:globals.imageName];
//    NSLog(@"array escolhido: %@", selectedImage);
    //==============================================================================
    
    if (globals.image != nil) {
        self.topImage.image = (UIImage *)globals.image;
    }
    
    if (globals.playSound) {
        if (![globals.sound isPlaying]){
            [globals.sound play];
        }
        [_btnSound setTitle:globals.soundOff forState:UIControlStateNormal];
    } else {
        [_btnSound setTitle:globals.soundOn forState:UIControlStateNormal];
    }
    
    _viewAnterior.text = NSStringFromClass([nuVC class]);

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self cols:32 rows:32];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) cols:(int)numCols rows:(int)numRows {
    
    // Do any additional setup after loading the view, typically from a nib.
    
    cols = numCols;
    rows = numRows;
    
    const int dist = tamanhoQuadrado+1;
    buttonView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, dist*numCols, dist*numRows)];
    
    int cont = 0;
    for (int y = 0; y < numRows; y++) {
        for (int x = 0; x < numCols; x++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(dist * x, dist * y, tamanhoQuadrado, tamanhoQuadrado);
            [button setTag:cont+1];
            [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnTap:withEvent:) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
            [button addTarget:self action:@selector(fingerRelease:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside];
            [buttonView addSubview: button];
            [_board addObject:button];
            [desenho insertObject:@"0" atIndex:cont];
            cont++;
        }
    }
    
    // Center the view which contains your buttons
    CGPoint centerPoint = buttonView.center;
    centerPoint.x = self.view.center.x+3;
    centerPoint.y = self.view.center.y+150;
    buttonView.center = centerPoint;
    buttonView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:buttonView];
    
}

- (void)btnTap:(UIButton *)button withEvent:(UIEvent *)event
{
    @try {
        [button setBackgroundImage:[self imageWithColor:selectedColor] forState:UIControlStateSelected];
        //get touched button
        long tag = button.tag;
        long tagPintar;
        
        if (tag < cols * rows ) {
            [desenho replaceObjectAtIndex:tag-1 withObject:colorCode];
        }
        
        // get the touch
        UITouch *touch = [[event touchesForView:button] anyObject];
        
        // get delta
        CGPoint previousLocation = [touch previousLocationInView:button];
        CGPoint location = [touch locationInView:button];

        delta_x = delta_x + (location.x - previousLocation.x);
        delta_y = delta_y + (location.y - previousLocation.y);
        
        UIButton *newButton;
        // Calcula o número de quadrados a andar na verticar ou na horizontal
        int horizontal = (int)floorf(delta_x/tamanhoQuadrado);
        int vertical = (int)floorf(delta_y/tamanhoQuadrado);
        
        tagPintar = tag+(horizontal)+(rows*vertical);
        
        if (tagPintar < cols * rows ) {
    //        NSLog(@"tag pintar %li", tagPintar);
            [desenho replaceObjectAtIndex:tagPintar-1 withObject:colorCode];
            newButton = (UIButton *)[self.view viewWithTag:tagPintar];
            [newButton setBackgroundImage:[self imageWithColor:selectedColor] forState:UIControlStateNormal];
        }
    } @catch(NSException *ex) {
        NSLog(@"Deu excessão!");
        return;
    } @finally {
        NSLog(@"Deu excessão!");
    }

}

- (void)fingerRelease:(UIButton *)button {
    delta_x = 0;
    delta_y = 0;
}

- (IBAction)btnTap:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    if ([btn tag] < cols * rows ) {
        [desenho replaceObjectAtIndex:[btn tag]-1 withObject:colorCode];
    }
    [(UIButton*)sender setBackgroundImage:[self imageWithColor:selectedColor] forState:UIControlStateNormal];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (IBAction)voltar:(id)sender {
    qtdDicas = 0;
    [self performSegueWithIdentifier:NSStringFromClass([nuVC class]) sender:sender];
}

- (IBAction)brownColor:(id)sender {
    //     Tabela de cores
    //     D=Marrom
    colorCode=@"D";
    selectedColor = [UIColor brownColor];
}

- (IBAction)orangeColor:(id)sender {
    //     Tabela de cores
    //     C=Laranja
    colorCode=@"C";
    selectedColor = [UIColor orangeColor];
}

- (IBAction)yellowColor:(id)sender {
    //     Tabela de cores
    //     B=Amarelo
    colorCode=@"B";
    selectedColor = [UIColor yellowColor];
}

- (IBAction)redColor:(id)sender {
    //     Tabela de cores
    //     A=Vermelho
    colorCode=@"A";
    selectedColor = [UIColor redColor];
}

- (IBAction)magentaColor:(id)sender {
    //     Tabela de cores
    //     9=Magenta
    colorCode=@"9";
    selectedColor = [UIColor magentaColor];
}

- (IBAction)roseColor:(id)sender {
    //     Tabela de cores
    //     8=Rosa
    colorCode=@"8";
    selectedColor = [UIColor colorWithRed:253.0/255.0 green:151.0/255.0 blue:240.0/255.0 alpha:1.0];
}

- (IBAction)blackColor:(id)sender {
    //     Tabela de cores
    //     1=Preto
    colorCode=@"1";
    selectedColor = [UIColor blackColor];
}

- (IBAction)blueColor:(id)sender {
    //     Tabela de cores
    //     7=Azul escuro
    colorCode=@"7";
    selectedColor = [UIColor blueColor];
}

- (IBAction)cianColor:(id)sender {
    //     Tabela de cores
    //     6=Ciano
    colorCode=@"6";
    selectedColor = [UIColor cyanColor];
}

- (IBAction)greenColor:(id)sender {
    //     Tabela de cores
    //     4=Verde claro
    colorCode=@"4";
    selectedColor = [UIColor greenColor];
}

- (IBAction)darkGreenColor:(id)sender {
    //     Tabela de cores
    //     5=Verde escuro
    colorCode=@"5";
    selectedColor = [UIColor colorWithRed:15.0/255.0 green:115.0/255.0 blue:49.0/255.0 alpha:1.0];
}

- (IBAction)lightGrayColor:(id)sender {
    //     Tabela de cores
    //     3=Cinza claro
    colorCode=@"3";
    selectedColor = [UIColor colorWithRed:210.0 green:210.0 blue:210.0 alpha:0.5];
}

- (IBAction)grayColor:(id)sender {
    //     Tabela de cores
    //     2=Cinza escuro
    colorCode=@"2";
    selectedColor = [UIColor colorWithRed:150.0 green:150.0 blue:150.0 alpha:0.0];
}

- (IBAction)whiteColor:(id)sender {
    //     Tabela de cores
    //     0=Branco
    colorCode=@"0";
    selectedColor = [UIColor whiteColor];
}

- (IBAction)limpaTabuleiro:(id)sender {
    int total = cols * rows;
    UIButton *button;
    for (int i=1;i<=total;i++) {
        button = (UIButton *)[self.view viewWithTag:i];
        [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setAlpha:1.0];
        [desenho replaceObjectAtIndex:i-1 withObject:@"0"];
    }
}

- (IBAction)voltaTabuleiro:(id)sender {
    
    int total = cols * rows;
    UIButton *button;
    /*
     Tabela de cores
     0=Branco - 1=Preto - 2=Cinza escuro - 3=Cinza claro - 4=Verde claro - 5=Verde escuro - 6=Azul claro
     7=Azul escuro - 8=Rosa - 9=Lilás - A=Vermelho - B=Amarelo - C=Laranja - D=Marrom
     */
    for (int i=1;i<=total;i++) {
        button = (UIButton *)[self.view viewWithTag:i];
        [button setAlpha:1.0];
        if ([@"0" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        } else if ([@"1" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        } else if ([@"2" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:150.0 green:150.0 blue:150.0 alpha:0.0]] forState:UIControlStateNormal];
        } else if ([@"3" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
        } else if ([@"4" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
        } else if ([@"5" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:15.0/255.0 green:115.0/255.0 blue:49.0/255.0 alpha:1.0]] forState:UIControlStateNormal];
        } else if ([@"6" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor cyanColor]] forState:UIControlStateNormal];
        } else if ([@"7" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
        } else if ([@"8" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:253.0/255.0 green:151.0/255.0 blue:240.0/255.0 alpha:1.0]] forState:UIControlStateNormal];
        } else if ([@"9" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor magentaColor]] forState:UIControlStateNormal];
        } else if ([@"A" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        } else if ([@"B" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor yellowColor]] forState:UIControlStateNormal];
        } else if ([@"C" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        } else if ([@"D" isEqualToString:desenho[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor brownColor]] forState:UIControlStateNormal];
        }
    }
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

- (IBAction)comparaImagem:(id)sender {
    NSLog(@"array: %@", desenho);
    self.comparaArrays;
    percentual = ((float)contaAcertos/(float)contaPontos)*100;
//    NSLog(@"Número de pontos %d", contaPontos );
//    NSLog(@"Número de acertos %d", contaAcertos );
//    NSLog(@"Percentual de acertos %f", percentual );
    self.percentualAcerto.text = [NSString stringWithFormat:@"%.02f", percentual];
    
    // para a musica se estiver tocando
    if (globals.playSound) {
        pausaSom = true;
        [globals.sound pause];
    } else {
        pausaSom = false;
    }
    
    [self showPopupWithStyle:CNPPopupStyleCentered];

//    NSLog(@"Número de acertos %d", percentual );
}

- (IBAction)mostraImagem:(id)sender {
    int total = cols * rows;
    UIButton *button;
    
    qtdDicas++;
    if (qtdDicas >= maxDicas) {
        [self.btnDica setEnabled:false];
    }
    

    /*
     Tabela de cores
     0=Branco - 1=Preto - 2=Cinza escuro - 3=Cinza claro - 4=Verde claro - 5=Verde escuro - 6=Azul claro
     7=Azul escuro - 8=Rosa - 9=Lilás - A=Vermelho - B=Amarelo - C=Laranja - D=Marrom
     */
    for (int i=1;i<=total;i++) {
        button = (UIButton *)[self.view viewWithTag:i];
        
        if ([@"Z" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        } else if ([@"1" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
        } else if ([@"2" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:150.0 green:150.0 blue:150.0 alpha:0.0]] forState:UIControlStateNormal];
        } else if ([@"3" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
        } else if ([@"4" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
        } else if ([@"5" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:15.0/255.0 green:115.0/255.0 blue:49.0/255.0 alpha:1.0]] forState:UIControlStateNormal];
        } else if ([@"6" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor cyanColor]] forState:UIControlStateNormal];
        } else if ([@"7" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
        } else if ([@"8" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:253.0/255.0 green:151.0/255.0 blue:240.0/255.0 alpha:1.0]] forState:UIControlStateNormal];
        } else if ([@"9" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor magentaColor]] forState:UIControlStateNormal];
        } else if ([@"A" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        } else if ([@"B" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor yellowColor]] forState:UIControlStateNormal];
        } else if ([@"C" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        } else if ([@"D" isEqualToString:selectedImage[i-1]]) {
            [button setBackgroundImage:[self imageWithColor:[UIColor brownColor]] forState:UIControlStateNormal];
        }
        
        [button setAlpha:0.50];
    }
    
    [self.dicas setText:[[NSNumber numberWithInt:maxDicas-qtdDicas] stringValue]];
    
    //DEFINE A QUANTIDADE DE DICAS MÁXIMA DE 3, desabilita o botão
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(voltaTabuleiro:) userInfo:nil repeats:NO];
    
}

- (void)comparaArrays {
    contaAcertos=0;
    contaPontos=0;
    percentual=0.0;
    for (int i=0;i<1024;i++) {

        if (![(NSString *)[selectedImage objectAtIndex:i] isEqualToString:@"Z"]){
            contaPontos++;
            if ([(NSString *)[desenho objectAtIndex:i] isEqualToString:(NSString *)[selectedImage objectAtIndex:i]]){
                NSLog(@"Igual");
                contaAcertos++;
            }
        }
    }
}



- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSString *msgAcerto = [NSString stringWithFormat:@"Você acertou %@%@", [NSString stringWithFormat:@"%.02f", percentual], @"%"];
    
    UIImage *icon;
    NSString *imgIcon;
    NSString *msgTopo;
    NSString *msgCompl;
    NSString *msgBotaoTentar;
    NSString *msgBotaoSair;
    bool passou = percentual > 50.0 ? true : false;
    
    if (passou) {
        imgIcon = @"happy";
        msgTopo = @"Parabéns!";
        msgCompl = @"Você conseguiu";
        msgBotaoTentar = @"Jogue novamente";
        msgBotaoSair = @"Sair";
    } else {
        imgIcon = @"sad";
        msgTopo = @"ooops ...";
        msgCompl = @"Não foi dessa vez";
        msgBotaoTentar = @"Continue o desenho";
        msgBotaoSair = @"Sair";
    }
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:msgTopo attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:msgCompl attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    icon = [UIImage imageNamed:imgIcon];
    
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:msgAcerto attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:28], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:msgBotaoTentar attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *buttonSair = [[NSAttributedString alloc] initWithString:msgBotaoSair attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    
    CNPPopupButtonItem *buttonItem = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonTitle backgroundColor:[UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0]];
    CNPPopupButtonItem *buttonItem2 = [CNPPopupButtonItem defaultButtonItemWithTitle:buttonSair backgroundColor:[UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0]];
    
    buttonItem.selectionHandler = ^(CNPPopupButtonItem *item){
        NSLog(@"Block for button: %@", item.buttonTitle.string);
    };
    buttonItem2.selectionHandler = ^(CNPPopupButtonItem *item){
        NSLog(@"Block for button: %@", item.buttonTitle.string);
    };
    
    if (passou) {
        musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]                                                                                                               pathForResource:@"comemoracao" ofType:@"mp3"]];
        sound = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile  error:nil];
        sound.play;
        
        self.popupController = [[CNPPopupController alloc] initWithTitle:title contents:@[lineOne, icon, lineTwo] buttonItems:@[buttonItem] destructiveButtonItem:nil];
    } else {
        musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]                                                                                                               pathForResource:@"fail1" ofType:@"mp3"]];
        sound = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile  error:nil];
        sound.play;
        
        self.popupController = [[CNPPopupController alloc] initWithTitle:title contents:@[lineOne, icon, lineTwo] buttonItems:@[buttonItem, buttonItem2] destructiveButtonItem:nil];
    }
    
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    self.popupController.theme.presentationStyle = CNPPopupPresentationStyleFadeIn;
    [self.popupController presentPopupControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - CNPPopupController Delegate

- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title {
    NSLog(@"Saiu pelo botão: %@", title);
    
    if ([@"Sair" isEqualToString:title] || [@"Jogue novamente" isEqualToString:title]) {
        NSLog(@"Volta para a tela de início");
        if (pausaSom) {
            [globals.sound play];
        }
        [self performSegueWithIdentifier:@"categoriasViewController" sender:self];
    } else {
        if (pausaSom) {
            [globals.sound play];
        }
        NSLog(@"Fica no desenho");
    }
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
    NSLog(@"Abriu o popup.");
}

@end

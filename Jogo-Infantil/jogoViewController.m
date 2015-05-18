//
//  jogoViewController.m
//  Jogo Infantil
//
//  Created by Taiana on 22/03/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import "jogoViewController.h"
#import "GlobalVars.h"

BOOL firstRun = TRUE;

UIColor *selectedColor;

UIViewController *nuVC;

GlobalVars *globals;

int tamanhoQuadrado = 19;

CGFloat delta_x = 0.0;
CGFloat delta_y = 0.0;

@interface jogoViewController ()

@property (nonatomic, retain) IBOutlet NSMutableArray* board;

@property (nonatomic) UIImage* imageWithColor;

@end

@implementation jogoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedColor = [UIColor brownColor];
    
    globals = [GlobalVars sharedInstance];
    nuVC = globals.vcOrigem;
    
    if (globals.image != nil) {
        self.topImage.image = (UIImage *)globals.image;
    }
    
    _viewAnterior.text = NSStringFromClass([nuVC class]);

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //if (firstRun) {
        
        [self cols:32 rows:32];
        
    //    firstRun = FALSE;
    //}

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
    [button setBackgroundImage:[self imageWithColor:selectedColor] forState:UIControlStateSelected];
    //get touched button
    long tag = button.tag;
    long tagPintar;
    
    // get the touch
    UITouch *touch = [[event touchesForView:button] anyObject];
    
    // get delta
    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    if(location.x > previousLocation.x) {
        delta_x = delta_x + (location.x - previousLocation.x);
    } else {
        delta_x = delta_x - (location.x - previousLocation.x);
    }
    if(location.y > previousLocation.y) {
        delta_y = delta_y + (location.y - previousLocation.y);
    } else {
        delta_y = delta_y - (location.y - previousLocation.y);
    }
    
    //NSLog(@"delta x = %f", delta_x);
    //NSLog(@"delta y = %f", delta_y);
    
    UIButton *newButton;
    // Calcula o número de quadrados a andar na verticar ou na horizontal
    int horizontal = (int)floorf(delta_x/tamanhoQuadrado);
    int vertical = (int)floorf(delta_y/tamanhoQuadrado);
    
    NSLog(@"Horizontal %i", horizontal);
    NSLog(@"Vertical %i", vertical);

    if(location.x > previousLocation.x) {
        if (location.y > previousLocation.y){
            //newButton = (UIButton *)[self.view viewWithTag:tag+i+(32*vertical)];
            tagPintar = tag+(horizontal)+(rows*vertical);
        } else {
            //newButton = (UIButton *)[self.view viewWithTag:tag+i-(32*vertical)];
            tagPintar = tag+(horizontal)-(rows*vertical);
        }
    } else {
        if (location.y > previousLocation.y){
            //newButton = (UIButton *)[self.view viewWithTag:tag-i+(32*vertical)];
            tagPintar = tag-(horizontal)+(rows*vertical);
        } else {
            //newButton = (UIButton *)[self.view viewWithTag:tag-i-(32*vertical)];
            tagPintar = tag-(horizontal)-(rows*vertical);
        }
    }
    if (tagPintar <= cols * rows ) {
        NSLog(@"tag pintar %li", tagPintar);
        newButton = (UIButton *)[self.view viewWithTag:tagPintar];
        [newButton setBackgroundImage:[self imageWithColor:selectedColor] forState:UIControlStateNormal];
    }

}

- (void)fingerRelease:(UIButton *)button {
    delta_x = 0;
    delta_y = 0;
}

- (IBAction)btnTap:(id)sender {
    
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
    [self performSegueWithIdentifier:@"numerosSegue" sender:sender];
}

- (IBAction)brownColor:(id)sender {
    selectedColor = [UIColor brownColor];
}

- (IBAction)orangeColor:(id)sender {
    selectedColor = [UIColor orangeColor];
}

- (IBAction)yellowColor:(id)sender {
    selectedColor = [UIColor yellowColor];
}

- (IBAction)redColor:(id)sender {
    selectedColor = [UIColor redColor];
}

- (IBAction)magentaColor:(id)sender {
    selectedColor = [UIColor magentaColor];
}

- (IBAction)blackColor:(id)sender {
    selectedColor = [UIColor blackColor];
}

- (IBAction)blueColor:(id)sender {
    selectedColor = [UIColor blueColor];
}

- (IBAction)cianColor:(id)sender {
    selectedColor = [UIColor cyanColor];
}

- (IBAction)greenColor:(id)sender {
    selectedColor = [UIColor greenColor];
}

- (IBAction)lightGrayColor:(id)sender {
    selectedColor = [UIColor colorWithRed:210.0 green:210.0 blue:210.0 alpha:0.5];
}

- (IBAction)grayColor:(id)sender {
    selectedColor = [UIColor colorWithRed:150.0 green:150.0 blue:150.0 alpha:0.0];
}

- (IBAction)whiteColor:(id)sender {
    selectedColor = [UIColor whiteColor];
}

- (IBAction)limpaTabuleiro:(id)sender {
    int total = cols * rows;
    UIButton *button;
    for (int i=1;i<=total;i++) {
        button = (UIButton *)[self.view viewWithTag:i];
        [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    }
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

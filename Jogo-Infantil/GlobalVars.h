//
//  GlobalVars.h
//  Jogo-Infantil
//
//  Created by Jose Dantas on 5/14/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalVars : NSObject
{
    UIViewController *vcOrigem;
}

+ (GlobalVars *)sharedInstance;

@property(strong, nonatomic, readwrite) UIViewController *vcOrigem;

@end

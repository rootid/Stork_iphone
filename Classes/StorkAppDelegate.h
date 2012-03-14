//
//  StorkAppDelegate.h
//  Stork
//
//  Created by Snow Leopard User on 28/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeServerViewController.h"
#import "RemoteServerViewController.h"
#import "Constant.h"
#import "HTTPHandler.h"


@interface StorkAppDelegate : NSObject <UIApplicationDelegate,
                      UITabBarControllerDelegate,HTTPHandlerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

- (void) addViewControllers;
- (void) verfiyHTTP;
@end


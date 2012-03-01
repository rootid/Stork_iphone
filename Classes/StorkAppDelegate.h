//
//  StorkAppDelegate.h
//  Stork
//
//  Created by Snow Leopard User on 28/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface StorkAppDelegate : NSObject <UIApplicationDelegate,
                      UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

- (void) addViewControllers;
@end


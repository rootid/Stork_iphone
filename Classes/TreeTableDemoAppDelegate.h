//
//  TreeTableDemoAppDelegate.h
//  TreeTableDemo
//
//  Created by simone on 9/25/09.
//  Copyright Simone Ardissone 2009. All rights reserved.
//

@interface TreeTableDemoAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end


//
//  StorkAppDelegate.m
//  Stork
//
//  Created by Snow Leopard User on 28/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "StorkAppDelegate.h"


@implementation StorkAppDelegate
@synthesize window;
@synthesize tabBarController;

- (void) verfiyHTTP
{
	HTTPHandler *httpObj=[HTTPHandler getSharedInstantance];
	httpObj.delegate = self;
	[httpObj getPostContentForURL:[NSString stringWithFormat:@"%@",URL_DLS]];
	
}


- (void)connection:(HTTPHandler*)connection didReceiveData:(NSData *)data
{
	NSString* aStr;
	aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	//NSLog(@"Data received \n%@",aStr);
	NSArray *fields = [aStr componentsSeparatedByString:@"\n"];
	int i = 0;
	for ( i = 0; i< [fields count]; i++) {
		
		NSString *file = [fields objectAtIndex:i];
		if([file rangeOfString:@"%"].location == NSNotFound) {
			NSLog(@"%@",file);
		}
		else {
			NSArray *subfields = [file componentsSeparatedByString:@"%"];
			NSLog(@"DIR %@ with file ",[subfields objectAtIndex:0]); //file
			NSLog(@"DIR %@with file %@",[subfields objectAtIndex:1],file); //dir
		}
		
	}
	
}
- (void)connection:(HTTPHandler *)connection didFailWithError:(NSError *)error
{
	NSLog(@"Data failed");
}
#pragma mark -
#pragma mark User defined functions

- (void) addViewControllers
{
	HomeServerViewController *homeController= [[HomeServerViewController alloc]
											   initWithTitle:HOME_SERVER];
	UINavigationController *homeNavigationController= [[UINavigationController alloc]
													   initWithRootViewController:homeController];
	
	
	RemoteServerViewController *remoteController= [[RemoteServerViewController alloc]
												   initWithTitle:REMOTE_SERVER];
	UINavigationController *remoteNavigationController= [[UINavigationController alloc]
														 initWithRootViewController:remoteController];
	

	NSArray *viewControllerArray = [[NSArray alloc] initWithObjects:homeNavigationController
									,remoteNavigationController,nil];
	
	tabBarController = [[UITabBarController alloc]initWithNibName:nil bundle:nil];
	
	[tabBarController setViewControllers:viewControllerArray animated:YES];
	[tabBarController setDelegate:self];
	[(UIViewController *)[tabBarController.viewControllers objectAtIndex:0] setTitle:HOME_SERVER];
	[(UIViewController *)[tabBarController.viewControllers objectAtIndex:1] setTitle:REMOTE_SERVER];
	
	[self.window addSubview:tabBarController.view];
	
	[viewControllerArray release];
	[homeController release];
	[remoteController release];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
	//[self verfiyHTTP];
    
	[self addViewControllers];

    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    //[viewController release];
    [window release];
    [super dealloc];
}


@end

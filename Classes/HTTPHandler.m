//
//  HTTPHandler.m
//  Stork
//
//  Created by Snow Leopard User on 07/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "HTTPHandler.h"

@implementation HTTPHandler
@synthesize delegate;

+(HTTPHandler*)getSharedInstantance
{
	static HTTPHandler* handler=nil;
	if(handler==nil)
	{
		handler=[[HTTPHandler alloc] init];
	}
	return handler;
}


- (void) dealloc
{
	[recivedData release];
	recivedData=nil;
	
	[super dealloc];
}

-(void)getContentForURL:(NSString*)aURL
{
	NSLog(@"%@",aURL);
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:aURL]];
	
	
	theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self]; 
	
	if (theConnection){
		[recivedData release];
		recivedData=[[NSMutableData alloc] init];
	}else{ 
		NSLog(@"ERROR IN CONNECTION!");
	}
	
}

-(void)cancelConnection
{
	[theConnection cancel];
	[theConnection release];
	theConnection=nil;
}

//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if([challenge previousFailureCount]==0)
	{
		NSURLCredential *newCredential;
		//Enter Persistent Cridential 
		newCredential=[NSURLCredential credentialWithUser:@"vikramsi"		
												 password:@"sunrisE!23"
											  persistence:NSURLCredentialPersistenceNone];
		[[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
		
	}
	else {
		[[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
	}
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSLog(@"RESPONSE :: %@",[response description]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[recivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"connectionDidFinishLoading");
	if(delegate)
	{
		[delegate connection:self didReceiveData:recivedData];
	}
	[self cancelConnection];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR :%@",[error description]);
	if(delegate)
	{
		[delegate connection:self didFailWithError:error];
	}
}


@end

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


-(void)getPostContentForURL:(NSString*)aURL
{
	NSLog(@"%@",aURL);
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:aURL]];
	
	NSString *userName = @"earslan";
	NSString *password = @"Ilknur58*";
	NSString *ftpName =  @"login1.ls4.tacc.utexas.edu";
	//ftp%rishibaldawa.com%21%.%enesy%didclab202!
	const char *bytes = [[NSString stringWithFormat:@"client_info=sftp%%%@%%22%%.%%%@%%%@",
						ftpName,userName,password] UTF8String];
	NSString *req_para = @"sftp%login1.ls4.tacc.utexas.edu%22%./%earslan%Ilknur58*%";
	//const char *bytes = [[NSString stringWithFormat:@"client_info=%@",req_para] UTF8String];
	//http://184.73.223.158:8080/StorkDirectoryService/dls/list
	//sftp%login1.ls4.tacc.utexas.edu%22%./%earslan%Ilknur58*%
	
	//NSString *str = @"sftp%%login1.ls4.tacc.utexas.edu%%22%%./%%earslan%%Ilknur58*%%";
	//const char *bytes = [str UTF8String];
	NSString *str = [NSString stringWithFormat:@"client_info=sftp%%%@%%22%%.%%%@%%%@",
					 ftpName,userName,password];
	NSLog(@"Thr data :%@ with url %@",str,aURL);
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSData dataWithBytes:bytes length:strlen(bytes)]];
	//[request addValue:str forHTTPHeaderField:@"Content-Type"];
	NSURLResponse * response = nil;
	NSError * err = nil;
	NSData * data = [NSURLConnection sendSynchronousRequest:request 
										  returningResponse: &response error: &err];
	NSString *sData = [NSString stringWithUTF8String:[data bytes]];
	if(err != nil) {
		printf("Error while retrieving URL contents: %s\n", [[err description] UTF8String]);
	} else {
		printf("Got %d bytes from server\n", [data length]);
		NSLog(@"All data response %@",sData);
	}
	
	
	
//	theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self]; 
//	
//	if (theConnection){
//		[recivedData release];
//		recivedData=[[NSMutableData alloc] init];
//	}else{ 
//		NSLog(@"ERROR IN CONNECTION!");
//	}
	
}


-(void)getPostContentForURL1:(NSString*)aURL
{
	
	NSString *userName = @"earslan";
	NSString *password = @"Ilknur58*";
	NSString *ftpName =  @"login1.ls4.tacc.utexas.edu";
	NSURLResponse * response = nil;
	NSError * err = nil;
	
	NSLog(@"%@",aURL);
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:aURL]];
	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];	
	
	NSString *test = @"client_info=sftp%25login1.ls4.tacc.utexas.edu%2522%25.%2F%25earslan%25Ilknur58*%25";
	/*
	 now lets create the body of the request.
	 */
//	NSString *boundary = [NSString stringWithString:@"---------------------------Boundary Line---------------------------"];
	NSMutableData *body = [NSMutableData data];
//	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary]
//					 dataUsingEncoding:NSUTF8StringEncoding]];  
	//[body appendData:[[NSString stringWithFormat:@"client_info=sftp%%%@%%22%%.%%%@%%%@"
//					  ,ftpName,userName,password] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[test dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	// set body with request.
	[request setHTTPBody:body];
	[request addValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
	//NSData * data = [NSURLConnection sendSynchronousRequest:request 
//										  returningResponse: &response error: &err];
//	NSString *sData = [NSString stringWithUTF8String:[data bytes]];
//	if(err != nil) {
//		printf("Error while retrieving URL contents: %s\n", [[err description] UTF8String]);
//	} else {
//		printf("Got %d bytes from server\n", [data length]);
//		NSLog(@"All data response %@",sData);
//		
//	}
	
	
	
		theConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self]; 
		
		if (theConnection){
			[recivedData release];
			recivedData=[[NSMutableData alloc] init];
		}else{ 
			NSLog(@"ERROR IN CONNECTION!");
		}
	
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

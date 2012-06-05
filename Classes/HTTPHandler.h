//
//  HTTPHandler.h
//  Stork
//
//  Created by Snow Leopard User on 07/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "ServerInformation.h"
@class HTTPHandler;

@protocol HTTPHandlerDelegate

- (void)connection:(HTTPHandler*)connection didReceiveData:(NSData *)data;
- (void)connection:(HTTPHandler *)connection didFailWithError:(NSError *)error;

@end

@interface HTTPHandler : NSObject {
	
	id<HTTPHandlerDelegate> delegate;
	NSURLConnection*	theConnection;
	NSMutableData *recivedData;
}

@property (nonatomic, retain) id<HTTPHandlerDelegate> delegate;

+(HTTPHandler*)getSharedInstantance;

-(void)getContentForURL :(NSString*)aURL;
-(void)getPostContentForURL:(NSString*)aURL;
-(void)getPostContentForURL2:(NSString*)aURL;
-(void)cancelConnection;
-(void)getPostContentForURL1:(NSString *)aURL information:(ServerInformation *)aServerInfo;

@end

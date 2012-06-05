//
//  ServerInformation.h
//  Stork
//
//  Created by Snow Leopard User on 17/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//There are 2 types of notations 1.object(needs NsString*) 2.scalar(needs only assign)

@interface ServerInformation : NSObject {
	NSString *userName;
	NSString *passWord;
	NSString *pathName;
	NSInteger portNumber;	
	NSString *protoCol;
	NSString *serverName;
	
}
@property(nonatomic,retain) NSString* userName;
@property(nonatomic,retain) NSString* passWord;
@property(nonatomic,retain) NSString* pathName;
@property(nonatomic,retain) NSString* protoCol;
@property(nonatomic,retain) NSString* serverName;
@property(nonatomic,assign) NSInteger portNumber;
@end

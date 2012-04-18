//
//  ServerInformation.h
//  Stork
//
//  Created by Snow Leopard User on 17/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerInformation : NSObject {
	NSString *userName;
	NSString *passWord;
	NSString *path;
	int portNumber;	
	NSString *protoCol;
	
}
@property(nonatomic,retain) NSString* userName;
@property(nonatomic,retain) NSString* passWord;
@property(nonatomic,retain) NSString* path;
@property(nonatomic,retain) NSString* protoCol;
@end

//
//  DataAdapter.h
//  Stork
//
//  Created by Snow Leopard User on 29/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataAdapter : NSObject {

	NSArray *serverList;
	NSArray *folderList;
}

@property (nonatomic, retain) NSArray *serverList;
@property (nonatomic, retain) NSArray *folderList;

- (void) initializeServerList;
- (void) initializeDirList;

@end

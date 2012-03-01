//
//  ServerListView.h
//  Stork
//
//  Created by Snow Leopard User on 28/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ServerListViewCell : UITableViewCell {
	
	UILabel *serverNameLable;

}

-(void)setServerNameLabel :(NSString *)serverNamelbl;

@end

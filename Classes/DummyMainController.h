//
//  DummyMainController.h
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "DLSController.h"

@interface DummyMainController : UIViewController <UITableViewDelegate,
													UITableViewDataSource,
													UITextFieldDelegate>
{
	UITableView * tableView;
	NSMutableArray *viewArray;

}

- (id) initWithController;
-(void)clearAllFields;
-(UILabel *) createLabel:(NSString *)_name;
-(UITextField *) createTextField:(NSInteger)tag title:(NSString *)name;
@end

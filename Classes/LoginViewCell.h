//
//  LoginViewCell.h
//  Stork
//
//  Created by Snow Leopard User on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"

@interface LoginViewCell : UITableViewCell <UITextFieldDelegate>{
	//Username password protocol port button
	UILabel *userNameLabel;
	UILabel *passWordLabel;
	UILabel *protocolName;
	UILabel *portNumber;
	UITextField *userNameText;
	UITextField *passWordText;
	UITextField *protocolText;
	UITextField *portNumberText;
	UIButton *submitButton;
}

@property( nonatomic, retain ) UILabel *userNameLabel;
@property( nonatomic , retain) UILabel *passWordLabel;
@property( nonatomic, retain) UITextField *userNameText;
@property(nonatomic , retain) UITextField *passWordText;
@property(nonatomic , retain) UILabel *protocolName;
@property(nonatomic , retain) UILabel *portNumber;
@property(nonatomic , retain) UITextField *protocolText;
@property(nonatomic , retain) UITextField *portNumberText;
@property(nonatomic , retain) UIButton *submitButton;

-(void) setLabelData;
@end
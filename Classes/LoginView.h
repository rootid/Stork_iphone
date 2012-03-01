//
//  LoginView.h
//  Stork
//
//  Created by Snow Leopard User on 29/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginView : UIView {
	
	UILabel *userNameLabel;
	UILabel *passWordLabel;
	UITextField *userNameText;
	UITextField *passWordText;
	UIButton *submitButton;
	

}

@property( nonatomic, retain ) UILabel *userNameLabel;
@property( nonatomic , retain) UILabel *passWordLabel;
@property( nonatomic, retain) UITextField *userNameText;
@property(nonatomic , retain) UITextField *passWordText;

@end

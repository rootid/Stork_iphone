//
//  DLSCellView.h
//  Stork
//
//  Created by Snow Leopard User on 14/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DLSCellView : UITableViewCell {
	
	UIImageView *tapBoximgView;
	UILabel *folderLable;	

}

-(void)setTapImgView :(UIImage *)img;		
-(void)setlblForFolder :(NSString *)txtForFolder;

@end

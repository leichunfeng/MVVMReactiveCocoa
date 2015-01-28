//
//  SNTXViewController.h
//  OcticonsIOS
//
//  Created by Jackson Harper on 9/24/13.
//  Copyright (c) 2013 Harper Semiconductors, Inc.
//

#import <UIKit/UIKit.h>

@interface SNTXViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *iconName;

- (IBAction)iconButtonTapped:(id)sender;

@end

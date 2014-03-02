//
//  FirstViewController.h
//  HexCalculator
//
//  Created by Robert Miller on 2/7/13.
//  Copyright (c) 2013 Robert Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"


@interface FirstViewController : UIViewController <UITextFieldDelegate>   {
    
    IBOutlet UITextField *hexField;
    IBOutlet UITextField *intField;
    IBOutlet UITextField *floatField;
    IBOutlet UITextField *binField;
    Calculator *firstViewCalculator;
    
}

@property (nonatomic, retain) IBOutlet UITextField *hexField;
@property (nonatomic, retain) IBOutlet UITextField *intField;
@property (nonatomic, retain) IBOutlet UITextField *floatField;
@property (nonatomic, retain) IBOutlet UITextField *binField;
@property (nonatomic, retain) Calculator *firstViewCalculator;

-(IBAction)calculateFields:(id)sender;
-(IBAction)removeKeyboard:(id)sender;
-(IBAction)clearFields:(id)sender;

@end

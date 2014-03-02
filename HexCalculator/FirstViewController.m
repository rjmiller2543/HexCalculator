//
//  FirstViewController.m
//  HexCalculator
//
//  Created by Robert Miller on 2/7/13.
//  Copyright (c) 2013 Robert Miller. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize binField, hexField, intField, floatField;
@synthesize firstViewCalculator;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    binField.text = @"";
    hexField.text = @"";
    intField.text = @"";
    floatField.text = @"";
    
    firstViewCalculator = [[Calculator alloc] init];
}

-(IBAction)calculateFields:(id)sender   {
    
    //NSLog(@"hex num is: %@",[firstViewCalculator hexValueFromInt:intField.text]);
    
    if(![hexField.text isEqualToString: @""])    {
        
        NSLog(@"calculating from hex field");
        
        NSMutableString *temp = [[NSMutableString alloc] initWithString:hexField.text];
        while ([temp length] < 10) {
            
            [temp insertString:@"0" atIndex:2];
            
        }
        
        hexField.text = [temp uppercaseString];
        
        intField.text = [firstViewCalculator intValueFromHex:hexField.text];
        floatField.text = [firstViewCalculator floatValueFromHex:hexField.text];
        binField.text = [firstViewCalculator binValueFromHex:hexField.text];
        
    }
    else if (![binField.text isEqualToString: @""])   {
        
        NSLog(@"Calculating from bin field");
        
        hexField.text = [firstViewCalculator hexValueFromBin:binField.text];
        intField.text = [firstViewCalculator intValueFromBin:binField.text];
        floatField.text = [firstViewCalculator floatValueFromBin:binField.text];
        
    }
    else if (![intField.text isEqualToString: @""])  {
        
        NSLog(@"calculating from int field");
        
        NSLog(@"int field has a value");
        hexField.text = [firstViewCalculator hexValueFromInt:intField.text];
        //floatField.text = [firstViewCalculator floatValueFromInt:intField.text];
        binField.text = [firstViewCalculator binValueFromInt:intField.text];
        
    }
    else if (![floatField.text isEqualToString: @""])    {
        
        NSLog(@"calculating from float field");
        
        //int intPart = (int)[floatField.text floatValue];
        //NSLog(@"int part is: %i",intPart);
        
        hexField.text = [firstViewCalculator hexValueFromFloat:floatField.text];
        intField.text = [firstViewCalculator intValueFromFloat:floatField.text];
        binField.text = [firstViewCalculator binValueFromFloat:floatField.text];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField    {
    
    hexField.text = @"";
    intField.text = @"";
    binField.text = @"";
    floatField.text = @"";
    
}

-(IBAction)removeKeyboard:(id)sender    {
    
    [self.hexField resignFirstResponder];
    [self.intField resignFirstResponder];
    [self.floatField resignFirstResponder];
    [self.binField resignFirstResponder];
    
}

-(IBAction)clearFields:(id)sender   {
    
    hexField.text = @"";
    intField.text = @"";
    binField.text = @"";
    floatField.text = @"";
    
}

@end

//
//  ThirdViewController.m
//  HexCalculator
//
//  Created by Robert Miller on 3/6/13.
//  Copyright (c) 2013 Robert Miller. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize prefixArray, bitsArray, fromBitPicker, fromField, fromPrePicker, toBitPicker, toField, toPrePicker;
@synthesize fromBitString, fromPrefixString, toBitString, toPrefixString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    prefixArray = @[@"", @"Kilo", @"Mega", @"Giga", @"Tera"];
    bitsArray = @[@"bits", @"nibbles", @"Bytes"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data source methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    NSLog(@"RoastPickerView numberOfComponentsInPickerView");
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSLog(@"RoastPickerView pickerView: numberOfRowInComponent");
    
    if (pickerView == toPrePicker || pickerView == fromPrePicker) {
        return 5;
    }
    else
        return 3;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSLog(@"RoastPickerView: titleForRow");
    
    if (pickerView == toPrePicker || pickerView == fromPrePicker) {
        return [prefixArray objectAtIndex:row];
    }
    else
        return [bitsArray objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"RoastPickerView pickerView: didSelectRow");
    
    if (pickerView == toPrePicker) {
        toPrefixString = [prefixArray objectAtIndex:row];
    }
    else if (pickerView == fromPrePicker)   {
        fromPrefixString = [prefixArray objectAtIndex:row];
    }
    else if (pickerView == toBitPicker) {
        toBitString = [bitsArray objectAtIndex:row];
    }
    else    {
        fromBitString = [bitsArray objectAtIndex:row];
    }
    
    [self setFloatFromPickerStrings];
    
}

-(void)setFloatFromPickerStrings    {
    
    
    
}

@end

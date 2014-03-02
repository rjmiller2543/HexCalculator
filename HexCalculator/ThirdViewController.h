//
//  ThirdViewController.h
//  HexCalculator
//
//  Created by Robert Miller on 3/6/13.
//  Copyright (c) 2013 Robert Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController       <UIPickerViewDataSource, UIPickerViewDelegate>  {
    
    NSArray *prefixArray;
    NSArray *bitsArray;
    
    IBOutlet UITextField *fromField;
    IBOutlet UITextField *toField;
    IBOutlet UIPickerView *fromPrePicker;
    IBOutlet UIPickerView *fromBitPicker;
    IBOutlet UIPickerView *toPrePicker;
    IBOutlet UIPickerView *toBitPicker;
    
    NSString *fromPrefixString;
    NSString *toPrefixString;
    NSString *fromBitString;
    NSString *toBitString;
    
    float fromPrefixMultiplier;
    float toPrefixMultiplier;
    float fromBitMultiplier;
    float toBitMultiplier;
    
}

@property (nonatomic, retain) NSArray *prefixArray;
@property (nonatomic, retain) NSArray *bitsArray;

@property (nonatomic, retain) IBOutlet UITextField *fromField;
@property (nonatomic, retain) IBOutlet UITextField *toField;
@property (nonatomic, retain) IBOutlet UIPickerView *fromPrePicker;
@property (nonatomic, retain) IBOutlet UIPickerView *fromBitPicker;
@property (nonatomic, retain) IBOutlet UIPickerView *toPrePicker;
@property (nonatomic, retain) IBOutlet UIPickerView *toBitPicker;

@property (nonatomic, retain) NSString *fromPrefixString;
@property (nonatomic, retain) NSString *toPrefixString;
@property (nonatomic, retain) NSString *fromBitString;
@property (nonatomic, retain) NSString *toBitString;

@end

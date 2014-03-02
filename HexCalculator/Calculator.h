//
//  Calculator.h
//  HexCalculator
//
//  Created by Robert Miller on 2/7/13.
//  Copyright (c) 2013 Robert Miller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject    {
    
     
    
}

//Hex Conversions
-(NSString *)hexValueFromUInt:(NSString *)toBeConverted;
-(NSString *)hexValueFromInt:(NSString *)toBeConverted;
-(NSString *)hexValueFromFloat:(NSString *)toBeConverted;
-(NSString *)hexValueFromBin:(NSString *)toBeConverted;

//Int Conversions
-(NSString *)intValueFromHex:(NSString *)toBeConverted;
-(NSString *)intValueFromUInt:(NSString *)toBeConverted;
-(NSString *)intValueFromFloat:(NSString *)toBeConverted;
-(NSString *)intValueFromBin:(NSString *)toBeConverted;

//Unsigned Int Conversions
-(NSString *)uIntValueFromHex:(NSString *)toBeConverted;
-(NSString *)uIntValueFromInt:(NSString *)toBeConverted;
-(NSString *)uIntValueFromFloat:(NSString *)toBeConverted;
-(NSString *)uIntValueFromBin:(NSString *)toBeConverted;

//Float Conversions
-(NSString *)floatValueFromHex:(NSString *)toBeConverted;
-(NSString *)floatValueFromInt:(NSString *)toBeConverted;
-(NSString *)floatValueFromUInt:(NSString *)toBeConverted;
-(NSString *)floatValueFromBin:(NSString *)toBeConverted;

//Binary Conversions
-(NSString *)binValueFromHex:(NSString *)toBeConverted;
-(NSString *)binValueFromInt:(NSString *)toBeConverted;
-(NSString *)binValueFromUInt:(NSString *)toBeConverted;
-(NSString *)binValueFromFloat:(NSString *)toBeConverted;

//Bit/Bit Conversions
-(NSString *)bitFromKBit:(NSString *)toBeConverted;
-(NSString *)bitFromMBit:(NSString *)toBeConverted;
-(NSString *)bitFromGBit:(NSString *)toBeConverted;
-(NSString *)bitFromTBit:(NSString *)toBeConverted;

//Bit/Byte Conversions
-(NSString *)bitFromByte:(NSString *)toBeConverted;
-(NSString *)bitFromKByte:(NSString *)toBeConverted;
-(NSString *)bitFromMByte:(NSString *)toBeConverted;
-(NSString *)bitFromGByte:(NSString *)toBeConverted;
-(NSString *)bitFromTByte:(NSString *)toBeConverted;

//Byte/Bit Conversions
-(NSString *)byteFromBit:(NSString *)toBeConverted;
-(NSString *)byteFromKBit:(NSString *)toBeConverted;
-(NSString *)byteFromMBit:(NSString *)toBeConverted;
-(NSString *)byteFromGBit:(NSString *)toBeConverted;
-(NSString *)byteFromTBit:(NSString *)toBeConverted;

//Byte/Byte Conversions
-(NSString *)byteFromKByte:(NSString *)toBeConverted;
-(NSString *)byteFromMByte:(NSString *)toBeConverted;
-(NSString *)byteFromGByte:(NSString *)toBeConverted;
-(NSString *)byteFromTByte:(NSString *)toBeConverted;

@end

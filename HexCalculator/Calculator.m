//
//  Calculator.m
//  HexCalculator
//
//  Created by Robert Miller on 2/7/13.
//  Copyright (c) 2013 Robert Miller. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

/***********************************************\
            Conversion Methods:
 
 The following conversion methods work exactly
 as described ALWAYS in 32-bit.  It is the
 objects responsibility to send a 32-bit word
 otherwise the app will crash.
 
\***********************************************/

#pragma mark - Hex Conversion Methods

  /////////////////////////////////////
 //     Hex Conversion Methods      //
/////////////////////////////////////

-(NSString *)hexValueFromInt:(NSString *)toBeConverted  {
    
    NSLog(@"Hex Value from Int: %@",toBeConverted);
    
    int checkForMinus = [toBeConverted intValue];
    NSLog(@"The Check is: %i",checkForMinus);
    if (checkForMinus < 0) {
        
        NSNumber *temp = [[NSNumber alloc] initWithInt:checkForMinus * -1];
        NSString *binRep = [self binValueFromUInt:[temp stringValue]];
        NSString *twosRep = [self twosComplement:binRep];
        NSString *hexRep = [self hexValueFromUInt:twosRep];
        return hexRep;
        
    }
    
    else    {
        
        NSString *temp = [self binValueFromUInt:toBeConverted];
        return [self hexValueFromBin:temp];
        
    }
    
}

-(NSString *)hexValueFromUInt:(NSString *)toBeConverted {
    
    NSLog(@"Hex Value from UInt");
    
    NSString *temp = [self binValueFromUInt:toBeConverted];
    return [self hexValueFromBin:temp];
    
}

-(NSString *)hexValueFromFloat:(NSString *)toBeConverted    {
    
    NSLog(@"Hex Value from Float");
    
    return [self hexValueFromBin:[self binValueFromFloat:toBeConverted]];
    
    //return @"Not Yet Working";
    
}

-(NSString *)hexValueFromBin:(NSString *)toBeConverted  {
    
    NSString *output = @"0x";
    
    //NSString *tempBinValue = [self binValueFromUInt:toBeConverted];
    for (int i = 0; i < 36; i+=5) {
        
        NSLog(@"i is: %i",i);
        NSRange newRange = NSMakeRange(i, 4);
        NSString *tempNibble = [toBeConverted substringWithRange:newRange];
        NSLog(@"Temp Nibble is: %@",tempNibble);
        output = [output stringByAppendingString:[self bin2Hex:tempNibble]];
        tempNibble = @"";
        
    }
    
    NSLog(@"Hex Value is: %@",output);
    return output;
    
}


#pragma mark - Binary Conversion Methods

  //////////////////////////////////
 //  Binary Conversion Methods   //
//////////////////////////////////

-(NSString *)binValueFromInt:(NSString *)toBeConverted  {
    
    int checkForMinus = [toBeConverted intValue];
    NSLog(@"The Check is: %i",checkForMinus);
    if (checkForMinus < 0) {
        
        NSNumber *temp = [[NSNumber alloc] initWithInt:checkForMinus * -1];
        NSString *binRep = [self binValueFromUInt:[temp stringValue]];
        NSString *twosRep = [self twosComplement:binRep];
        NSString *output = @"";
        for (int i = 0; i < 8; i++) {
            
            output = [output stringByAppendingString:[twosRep substringWithRange:NSMakeRange(i*4, 4)]];
            output = [output stringByAppendingString:@" "];
            
        }
        //NSString *hexRep = [self hexValueFromUInt:twosRep];
        return output;
        
    }
    
    else    {
        
        NSString *output = [self binValueFromUInt:toBeConverted];
        return output;
        
    }
    
}

-(NSString *)binValueFromUInt:(NSString *)toBeConverted {
    
    NSLog(@"Bin Value from UInt: %@",toBeConverted);
    
    int check = [toBeConverted intValue];
    int temp = 0;
    int spaceCount = 0;
    //NSString *output = [[NSString alloc] init];
    NSString *output = @"";
    
    for (int i = 31; i > -1; i--) {
        
        //to add a space divider for nibbles
        if (spaceCount > 3) {
            
            output = [output stringByAppendingString:@" "];
            spaceCount = 0;
            
        }
        spaceCount++;
        
        //if temp is negative, then that number is not in the binary calculation
        temp = check - pow(2, i);
        if (temp >= 0) {
            
            output = [output stringByAppendingString:@"1"];
            check = check - pow(2, i);
            
        }
        else    {
            
            output = [output stringByAppendingString:@"0"];
            
        }
    }
    
    NSLog(@"The Bin Number is: %@", output);
    
    return output;
    
}

-(NSString *)binValueFromHex:(NSString *)toBeConverted  {
    
    NSLog(@"Bin Value from Hex");
    
    NSString *output = @"";
    
    for (int i = 0; i < 8; i++) {
        
        NSRange newRange = NSMakeRange(i+2, 1);
        NSString *tempNibble = [toBeConverted substringWithRange:newRange];
        output = [output stringByAppendingString:[self hex2Bin:tempNibble]];
        output = [output stringByAppendingString:@" "];
        
    }
    
    //return @"Not Yet Working";
    
    return output;
    
}

-(NSString *)binValueFromFloat:(NSString *)toBeConverted    {
    
    NSLog(@"Bin Value from Float");
    
    NSString *output = @"";
    
    //Check if the float is +/- and set the first bit accordingly
    float checkForMinus = [toBeConverted floatValue];
    if (checkForMinus < 0) {
        
        checkForMinus *= -1;
        
        output = [output stringByAppendingString:@"1"];
    
    }
    else    {
    
        output = [output stringByAppendingString:@"0"];
    
    }
    
    //separate the integer and the decimal
    int intPart = (int)checkForMinus;
    float decPart = checkForMinus - intPart;
    
    //find out how big the number is to know the exponent and how many bits of the mantissa belong to the integer
    //and how many bits of the mantissa belong to the decimal
    int counter = 0;
    while (1)
    {
        if (pow(2, counter) > intPart) {
            
            counter--;
            break;
            
        }
        counter++;
    }
    
    int intExponent = counter, decimalStart = counter-1;
    int decimalStop = 24 - decimalStart;
    
    NSString *mantissa = @"";
    
    for (int i = 0; i <= counter; i++) {
        if ((intPart - pow(2, counter - i)) >= 0) {
            
            intPart = intPart - pow(2, counter - i);
            mantissa = [mantissa stringByAppendingString:@"1"];
            
        }
        else    {
            
            mantissa = [mantissa stringByAppendingString:@"0"];
            
        }
    }
    
    NSLog(@"int mantissa: %@",mantissa);
    
    for (int i = 1; i < decimalStop; i++) {
        if ((decPart - pow(2, -i)) >= 0) {
            
            decPart = decPart - pow(2, -i);
            mantissa = [mantissa stringByAppendingString:@"1"];
            
        }
        else    {
            
            mantissa = [mantissa stringByAppendingString:@"0"];
            
        }
    }
    
    NSLog(@"mantissa is: %@", mantissa);
    
    NSNumber *exponentNumber = [[NSNumber alloc] initWithInt:127 + intExponent];
    NSString *exponentString = [[self binValueFromUInt:[exponentNumber stringValue]] substringWithRange:NSMakeRange(30, 9)];
    NSString *temporaryOutput = @"";
    temporaryOutput = [temporaryOutput stringByAppendingString:[exponentString stringByReplacingOccurrencesOfString:@" " withString:@""]];
    temporaryOutput = [temporaryOutput stringByAppendingString:[mantissa substringWithRange:NSMakeRange(1, [mantissa length]-1)]];
    
    NSLog(@"temporary output is: %@", temporaryOutput);
    
    int spaceCounter = 1;
    for (int i = 0; i < 31; i++) {
        
        if (spaceCounter > 3) {
            
            spaceCounter = 1;
            NSRange newRange = NSMakeRange(i, 1);
            output = [output stringByAppendingString:@" "];
            output = [output stringByAppendingString:[temporaryOutput substringWithRange:newRange]];
            
        }
        else    {
            
            output = [output stringByAppendingString:[temporaryOutput substringWithRange:NSMakeRange(i, 1)]];
            spaceCounter++;
            
        }
        
    }
    
    
    return output;
    
}


  //////////////////////////////////////////////////
 //     Unsigned Integer Conversion Methods      //
//////////////////////////////////////////////////

#pragma mark - Unsinged Integer Conversion Methods

//Unsigned Int Conversions
-(NSString *)uIntValueFromHex:(NSString *)toBeConverted {
    
    NSLog(@"UInt Value from Hex");
    
    return [self uIntValueFromBin:[self binValueFromHex:toBeConverted]];
    
}
-(NSString *)uIntValueFromInt:(NSString *)toBeConverted {
    
    NSLog(@"UInt Value from Int");
    
    return [self uIntValueFromBin:[self binValueFromInt:toBeConverted]];
    
}
-(NSString *)uIntValueFromFloat:(NSString *)toBeConverted   {
    
    NSLog(@"UInt Value from Float");
    
    return [self uIntValueFromBin:[self binValueFromFloat:toBeConverted]];
    
}
-(NSString *)uIntValueFromBin:(NSString *)toBeConverted {
    
    NSLog(@"UInt Value from Bin");
    
    int temp = 0;
    NSString *checkString = [toBeConverted stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"checkstring length is: %i", [checkString length]);
    NSString *output = @"";
    
    for (int i = 0; i < 32; i++) {
        
        NSLog(@"i is: %i", i);
        if ([checkString characterAtIndex:i] == '1') {
            
            NSLog(@"char %i was 1",i);
            temp += pow(2, 31-i);
            
        }
        
    }
    
    return [output stringByAppendingString:[[[NSNumber alloc] initWithInt:temp] stringValue]];
    
}


  ///////////////////////////////////////
 //     Float Conversion Methods      //
///////////////////////////////////////

#pragma mark - Float Conversion Methods

//Float Conversions
-(NSString *)floatValueFromHex:(NSString *)toBeConverted    {
    
    NSLog(@"Float Value from Hex");
    
    return [self floatValueFromBin:[self binValueFromHex:toBeConverted]];
    
}
-(NSString *)floatValueFromInt:(NSString *)toBeConverted    {
    
    NSLog(@"Float Value from Int");
    
    return [self floatValueFromBin:[self binValueFromInt:toBeConverted]];
    //return @"Not yet working";
    
}
-(NSString *)floatValueFromUInt:(NSString *)toBeConverted   {
    
    NSLog(@"Float Value from UInt");
    
    //return [self floatValueFromBin:[self binValueFromUInt:toBeConverted]];
    return @"Not yet working";
    
}
-(NSString *)floatValueFromBin:(NSString *)toBeConverted    {
    
    NSLog(@"Float Value from Bin");
    
    NSString *toBeConvertedNoSpaces = [toBeConverted stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *output = @"";
    if ([toBeConverted characterAtIndex:0] == '1') {
        
        output = [output stringByAppendingString:@"-"];
        
    }
    
    NSString *exponentByte = @"000000000000000000000000";
    exponentByte = [exponentByte stringByAppendingString:[toBeConvertedNoSpaces substringWithRange:NSMakeRange(1, 8)]];
    NSString *sendToCon = @"";
    
    int spaceCounter = 0;
    for (int i = 0; i < 8; i++) {
        if (spaceCounter < 4) {
            
            sendToCon = [sendToCon stringByAppendingString:[exponentByte substringWithRange:NSMakeRange(i*4, 4)]];
            sendToCon = [sendToCon stringByAppendingString:@" "];
            
        }
    }
    
    int exponentInt = [[self intValueFromBin:sendToCon] intValue] - 127;
    
    NSLog(@"exponent int is: %i", exponentInt);
    int reachPointOfMantissa;
    
    if (exponentInt < 0) {
        
        reachPointOfMantissa = 0;
        
    }
    else    {
        
        reachPointOfMantissa = exponentInt;
        
    }
    
    NSString *mantissa = [toBeConvertedNoSpaces substringWithRange:NSMakeRange(9, 23)];
    NSString *intMantissa = @"1";
    intMantissa = [intMantissa stringByAppendingString:[mantissa substringWithRange:NSMakeRange(0, reachPointOfMantissa)]];
    NSString *decMantissa = [mantissa substringWithRange:NSMakeRange(reachPointOfMantissa, 23 - reachPointOfMantissa)];
    
    NSString *sendIntMantissaNoSpaces = @"";
    for (int i = 0; i < (32 - 1 - reachPointOfMantissa); i++) {
        
        sendIntMantissaNoSpaces = [sendIntMantissaNoSpaces stringByAppendingString:@"0"];
        
    }
    
    sendIntMantissaNoSpaces = [sendIntMantissaNoSpaces stringByAppendingString:intMantissa];
    NSString *sendIntMantissa = @"";
    
    for (int i = 0; i < 8; i++) {
        
        sendIntMantissa = [sendIntMantissa stringByAppendingString:[sendIntMantissaNoSpaces substringWithRange:NSMakeRange(i*4, 4)]];
        sendIntMantissa = [sendIntMantissa stringByAppendingString:@" "];
        
    }
    
    int intFromMantissa = [[self intValueFromBin:sendIntMantissa] intValue];
    
    for (int i = 0; i < (32 - 23 + reachPointOfMantissa); i++) {
        
        decMantissa = [decMantissa stringByAppendingString:@"0"];
        
    }
    
    float decFromMantissa = [self decimalFromMantissa:decMantissa];
    float floatMantissa = intFromMantissa + decFromMantissa;
    //float outputFloat = floatMantissa * powf(10, exponentInt-1);
    
    //output = [[[NSNumber alloc] initWithFloat:outputFloat] stringValue];
    
    output = [output stringByAppendingString:[[[NSNumber alloc] initWithFloat:floatMantissa] stringValue]];
    
    //create the mantissa integer value using the exponent
    //create the mantissa decimal value
    //add the int and dec together
    //multiply by the 10^exponent
    //create nsnumber with float
    //create nsstring with nsnumber
    
    return output;
    
}

-(float)decimalFromMantissa:(NSString *)decimalMantissa {
    
    NSLog(@"decimal from mantissa: %@", decimalMantissa);
    
    float output = 0;
    for (int i = 0; i < 32; i++) {
        if ([decimalMantissa characterAtIndex:i] == '1') {
            output += powf(2, -(i+1));
        }
    }
    
    return output;
    
}


  /////////////////////////////////////////
 //     Integer Conversion Methods      //
/////////////////////////////////////////

#pragma mark - Integer Conversion Methods

//Int Conversions
-(NSString *)intValueFromHex:(NSString *)toBeConverted  {
    
    NSLog(@"Int Value from Hex");
    
    NSString *output = @"";
    
    for (int i = 0; i < 8; i++) {
        
        NSRange newRange = NSMakeRange(i+2, 1);
        NSString *tempNibble = [toBeConverted substringWithRange:newRange];
        output = [output stringByAppendingString:[self hex2Bin:tempNibble]];
        output = [output stringByAppendingString:@" "];
        
    }
    
    return [self intValueFromBin:output];
    
}   
-(NSString *)intValueFromUInt:(NSString *)toBeConverted {
    
    NSLog(@"Int Value from UInt");
    
    return toBeConverted;
    
}
-(NSString *)intValueFromFloat:(NSString *)toBeConverted    {
    
    NSLog(@"Int Value from Float");
    
    return [self intValueFromBin:[self binValueFromFloat:toBeConverted]];
    
}
-(NSString *)intValueFromBin:(NSString *)toBeConverted  {
    
    NSLog(@"Int Value from Bin: %@", toBeConverted);
    
    int temp = 0;
    NSString *checkString = [toBeConverted stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"checkstring length is: %i", [checkString length]);
    NSString *output = @"";
    if ([toBeConverted characterAtIndex:0] == '1') {
        
        output = @"-";
        
    }
    
    for (int i = 0; i < 31; i++) {
        
        NSLog(@"i is: %i", i);
        if ([checkString characterAtIndex:i+1] == '1') {
            
            NSLog(@"char %i was 1",i);
            temp += pow(2, 30-i);
            
        }
        
    }
    
    return [output stringByAppendingString:[[[NSNumber alloc] initWithInt:temp] stringValue]];
    
}


#pragma mark - Single Nibble Binary Converter

  /////////////////////////////////////////////////////
 //     Methods to Deal with Binary/Hex Nibbles     //
/////////////////////////////////////////////////////


/***************************************************\
                Hex2Bin:
 
 Takes a single hex character and returns a binary
 nibble.
 
\***************************************************/

-(NSString *)hex2Bin:(NSString *)nibble    {
    
    NSLog(@"Hex To Bin");
    //nibble = [nibble uppercaseString];
    
    if ([nibble isEqualToString:@"0"])          return @"0000";
    else if ([nibble isEqualToString:@"1"])     return @"0001";
    else if ([nibble isEqualToString:@"2"])     return @"0010";
    else if ([nibble isEqualToString:@"3"])     return @"0011";
    else if ([nibble isEqualToString:@"4"])     return @"0100";
    else if ([nibble isEqualToString:@"5"])     return @"0101";
    else if ([nibble isEqualToString:@"6"])     return @"0110";
    else if ([nibble isEqualToString:@"7"])     return @"0111";
    else if ([nibble isEqualToString:@"8"])     return @"1000";
    else if ([nibble isEqualToString:@"9"])     return @"1001";
    else if ([nibble isEqualToString:@"A"])     return @"1010";
    else if ([nibble isEqualToString:@"B"])     return @"1011";
    else if ([nibble isEqualToString:@"C"])     return @"1100";
    else if ([nibble isEqualToString:@"D"])     return @"1101";
    else if ([nibble isEqualToString:@"E"])     return @"1110";
    else if ([nibble isEqualToString:@"F"])     return @"1111";
    else                                        return @"Illegal Character";
    
}

/*******************************************\
                Bin2Hex:
 
 Calculates a single binary nibble and
 returns a single hex character 
 
\*******************************************/


-(NSString *)bin2Hex:(NSString *)nibble    {
    
    NSLog(@"Bin To Hex");
    
    float total = 0;
    for (int i = 3; i > -1; i--) {
        if ([nibble characterAtIndex:i] == '1') {
            total += powf(2, 3-i);
        }
    }
    if (total == 0)          return @"0";
    else if (total == 1)     return @"1";
    else if (total == 2)     return @"2";
    else if (total == 3)     return @"3";
    else if (total == 4)     return @"4";
    else if (total == 5)     return @"5";
    else if (total == 6)     return @"6";
    else if (total == 7)     return @"7";
    else if (total == 8)     return @"8";
    else if (total == 9)     return @"9";
    else if (total == 10)    return @"A";
    else if (total == 11)    return @"B";
    else if (total == 12)    return @"C";
    else if (total == 13)    return @"D";
    else if (total == 14)    return @"E";
    else if (total == 15)    return @"F";
    else                     return @"Illegal Character";
    
}


/************************************************\
                2's Complement:
 
 Takes in a binary word of arbitrary length and
 will return the inverted binary + 1.  Even if
 the object sends a word with spaces, the method
 will NOT return a word with spaces.  It is the
 object's responsibility to add the spaces.
 
\************************************************/


-(NSString *)twosComplement:(NSString *)word    {
    
    NSString *wordNoSpaces = [word stringByReplacingOccurrencesOfString:@" " withString:@""];
    int wordLength = [word length];
    
    NSString *wordInverted = @"";
    for (int i = 0; i < wordLength; i++) {
        
        if ([wordNoSpaces characterAtIndex:i] == '1') {
            
            wordInverted = [wordInverted stringByAppendingString:@"0"];
        
        }
        else    {
            
            wordInverted = [wordInverted stringByAppendingString:@"1"];
            
        }
        
    }
    
    NSString *output = @"";
    NSString *carryBit = @"1";
    for (int i = wordLength; i > -1; --i) {
        
        if ([wordInverted characterAtIndex:i] == '1' && [carryBit isEqualToString:@"1"]) {
            
            output = [output stringByAppendingString:@"0"];
            carryBit = @"1";
            
        }
        else if ([wordInverted characterAtIndex:i] == '0' && [carryBit isEqualToString:@"1"]) {
            
            output = [output stringByAppendingString:@"1"];
            carryBit = @"0";
            
        }
        else if ([wordInverted characterAtIndex:i] == '1' && [carryBit isEqualToString:@"0"])   {
            
            output = [output stringByAppendingString:@"1"];
            carryBit = @"0";
            
        }
        else if ([wordInverted characterAtIndex:i] == '0' && [carryBit  isEqualToString:@"0"])  {
            
            output = [output stringByAppendingString:@"0"];
            carryBit = @"0";
            
        }
        
    }
    
    return output;
    
}

#pragma mark - BIT/BYTE Converters

  /////////////////////////////////////////////////////////////////////
 //     Methods to convert from number of bits to bytes, etc..      //
/////////////////////////////////////////////////////////////////////



@end

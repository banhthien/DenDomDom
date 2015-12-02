//
//  TFUtil.m
//  ShopOnline
//
//  Created by Long Dang on 8/6/15.
//  Copyright (c) 2015 tflat. All rights reserved.
//

#import "TFUtil.h"
//#import <AFNetworking/AFNetworking.h>

@implementation TFUtil


+ (NSString *)checkStringFromDictValue:(NSString *)sDictValue
{
    if ([sDictValue.class isSubclassOfClass:[NSString class]])
    {
        NSString *rString;
        if (sDictValue == (id)[NSNull null])
        {
            rString = @"";
        }
        else
        {
            rString = sDictValue;
        }
        return rString;
    }
    
    return @"";
}

/**
 * CalculatorString with font for width
 *
 *
 **/
+ (CGRect)calculatorSizeString:(NSString *)sString withFont:(UIFont *)sFont forWidth:(NSInteger)sWith
{
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize labelSize = (CGSize){sWith, FLT_MAX};
    CGRect size = [sString boundingRectWithSize:labelSize
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:sFont}
                                        context:context];
    return size;
}

/**
 * CalculatorString for width
 *
 *
 **/


+ (UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

/**
 *  Bounce animation
 *
 *  @param animateView
 *  @param startScale
 *  @param andScale
 */
+ (void)bounceViewAnimate:(UIView *)animateView startScale:(float)startScale endScale:(float)endScale
{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         animateView.transform = CGAffineTransformMakeScale(startScale, startScale);
                         
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.3
                                               delay:0.0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              
                                              animateView.transform = CGAffineTransformMakeScale(endScale, endScale);
                                              
                                          }
                                          completion:^(BOOL finished){
                                              
                                          }];
                     }];
}

/**
 *  strim character
 *
 *  @param char
 *  @param string
 */

+ (NSString *)strimCharacter:(char)c string:(NSString *)str
{
    if([str characterAtIndex:0] == c)
    {
        //NSLog(@"remove first char");
        str = [str substringFromIndex:1];
    }
    
    int lenght = (int)str.length;
    if ([str characterAtIndex:lenght-1] == c)
    {
        //NSLog(@"remove last char");
        str = [str substringWithRange:NSMakeRange(0, lenght - 1)];
    }
    
    return str;
}

#pragma mark - Sign up
+ (BOOL)isValidEmail:(NSString *)sEmailString
{
    BOOL tStricterFilter = NO;
    NSString *tStricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *tLaxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *tEmailRegex = tStricterFilter ? tStricterFilterString : tLaxString;
    NSPredicate *tEmailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tEmailRegex];
    return [tEmailTest evaluateWithObject:sEmailString];
}

+ (BOOL)isValidPassword:(NSString *)sPasswordString
{
    if (sPasswordString.length >= 6)
    {
        return YES;
    }
    
    return NO;
    
    //    if (sPasswordString.length < 8)
    //    {
    //        return NO;
    //    }
    //
    //    BOOL tHaveUpperCaseString = NO;
    //    BOOL tHaveLowerCaseString = NO;
    //    BOOL tHaveNumberString = NO;
    //    BOOL tHaveSpecialString = NO;
    //
    //    for (int i = 0; i < sPasswordString.length; i++)
    //    {
    //        char tChar = [sPasswordString characterAtIndex:i];
    //
    //        // check uppercase string
    //        NSCharacterSet* tCaps = [NSCharacterSet uppercaseLetterCharacterSet];
    //        if ([tCaps characterIsMember: tChar])
    //        {
    //            tHaveUpperCaseString = YES;
    //        }
    //
    //        // check lowercase string
    //        NSCharacterSet* tLower = [NSCharacterSet lowercaseLetterCharacterSet];
    //        if ([tLower characterIsMember: tChar])
    //        {
    //            tHaveLowerCaseString = YES;
    //        }
    //
    //        // check lowercase string
    //        NSCharacterSet* tNumber = [NSCharacterSet decimalDigitCharacterSet];
    //        if ([tNumber characterIsMember: tChar])
    //        {
    //            tHaveNumberString = YES;
    //        }
    //
    //        // check lowercase string
    //        NSCharacterSet* tSpecial = [NSCharacterSet symbolCharacterSet];
    //        if ([tSpecial characterIsMember: tChar])
    //        {
    //            tHaveSpecialString = YES;
    //        }
    //    }
    //
    //    if (tHaveUpperCaseString && tHaveLowerCaseString && tHaveSpecialString && tHaveNumberString)
    //    {
    //        return YES;
    //    }
    //    return NO;
}

#pragma mark - DATE TIME

/**
 *  timeInSecondFrom
 *
 *  @param char
 *  @param string
 */

+ (NSTimeInterval)timeInSecondFrom:(NSString *)sString WithFormat:(NSString *)sFormat
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat        = sFormat;
    formatter.timeZone          = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDate *timeDate            = [formatter dateFromString:sString];
    
    
    formatter.dateFormat    = @"HH";
    int hours               = [[formatter stringFromDate:timeDate] intValue];
    formatter.dateFormat    = @"mm";
    int minutes             = [[formatter stringFromDate:timeDate] intValue];
    formatter.dateFormat    = @"ss";
    int seconds             = [[formatter stringFromDate:timeDate] intValue];
    formatter.dateFormat    = @"SS";
    int miliseconds         = [[formatter stringFromDate:timeDate] intValue];
    
    NSTimeInterval timeInSeconds = (seconds + minutes * 60.00 + hours*3600.00) + miliseconds/100.00;
    return timeInSeconds;
}

+ (NSString*) stringFromDate:(NSDate*)date withFormat:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

/**
 *  parse string to date
 *
 *  @param dateString date string
 *  @param format     format
 *
 *  @return date
 */
+ (NSDate*)dateFromString:(NSString*)dateString withFormat:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:format];
    
    NSDate *tDate = [dateFormatter dateFromString:dateString];
    return tDate;
}

+ (NSArray*)daysThisWeek
{
    return  [TFUtil daysInWeek:0 fromDate:[NSDate date]];
}

+ (NSArray*)daysNextWeek
{
    return  [TFUtil daysInWeek:1 fromDate:[NSDate date]];
}

+ (NSArray*)daysInWeek:(int)weekOffset fromDate:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //ask for current week
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([comps weekday] - 1)];
    NSDate* weekstart = [calendar dateByAddingComponents:componentsToSubtract toDate:date options:0];
    if (weekOffset > 0)
    {
        NSDateComponents* moveWeeks = [[NSDateComponents alloc] init];
        moveWeeks.weekOfYear = 1;
        weekstart=[calendar dateByAddingComponents:moveWeeks toDate:weekstart options:0];
    }
    
    //add 7 days
    NSMutableArray* week=[NSMutableArray arrayWithCapacity:7];
    for (int i = 1; i <= 7; i++)
    {
        NSDateComponents *compsToAdd = [[NSDateComponents alloc] init];
        compsToAdd.day=i;
        NSDate *nextDate = [calendar dateByAddingComponents:compsToAdd toDate:weekstart options:0];
        [week addObject:nextDate];
        
    }
    
    return [NSArray arrayWithArray:week];
}

+ (NSDateComponents *)getComponentFromDate:(NSDate *)sDate
{
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *rComponents = [gregorian components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:sDate];
    
    return rComponents;
}

+ (NSDate *)getDateFromComponents:(NSDateComponents *)sComponents
{
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDate *rDate = [gregorian dateFromComponents:sComponents];
    return rDate;
}

+ (long)dateIntFromString:(NSString *)sDateString withFormat:(NSString *)sFormat
{
    NSDate *tBirthDayDate = [self dateFromString:sDateString withFormat:sFormat];
    return [tBirthDayDate timeIntervalSince1970];
}

+ (NSString *)stringFromDateInt:(NSTimeInterval)sDateInt withFormat:(NSString *)sFormat
{
    NSDate  *tBirthDayDate      = [NSDate dateWithTimeIntervalSince1970:sDateInt];
    NSString *tBirthDayString   = [self stringFromDate:tBirthDayDate withFormat:sFormat];
    
    return tBirthDayString;
}

+ (NSString *)stringFromDateToNow:(NSTimeInterval)sDateInt
{
    NSString *tDateStatus = @"";
    
    NSDate  *tBirthDayDate      = [NSDate dateWithTimeIntervalSince1970:sDateInt];
    
    NSTimeInterval tDistanceBetweenDates = -[tBirthDayDate timeIntervalSinceNow];
    
    double secondsInMonth = 2592000;
    double secondsInADay = 86400;
    double secondsInAnHour = 3600;
    double secondsInAMin = 60;
    
    if (tDistanceBetweenDates < secondsInAMin) {
        tDateStatus = [NSString stringWithFormat:@"just now"];
    }
    else if (tDistanceBetweenDates < secondsInAnHour)
    {
        NSInteger mMinBetweenDates = tDistanceBetweenDates / secondsInAMin;
        tDateStatus = [NSString stringWithFormat:@"%li min ago", (long)mMinBetweenDates];
    }
    else if (tDistanceBetweenDates < secondsInADay)
    {
        NSInteger mHourBetweenDates = tDistanceBetweenDates / secondsInAnHour;
        tDateStatus = [NSString stringWithFormat:@"%li hour ago", (long)mHourBetweenDates];
    }
    else if (tDistanceBetweenDates < secondsInMonth)
    {
        tDateStatus = [self stringFromDateInt:sDateInt withFormat:@"MMM dd 'at' hh:mm a"];
    }
    return tDateStatus;
}

#pragma mark - Chart PN
+ (NSArray *)getListYLabelFromArray:(NSArray *)sArray
{
    float tMinY = [sArray[0] floatValue];
    float tMaxY = [sArray[0] floatValue];
    for (int i = 1; i < sArray.count; i++)
    {
        float tValue = (float)[sArray[i] doubleValue];
        if (tMinY > tValue)
        {
            tMinY = tValue;
        }
        if (tMaxY < tValue)
        {
            tMaxY = tValue;
        }
    }
    NSInteger tMaxYLabel = (((int)tMaxY/30) + 1) * 30;
    NSInteger tMinYLabel = ((int)tMinY/30) * 30;
    
    NSMutableArray *tYValueLabel = [[NSMutableArray alloc] init];
    for (int i = 0; i <= 3; i++)
    {
        NSInteger tCurrentValue = tMinYLabel + (tMaxYLabel - tMinYLabel)*i/3;
        NSString *tStringValue = [NSString stringWithFormat:@"%li", (long)tCurrentValue];
        [tYValueLabel addObject:tStringValue];
    }
    return (NSArray *)tYValueLabel;
}

+ (NSString *)convertToStringFrom:(NSDictionary *)sData
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sData options:0 error:&error];
    NSString *tJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return tJsonString;
}


+ (NSInteger)getBSCNN_A:(NSInteger)a B:(NSInteger)b
{
    if (a <= 0 || b <= 0)
    {
        return 0;
    }
    
    NSInteger bsc = a * b;
    while (a != b)
    {
        if (a > b)
        {
            a = a - b;
        }
        else
        {
            b = b - a;
        }
    }
    
    return bsc / a;
}


+ (NSString *)getStringFromString:(NSString *)sString
{
    if (sString == nil)
    {
        return @"";
    }
    return sString;
}

+ (UIImage*)filteredImage:(UIImage*)image withFilterName:(NSString*)filterName
{
    if([filterName isEqualToString:@"None"]){
        return image;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
    
    
    [filter setDefaults];
    
    if([filterName isEqualToString:@"CIVignetteEffect"]){
        // parameters for CIVignetteEffect
        CGFloat R = MIN(image.size.width, image.size.height)*image.scale/2;
        CIVector *vct = [[CIVector alloc] initWithX:image.size.width*image.scale/2 Y:image.size.height*image.scale/2];
        [filter setValue:vct forKey:@"inputCenter"];
        [filter setValue:[NSNumber numberWithFloat:0.9] forKey:@"inputIntensity"];
        [filter setValue:[NSNumber numberWithFloat:R] forKey:@"inputRadius"];
    }
    
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}
@end

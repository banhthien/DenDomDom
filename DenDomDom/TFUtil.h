//
//  TFUtil.h
//  ShopOnline
//
//  Created by Long Dang on 8/6/15.
//  Copyright (c) 2015 tflat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFUtil : NSObject

+ (NSString *)checkStringFromDictValue:(NSString *)sDictValue;
/**
 * CalculatorString with font for width
 *
 *
 **/
+ (CGRect)calculatorSizeString:(NSString *)sString withFont:(UIFont *)sFont forWidth:(NSInteger)sWith;

/**
 * CalculatorString for width
 *
 *
 **/


+ (UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

/**
 *  Bounce animation
 *
 *  @param animateView
 *  @param startScale
 *  @param andScale
 */
+ (void)bounceViewAnimate:(UIView *)animateView startScale:(float)startScale endScale:(float)endScale;

/**
 *  strim character
 *
 *  @param char
 *  @param string
 */

+ (NSString *)strimCharacter:(char)c string:(NSString *)str;

#pragma mark - Sign up
+ (BOOL)isValidEmail:(NSString *)sEmailString;

+ (BOOL)isValidPassword:(NSString *)sPasswordString;

#pragma mark - DATE TIME

/**
 *  timeInSecondFrom
 *
 *  @param char
 *  @param string
 */

+ (NSTimeInterval)timeInSecondFrom:(NSString *)sString WithFormat:(NSString *)sFormat;

+ (NSString*) stringFromDate:(NSDate*)date withFormat:(NSString*)format;

/**
 *  parse string to date
 *
 *  @param dateString date string
 *  @param format     format
 *
 *  @return date
 */
+ (NSDate*)dateFromString:(NSString*)dateString withFormat:(NSString*)format;

+ (NSArray*)daysThisWeek;

+ (NSArray*)daysNextWeek;

+ (NSArray*)daysInWeek:(int)weekOffset fromDate:(NSDate*)date;

+ (NSDateComponents *)getComponentFromDate:(NSDate *)sDate;

+ (NSDate *)getDateFromComponents:(NSDateComponents *)sComponents;

+ (long)dateIntFromString:(NSString *)sDateString withFormat:(NSString *)sFormat;

+ (NSString *)stringFromDateInt:(NSTimeInterval)sDateInt withFormat:(NSString *)sFormat;

+ (NSString *)stringFromDateToNow:(NSTimeInterval)sDateInt;

#pragma mark - Chart PN
+ (NSArray *)getListYLabelFromArray:(NSArray *)sArray;

+ (NSString *)convertToStringFrom:(NSDictionary *)sData;

+ (NSInteger)getBSCNN_A:(NSInteger)a B:(NSInteger)b;

+ (NSString *)getStringFromString:(NSString *)sString;

// Filter Image
+ (UIImage*)filteredImage:(UIImage*)image withFilterName:(NSString*)filterName;
@end

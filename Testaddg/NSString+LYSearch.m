//
//  NSString+Search.m
//  Testaddg
//
//  Created by xuliying on 2017/8/9.
//  Copyright © 2017年 xly. All rights reserved.
//

#import "NSString+LYSearch.h"
#import "PinYin4Objc.h"

@implementation NSString (LYSearch)
-(NSRange)rangeOfSearchString:(NSString *)searchString andChineseMatchType:(LYSearchType)searchType{
    if (self == nil || searchString == nil) {
        return NSMakeRange(0, 0);
    }
    if (((searchType & LYSearchWithChineseExact) || (searchType & LYSearchWithChineseChineseAndPinyin)) && [searchString containChinese]) {
        NSRange ran = [self rangeOfString:searchString];
        if (ran.length) {
            return ran;
        }else{
            if (searchType & LYSearchWithChineseChineseAndPinyin) {
                if ([searchString isChinese] == NO) {
                    NSRange ra = [self rangeOfSearchString:searchString andChineseMatchType:LYSearchWithChinesePinyin];
                    if (ra.length) {
                        NSString *subString = [self substringWithRange:ra];
                        
                        NSMutableString *chineseStr = [NSMutableString string];
                        NSMutableString *searchChineseStr = [NSMutableString string];
                        
                        for (int i = 0; i < subString.length; i ++) {
                            NSString *str = [subString substringWithRange:NSMakeRange(i, 1)];
                            if ([str isChinese]) {
                                [chineseStr appendString:str];
                            }
                        }
                        
                        for (int i = 0; i < searchString.length; i ++) {
                            NSString *str = [searchString substringWithRange:NSMakeRange(i, 1)];
                            if ([str isChinese]) {
                                [searchChineseStr appendString:str];
                            }
                        }
                        
                        if (chineseStr.length && searchChineseStr.length && [chineseStr rangeOfString:searchChineseStr].length) {
                            return ra;
                        }
                    }
                }
            }
        }
        return NSMakeRange(0, 0);
    }

 
    if (searchType & LYSearchWithChineseInitials && [searchString containChinese] == NO) {
        NSString *searchPy = [searchString pinyinString];
        NSString *firstCharString = [self firstCharsString];
        if (firstCharString == nil) {
            return NSMakeRange(0, 0);
        }
        NSRange range = [firstCharString rangeOfString:searchPy];
        if (range.length) {
            return range;
        }
    }
    
    if (searchType & LYSearchWithChinesePinyin) {
        NSString *searchPy = [searchString pinyinString];
        NSString *pyStr = [self pinyinString];
        if (searchPy == nil || pyStr == nil) {
            return NSMakeRange(0, 0);
        }
        NSRange range = [pyStr rangeOfString:[searchPy lowercaseString]];
        if (range.length) {
            NSRange returnrange = NSMakeRange(0, 0);
            BOOL has = NO;
            for (int i = 0; i < self.length; i ++) {
                NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
                NSString *py = [str pinyinString];
                if (py == nil) {
                    return NSMakeRange(0, 0);
                }
                NSRange ra = [pyStr rangeOfString:py];
                if (ra.location == range.location) {
                    returnrange.location = i;
                    has = YES;
                    break;
                }else if (ra.location > range.location){
                    //                index = i - 1;
                    break;
                }
            }
            for (int i = 1; i < self.length - returnrange.location + 1 && has; i ++) {
                NSString *subStr = [self substringWithRange:NSMakeRange(returnrange.location,i)];
                NSString *subStrPy = [subStr pinyinString];
                if (subStrPy == nil) {
                    return NSMakeRange(0, 0);
                }
                if ([subStrPy rangeOfString:[searchPy lowercaseString]].length) {
                    returnrange.length = i;
                    break;
                }
            }
            return returnrange;
        }else{
            if (searchType & LYSearchWithChineseInitials) {
                NSString *firstCharString = [self firstCharsString];
                if (firstCharString == nil) {
                    return NSMakeRange(0, 0);
                }
                NSRange range = [firstCharString rangeOfString:searchPy];
                return range;

            }
        }
    }
    return NSMakeRange(0, 0);
}
-(NSString *)stringOfSearchString:(NSString *)searchString andChineseMatchType:(LYSearchType)searchType{
    NSRange range = [self rangeOfSearchString:searchString andChineseMatchType:searchType];
    if (range.length) {
        return [self substringWithRange:range];
    }
    return nil;
}

-(NSString *)pinyinString{
    if (self && self.length) {
        HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
        [outputFormat setToneType:ToneTypeWithoutTone];
        [outputFormat setVCharType:VCharTypeWithUAndColon];
        [outputFormat setCaseType:CaseTypeLowercase];
        
        NSString *pinyinStr = [[PinyinHelper toHanyuPinyinStringWithNSString:self withHanyuPinyinOutputFormat:outputFormat withNSString:@""] lowercaseString] ? : @"";
        return pinyinStr;
        /*效率低
         
        if ([self stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
            return nil;
        }
        NSMutableString *pinyin = [self mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
        return [[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
         */
    }else{
        return @"";
    }
}

-(NSString *)firstCharsString{
    if (self) {
        NSMutableString *string = [NSMutableString string];
        for (int i = 0; i < self.length; i ++) {
            NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
            NSString *pyStr = [str pinyinString];
            if (pyStr) {
                [string appendString:[pyStr substringToIndex:1]];
            }
        }
        return [string copy];
    }
    return nil;
}
- (BOOL)containChinese
{
    for(int i = 0; i < [self length];i ++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00 && a <0x9fff){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

@end

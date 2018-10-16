//
//  NSString+Search.h
//  Testaddg
//
//  Created by xuliying on 2017/8/9.
//  Copyright © 2017年 xly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LYSearchType) {
    LYSearchWithChineseExact = 1 << 0,
    LYSearchWithChinesePinyin = 1 << 1,
    LYSearchWithChineseInitials = 1 << 2,
    LYSearchWithChineseChineseAndPinyin = 1 << 3,
};


@interface NSString (LYSearch)

- (NSRange)rangeOfSearchString:(NSString *)searchString andChineseMatchType:(LYSearchType)searchType;
- (NSString *)stringOfSearchString:(NSString *)searchString andChineseMatchType:(LYSearchType)searchType;;
- (NSString *)pinyinString;
- (NSString *)firstCharsString;
- (BOOL)containChinese;
- (BOOL)isChinese;

@end

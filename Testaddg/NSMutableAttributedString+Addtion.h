//
//  NSMutableAttributedString+Addtion.h
//  NSMutableAttributedString
//
//  Created by xuliying on 16/3/1.
//  Copyright © 2016年 xly. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSObject+Addition.h"

#define range(a,b)      [NSValue valueWithRange:NSMakeRange(a, b)]
#define fontAtt         NSFontAttributeName
#define paragraphAtt    NSParagraphStyleAttributeName
#define fontColorAtt    NSForegroundColorAttributeName


@interface NSMutableAttributedString (Addtion)
-(NSMutableAttributedString *)addAttributesWithArray:(NSArray *)attrs;//数组 name value range
-(NSMutableAttributedString *)addAttributesWithDict:(NSDictionary *)attrs range:(NSRange)range;
-(NSMutableAttributedString *)addAttributesWithDict:(NSDictionary *)dict;

-(void)setTextColor:(UIColor *)color range:(NSRange)range;
-(void)setTextFont:(UIFont *)font range:(NSRange)range;

-(void)setDesignatedText:(NSString *)text color:(UIColor *)color;
-(void)setDesignatedText:(NSString *)text font:(UIFont *)font;

-(void)setDesignatedTexts:(NSArray *)array color:(UIColor *)color;
-(void)setDesignatedTexts:(NSArray *)array font:(UIFont *)font;

-(void)setDesignatedText:(NSString *)text attribute:(NSString *)name value:(id)value;
-(void)setDesignatedTexts:(NSArray *)texts attribute:(NSString *)name value:(id)value;
@end

//
//  UILabel+AttributedString.h
//  testss
//
//  Created by xuliying on 16/4/25.
//  Copyright © 2016年 xly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Addition.h"
@interface UILabel (AttributedString)
-(void)setAttributedTextWithAtts:(NSArray *)atts;

-(void)set_TextColor:(UIColor *)color range:(NSRange)range;
-(void)set_TextFont:(UIFont *)font range:(NSRange)range;

-(void)set_DesignatedText:(NSString *)text color:(UIColor *)color;
-(void)set_DesignatedText:(NSString *)text font:(UIFont *)font;

-(void)set_DesignatedTexts:(NSArray *)array color:(UIColor *)color;
-(void)set_DesignatedTexts:(NSArray *)array font:(UIFont *)font;

-(void)set_DesignatedText:(NSString *)text attribute:(NSString *)name value:(id)value;
-(void)set_DesignatedTexts:(NSArray *)texts attribute:(NSString *)name value:(id)value;
@end

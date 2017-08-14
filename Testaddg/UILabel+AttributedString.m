//
//  UILabel+AttributedString.m
//  testss
//
//  Created by xuliying on 16/4/25.
//  Copyright © 2016年 xly. All rights reserved.
//

#import "UILabel+AttributedString.h"
#import "NSMutableAttributedString+Addtion.h"
@implementation UILabel (AttributedString)
-(void)setAttributedTextWithAtts:(NSArray *)atts{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    for (NSAttributedString *att in atts) {
        [attStr appendAttributedString:att];
    }
    self.attributedText = attStr;
}


-(void)set_TextColor:(UIColor *)color range:(NSRange)range{
    if (self.attributedText.isNoEmpty && color) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr setTextColor:color range:range];
        self.attributedText = attStr;
    }
}
-(void)set_TextFont:(UIFont *)font range:(NSRange)range{
    if (self.attributedText.isNoEmpty && font) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr setTextFont:font range:range];
        self.attributedText = attStr;
    }
}

-(void)set_DesignatedText:(NSString *)text color:(UIColor *)color{
    if (self.attributedText.isNoEmpty && text.isNoEmpty && color) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr setDesignatedText:text color:color];
        self.attributedText = attStr;
    }
}
-(void)set_DesignatedText:(NSString *)text font:(UIFont *)font{
    if (self.attributedText.isNoEmpty && text.isNoEmpty && font) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr setDesignatedText:text font:font];
        self.attributedText = attStr;
    }
}

-(void)set_DesignatedTexts:(NSArray *)array color:(UIColor *)color{
    if (self.attributedText.isNoEmpty && array.isNoEmpty && color) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr setDesignatedTexts:array color:color];
        self.attributedText = attStr;
    }
}
-(void)set_DesignatedTexts:(NSArray *)array font:(UIFont *)font{
    if (self.attributedText.isNoEmpty && array.isNoEmpty && font) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr setDesignatedTexts:array font:font];
        self.attributedText = attStr;
    }
}


-(void)set_DesignatedText:(NSString *)text attribute:(NSString *)name value:(id)value{
    if (self.attributedText.isNoEmpty && text.isNoEmpty && name.isNoEmpty && value) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr setDesignatedText:text attribute:name value:value];
        self.attributedText = attStr;
    }
}
-(void)set_DesignatedTexts:(NSArray *)texts attribute:(NSString *)name value:(id)value{
    if (texts.isNoEmpty && name.isNoEmpty && value) {
        for (NSString *text in texts) {
            [self set_DesignatedText:text attribute:name value:value];
        }
    }
}

@end

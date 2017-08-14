//
//  NSMutableAttributedString+Addtion.m
//  NSMutableAttributedString
//
//  Created by xuliying on 16/3/1.
//  Copyright © 2016年 xly. All rights reserved.
//

#import "NSMutableAttributedString+Addtion.h"

@implementation NSMutableAttributedString (Addtion)

-(NSMutableAttributedString *)addAttributesWithArray:(NSArray *)attrs{
    for (NSArray *array in attrs) {
        if (array.count == 2) {
            [self addAttribute:array[0] value:array[1] range:NSMakeRange(0, self.length)];
        }else{
            [self addAttribute:array[0] value:array[1] range:[array[2] rangeValue]];
        }
    }
    return self;
}
-(NSMutableAttributedString *)addAttributesWithDict:(NSDictionary *)attrs range:(NSRange)range{
    
    
    for (NSString *key in attrs.allKeys) {
        [self addAttribute:key value:attrs[key] range:range];
    }
    return self;
}
-(NSMutableAttributedString *)addAttributesWithDict:(NSDictionary *)dict{
    for (id key in dict.allKeys) {
        if ([key isKindOfClass:[NSValue class]]) {
            [self addAttributesWithDict:dict[key] range:[key rangeValue]];
        }else{
            [self addAttributesWithDict:key range:[dict[key] rangeValue]];
        }
    }
    return self;
}


-(void)setTextColor:(UIColor *)color range:(NSRange)range{
    if (self.length > 0 && color && [color isKindOfClass:[UIColor class]] && self.length >= NSMaxRange(range) && NSMaxRange(range) > 0) {
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
}
-(void)setTextFont:(UIFont *)font range:(NSRange)range{
    if (self.length > 0 && font && [font isKindOfClass:[UIFont class]] && self.length >= NSMaxRange(range) && NSMaxRange(range) > 0) {
        [self addAttribute:NSFontAttributeName value:font range:range];
    }
}

-(void)setDesignatedText:(NSString *)text font:(UIFont *)font{
    if (self.length > 0 && text.length && font) {
        //        NSRange range = [self.string rangeOfString:text];
        NSArray *rangeArray = [self rangesOfString:text inString:self.string];
        if (rangeArray.isNoEmpty) {
            for (NSValue *value in rangeArray) {
                [self addAttribute:NSFontAttributeName value:font range:[value rangeValue]];
            }
        }
        //        if (range.length > 0) {
        //            [self addAttribute:NSFontAttributeName value:font range:range];
        //        }
    }
}
-(void)setDesignatedText:(NSString *)text color:(UIColor *)color{
    if (self.length > 0 && text.length && color) {
        //        NSRange range = [self.string rangeOfString:text];
        
        NSArray *rangeArray = [self rangesOfString:text inString:self.string];
        if (rangeArray.isNoEmpty) {
            for (NSValue *value in rangeArray) {
                [self addAttribute:NSForegroundColorAttributeName value:color range:[value rangeValue]];
            }
        }
        //        if (range.length > 0) {
        //            [self addAttribute:NSForegroundColorAttributeName value:color range:range];
        //        }
    }
}

-(void)setDesignatedTexts:(NSArray *)array color:(UIColor *)color{
    if (self.length && array.isNoEmpty && color) {
        for (NSString *text in array) {
            [self setDesignatedText:text color:color];
        }
    }
}
-(void)setDesignatedTexts:(NSArray *)array font:(UIFont *)font{
    if (self.length && array.isNoEmpty && font) {
        for (NSString *text in array) {
            [self setDesignatedText:text font:font];
        }
    }
}


- (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    
    if (searchString.isNoEmpty && str.isNoEmpty) {
        NSMutableArray *results = [NSMutableArray array];
        NSRange searchRange = NSMakeRange(0, [str length]);
        NSRange range;
        while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
            
            [results addObject:[NSValue valueWithRange:range]];
            
            searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
            
        }
        return results;
        
    }
    return nil;
}
-(void)setDesignatedText:(NSString *)text attribute:(NSString *)name value:(id)value{
    if (text.isNoEmpty && name.isNoEmpty && value && self.length) {
        NSArray *rangeArray = [self rangesOfString:text inString:self.string];
        if (rangeArray.isNoEmpty) {
            for (NSValue *value1 in rangeArray) {
                [self addAttribute:name value:value range:[value1 rangeValue]];
            }
        }
    }

}

-(void)setDesignatedTexts:(NSArray *)texts attribute:(NSString *)name value:(id)value{
    if (self.length && texts.isNoEmpty && name.isNoEmpty && value) {
        for (NSString *text in texts) {
            [self setDesignatedText:text attribute:name value:value];
        }
    }
}
@end

//
//  NSObject+Search.m
//  Testaddg
//
//  Created by xuliying on 2017/8/31.
//  Copyright © 2017年 xly. All rights reserved.
//

#import "NSObject+Search.h"
#import <objc/runtime.h>
@implementation NSObject (Search)
-(void)setSearchString_ly:(NSString *)searchString_ly{
    objc_setAssociatedObject(self, @selector(searchString_ly), searchString_ly, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)searchString_ly{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setSearchStringRange_ly:(NSRange)searchStringRange_ly{
    objc_setAssociatedObject(self, @selector(searchStringRange_ly), [NSValue valueWithRange:searchStringRange_ly], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSRange)searchStringRange_ly{
    return [objc_getAssociatedObject(self, _cmd) rangeValue];
}
@end

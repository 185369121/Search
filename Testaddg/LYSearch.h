//
//  LYSearch.h
//  Testaddg
//
//  Created by xuliying on 2017/8/31.
//  Copyright © 2017年 xly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Search.h"
#import "NSString+LYSearch.h"

@interface LYSearch : NSObject
-(void)searchWithSearchString:(NSString *)searchText andModeDataArray:(NSArray *)modeArray andSearchPropertys:(NSArray *)propertys complete:(void(^)(NSMutableArray *resultData,BOOL isSearch))success sort:(BOOL(^)(id o1,id o2))sort;
@property(nonatomic,assign) LYSearchType searchType;

@end

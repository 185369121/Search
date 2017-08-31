//
//  LYSearch.m
//  Testaddg
//
//  Created by xuliying on 2017/8/31.
//  Copyright © 2017年 xly. All rights reserved.
//

#import "LYSearch.h"
#import "NSString+LYSearch.h"
#import "NSObject+Addition.h"
#import "NSObject+Search.h"
@interface LYSearch()
@property(nonatomic,strong) NSMutableArray *searchArray;
@property(nonatomic,assign) BOOL search;
@end

@implementation LYSearch{
    dispatch_group_t group;
}
-(instancetype)init{
    if (self = [super init]) {
        group = dispatch_group_create();
        self.searchArray = [NSMutableArray array];
    }
    return self;
}
-(void)searchWithSearchString:(NSString *)searchText andModeDataArray:(NSArray *)modeArray andSearchPropertys:(NSArray *)propertys complete:(void (^)(NSMutableArray *, BOOL))success sort:(BOOL (^)(id, id))sort{
    _search = YES;
    @synchronized (_searchArray) {
        [_searchArray removeAllObjects];
    }
    dispatch_group_enter(group);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *tagStr = searchText;
        NSMutableArray *array = [NSMutableArray array];

        for (NSObject *star in modeArray) {
            if ([tagStr isEqualToString:searchText]) {
                for (NSString *property in propertys) {
                    NSString *proValue = [star valueForKey:property];
                    NSString *searchStr = [proValue stringOfSearchString:searchText andChineseMatchType: LYSearchWithChineseExact  | LYSearchWithChineseInitials | LYSearchWithChineseChineseAndPinyin | LYSearchWithChinesePinyin];
                    
                    if (searchStr.isNoEmpty) {
                        [array addObject:star];
                        star.searchStringRange_ly = [proValue rangeOfString:searchStr];;
                        star.searchString_ly = searchStr;
                        break;
                    }else{
                        star.searchStringRange_ly = NSMakeRange(0, 0);
                        star.searchString_ly = @"";
                    }
                }
            }else{
                break;
            }
            
        }
        if (sort) {
            [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return sort(obj1, obj2);
            }];
        }

        @synchronized (_searchArray) {
            if (searchText.isNoEmpty &&[tagStr isEqualToString:searchText]) {
                _search = YES;
                [_searchArray removeAllObjects];
                [_searchArray addObjectsFromArray:array];
            }else{
                _search = NO;
                [_searchArray removeAllObjects];
                [_searchArray addObjectsFromArray:modeArray];
            }
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (success) {
            success(_searchArray,_search);
        }
    });
    
}
@end



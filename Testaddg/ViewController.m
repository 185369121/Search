//
//  ViewController.m
//  Testaddg
//
//  Created by xuliying on 2017/8/9.
//  Copyright © 2017年 xly. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+AttributedString.h"
#import "NSString+LYSearch.h"
#import "Star.h"
#import "UILabel+AttributedString.h"
#import "LYSearch.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    dispatch_group_t group;
}
@property(nonatomic,strong) NSString *testStr;
@property(nonatomic,strong) UILabel *textLab;
@property(nonatomic,strong) UITableView *tabelV;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *searchArray;
@property(nonatomic,strong) NSString *tfText;
@property(nonatomic,strong) LYSearch *search;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    group = dispatch_group_create();
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50, 20, CGRectGetWidth(self.view.frame) - 100, 50)];
    searchBar.backgroundColor = [UIColor redColor];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    self.dataArray = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"奥特曼",@"漩涡鸣人",@"张杰",@"周星驰",@"张学友",@"黄飞鸿",@"乔峰",@"郭靖",@"黄蓉",@"燕子李三",@"王重阳",@"李莫愁",@"令狐冲",@"张翠山",@"丘处机",@"Jarinporn",@"Aaron",@"Aom",@"Kobe Bryant",@"Michael Jordan",@"卡蜜尔",@"亚索",@"金克丝",@"德莱厄斯",@"奥莉安娜",@"盖伦",@"弗拉基米尔",@"贾克斯",@"泰达米尔",@"阿木木",@"凯尔",@"迦娜",@"莫甘娜",@"阿卡丽",@"凯南",@"奥拉夫",@"茂凯",@"SORAKA",@"波比",@"Karma",@"Akali",@"shen",@"Annie",@"JAX",@"VN",@"SONA",@"EZ",@"赵云",@"关羽",@"曹操",@"AK47",@"AN94",@"MG3",@"AWM", nil];
 
    for (NSString *name in array) {
        
        Star *star = [[Star alloc] init];
        star.name = name;
        star.phone = [NSString stringWithFormat:@"152010618%2u",arc4random()%100];
        [_dataArray addObject:star];
    }
    self.searchArray = [NSMutableArray arrayWithArray:_dataArray];
    self.tabelV = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 90) style:UITableViewStylePlain];
    _tabelV.dataSource = self;
    _tabelV.delegate = self;
    _tabelV.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tabelV];
    self.search = [[LYSearch alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.search searchWithSearchString:searchText andModeDataArray:_dataArray andSearchPropertys:@[@"name",@"phone"] complete:^(NSMutableArray *resultData,BOOL search) {
        [_searchArray removeAllObjects];
        [_searchArray addObjectsFromArray:resultData];
        [_tabelV reloadData];
    } sort:^BOOL(id o1, id o2) {//用于排序
        return [o1 searchStringRange_ly].location > [o2 searchStringRange_ly].location;
    }];
//    return;
//    
//    [_searchArray removeAllObjects];
//    dispatch_group_enter(group);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSString *tagStr = searchText;
//        NSMutableArray *array = [NSMutableArray array];
//        for (Star *star in _dataArray) {
//            if ([tagStr isEqualToString:searchText]) {
//                NSString *searchStr = [star.name stringOfSearchString:searchText andChineseMatchType: LYSearchWithChineseExact  | LYSearchWithChineseInitials | LYSearchWithChineseChineseAndPinyin | LYSearchWithChinesePinyin];
//                if (searchStr) {
//                    star.searchStr = searchStr;
//                    [array addObject:star];
//                }
//            }else{
//                break;
//            }
//            
//        }
//        if (searchText.length == 0) {
//            for (Star *star in _dataArray) {
//                star.searchStr = nil;
//                [array addObject:star];
//            }
//        }
//        @synchronized (_searchArray) {
//            if ([tagStr isEqualToString:searchText]) {
//                [_searchArray removeAllObjects];
//                if (tagStr.length) {
//                    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//                        Star *s1 = obj1;
//                        Star *s2 = obj2;
//                        return [s1.name rangeOfString:s1.searchStr].location >  [s2.name rangeOfString:s2.searchStr].location;
//                    }];
//                }
//                [_searchArray addObjectsFromArray:array];
//            }
//        }
//        dispatch_group_leave(group);
//    });
//    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        [_tabelV reloadData];
//    });
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"test"];
    }
    Star *star = _searchArray[indexPath.row];
    cell.textLabel.text = star.name;
    [cell.textLabel set_DesignatedText:star.name color:[UIColor lightGrayColor]];
    [cell.textLabel set_DesignatedText:star.searchString_ly color:[UIColor redColor]];
    cell.detailTextLabel.text = star.phone;
    [cell.detailTextLabel set_DesignatedText:star.phone color:[UIColor lightGrayColor]];
    [cell.detailTextLabel set_DesignatedText:star.searchString_ly color:[UIColor redColor]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ZPFCenterView.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCenterView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "ZPFNewsTableViewCell.h"
#import "ZPFScrollerTableViewCell.h"
#import "JSONModel.h"
#import "ZPFScrollerView.h"
#import "ZPFDataUtils.h"
#import "ZPFDataUtils.h"
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@implementation ZPFCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.centerTodayJsonModel = [[ZPFCenterTodayJSONModel alloc] init];
//        self.selectJsonModel = [[ZPFSelectJsonModel alloc] init];
        self.selectJsonModel = [[ZPFSelectJsonModel alloc] init];
//        self.array = [[NSMutableArray alloc] init];
        self.mutableArray = [[NSMutableArray alloc] init];
        [self initView];
    }
    return self;
}

- (void)initView {

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ZPFWidth, ZPFHeight) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[ZPFScrollerTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[ZPFNewsTableViewCell class] forCellReuseIdentifier:@"cell2"];
    //将tableView放到屏幕最顶上
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
//    self.tableView.alwaysBounceVertical = NO;
    //下拉上拉不越界
//    self.tableView.bounces = NO;
    [self addSubview:self.tableView];
    
    
    
    UIRefreshControl *freshControl = [[UIRefreshControl alloc] init];

    freshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"努力加载中"];
    freshControl.tintColor = [UIColor blueColor];

}


- (UIImage *)image: (NSString *)urlstring {
    UIImage *pictureImage;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]];
    pictureImage = [UIImage imageWithData:data];
    return pictureImage;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        NSArray *array1 = [[NSArray alloc] init];
        array1 = self.centerTodayJsonModel.stories;
        return array1.count;
    } else {

        NSArray *array2 = [[NSArray alloc] init];
        
        array2 = self.selectJsonModel.stories;
        return array2.count;
    }
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
    return [ZPFDataUtils dateStringBeforeDays1:1-section];

}

- (void)scrollerPictureImage {
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSArray *array2 = self.centerTodayJsonModel.top_stories;
    for (int i = 0; i < array2.count; i++) {
        NSString *string = [array2[i] zpfImage];
        [mutableArray addObject:[self image:string]];
    }
    self.scrollerView.images = [NSArray arrayWithArray:mutableArray];

    
    NSMutableArray *titleMutableArray = [NSMutableArray array];
    NSArray *array3 = self.centerTodayJsonModel.top_stories;
    for (int i = 0; i < array3.count; i++) {
        NSString *string1 = [array3[i] zpfTitle];
        [titleMutableArray addObject:string1];
    }
    self.scrollerView.titleArray = [NSArray arrayWithArray:titleMutableArray];
    
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
    
        ZPFScrollerTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];

        self.scrollerView = [[ZPFScrollerView alloc] initWithFrame:CGRectMake(0, 0, ZPFWidth, 220)];
        self.scrollerView.delegate = self;
        self.scrollerView.currentPageColor = [UIColor orangeColor];
        self.scrollerView.pageColor = [UIColor grayColor];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell1 addSubview:self.scrollerView];
        
        return cell1;
    } else if (indexPath.section == 1) {
        ZPFNewsTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell2.label.text = [self.centerTodayJsonModel.stories[indexPath.row] title];

        NSArray *array = [self.centerTodayJsonModel.stories[indexPath.row] images];
        
        NSMutableArray *array1 = [[NSMutableArray alloc] init];
        NSString *string = [self.centerTodayJsonModel.stories[indexPath.row] id];
        [array1 addObject:string];
//        [self.mutableArray addObjectsFromArray:array1];
//        [self.mutableArray addObject:array1];
        [self.mutableArray addObjectsFromArray:array1];
        
        
//        NSString *urlString = array[0];
//        cell2.pictureImageView.image = [self image:urlString];
        
        [cell2.pictureImageView sd_setImageWithURL:[NSURL URLWithString:array[0]]];
 
        
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
    } else {
        ZPFNewsTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        cell3.label.text = [self.selectJsonModel.stories[indexPath.row] title];
        
        NSArray *array3 = [self.selectJsonModel.stories[indexPath.row] images];
        
        NSMutableArray *array2 = [[NSMutableArray alloc] init];
        NSString *string1 = [self.selectJsonModel.stories[indexPath.row] id];
        [array2 addObject:string1];
        
//        [self.mutableArray addObjectsFromArray:array2];
        
//        [self.mutableArray addObject:array2];
        [self.mutableArray addObjectsFromArray:array2];
        
        
        //        NSString *urlString1 = array3[0];
//        cell3.pictureImageView.image = [self image:urlString1];
//
        [cell3.pictureImageView sd_setImageWithURL:[NSURL URLWithString:array3[0]]];

        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    }
}

- (void)carouselView:(ZPFScrollerView *)carouselView indexOfClickedImageBtn:(NSUInteger )index {
    NSLog(@"点击了第%ld张图片",index);
}



@end

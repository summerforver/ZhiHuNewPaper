//
//  ZPFCenterView.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCenterView.h"
#import <Masonry.h>
#import "ZPFNewsTableViewCell.h"
#import "ZPFScrollerTableViewCell.h"
#import "JSONModel.h"
#import "ZPFScrollerView.h"
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@implementation ZPFCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatWeb];
        [self creatInternet:@"20181028"];
        [self initView];
    }
    return self;
}



- (void)initView {
    //    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.bounds.size.width, self.bounds.size.height) style:UITableViewStyleGrouped];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ZPFWidth, ZPFHeight) style:UITableViewStylePlain];
    //    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ZPFScrollerTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[ZPFNewsTableViewCell class] forCellReuseIdentifier:@"cell2"];
    //将tableView放到屏幕最顶上
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    self.tableView.alwaysBounceVertical = NO;
    //下拉上拉不越界
    self.tableView.bounces = NO;
    
    
    [self addSubview:self.tableView];
//        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(64);
//            make.width.mas_equalTo(375);
//            make.height.mas_equalTo(667);
//            make.size.mas_equalTo(self.mas_top);
//        }];
    
    
    self.textViewMutableArray = [[NSMutableArray alloc] init];
    self.pictureImageViewMutableArray = [[NSMutableArray alloc] init];
    self.nextTextViewMutableArray = [[NSMutableArray alloc] init];
    self.nextPictureImageViewMutableArray = [[NSMutableArray alloc] init];
    
    self.scrollerViewMutableArray = [[NSMutableArray alloc] init];
    
    
    
}

- (void)creatWeb {
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSString *string = @"https://news-at.zhihu.com/api/4/news/latest";
        NSString *urlString = [[NSString alloc] init];
        urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data && error ==  nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                self.centerTodayJsonModel = [[ZPFCenterTodayJSONModel alloc] initWithDictionary:dic error:nil];
                //                NSLog(@"%@", self.centerTodayJsonModel.date);




                for (int i = 0; i < self.centerTodayJsonModel.stories.count; i++) {
                    ZPFCenterTodayStoriesJSONModel *storiesJsonModel = [[ZPFCenterTodayStoriesJSONModel alloc] initWithDictionary:dic[@"stories"][i] error:nil];

                    [self.textViewMutableArray addObject:storiesJsonModel.title];

                    //数组转为字符串
                    NSString *string1 = [storiesJsonModel.images componentsJoinedByString:@","];
                    NSURL *url1 = [NSURL URLWithString:string1];

                    NSData *data = [NSData dataWithContentsOfURL:url1];

                    UIImage *image = [UIImage imageWithData:data];


                    [self.pictureImageViewMutableArray addObject:image];


                }
                for (int i = 0; i < self.centerTodayJsonModel.top_stories.count; i++){
                    ZPFCenterTodayTop_storiesJSONModel *topStoriesModel = [[ZPFCenterTodayTop_storiesJSONModel alloc] initWithDictionary:dic[@"top_stories"][i] error:nil];
                    //                                        NSLog(@"-====%@", topStoriesModel.image);

                    NSURL *url2 = [NSURL URLWithString:topStoriesModel.image];

                    NSData *data1 = [NSData dataWithContentsOfURL:url2];

                    UIImage *image1 = [UIImage imageWithData:data1];
                    [self.scrollerViewMutableArray addObject:image1];

                    //                    NSLog(@"&&&&&&%ld", self.scrollerViewMutableArray.count);
                    //                    NSLog(@"%@", self.scrollerViewMutableArray);

                }

                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.tableView reloadData];
                }];

            } else {
                NSLog(@"%@", error);
            }
        }];
        [dataTask resume];
    });
}

- (void)creatInternet:(NSString *)dateString {
    self.headViewDateString = [[NSString alloc] init];
    self.headViewDateString = dateString;
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSString *string = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@", dateString];
        //        NSString *string = @"https://news-at.zhihu.com/api/4/news/before/20181028";
        
        NSString *urlString = [[NSString alloc] init];
        urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data && error ==  nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                self.selectJsonModel = [[ZPFSelectJsonModel alloc] initWithDictionary:dic error:nil];
                //                NSLog(@"%@", self.selectJsonModel.date);
                
                
                for (int i = 0; i < self.selectJsonModel.stories.count; i++) {
                    ZPFSelectStoriesJsonModel *storiesJsonModel = [[ZPFSelectStoriesJsonModel alloc] initWithDictionary:dic[@"stories"][i] error:nil];
                    //                    NSLog(@"%@", storiesJsonModel.title);
                    //                    [self.textViewMutableArray addObject:storiesJsonModel.title];
                    [self.nextTextViewMutableArray addObject:storiesJsonModel.title];
                    
                    //数组转为字符串
                    NSString *string1 = [storiesJsonModel.images componentsJoinedByString:@","];
                    NSURL *url1 = [NSURL URLWithString:string1];
                    
                    NSData *data = [NSData dataWithContentsOfURL:url1];
                    
                    UIImage *image = [UIImage imageWithData:data];
                    
                    [self.nextPictureImageViewMutableArray addObject:image];
    
                    
                    
                }
                
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.tableView reloadData];
                }];
                
            } else {
                NSLog(@"%@", error);
            }
        }];
        [dataTask resume];
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //    return 2;
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        //        return 7;
        return self.textViewMutableArray.count;
    } else {
        return self.nextTextViewMutableArray.count;
    }
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //    return @"星期六";
    return self.headViewDateString;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0) {
        //        if (cell == nil) {
        //            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //            ScrollerView *scrollerView = [[ScrollerView alloc] initWithFrame:cell.frame];
        //            scrollerView.delegate = self;
        //            scrollerView.images = @[[UIImage imageNamed:@"0的副本.jpg"],
        //                                    [UIImage imageNamed:@"1的副本.jpg"],
        //                                    [UIImage imageNamed:@"2的副本.jpg"],
        //                                    [UIImage imageNamed:@"3的副本.jpg"],
        //                                    [UIImage imageNamed:@"4的副本.jpg"]];
        //            scrollerView.currentPageColor = [UIColor orangeColor];
        //            scrollerView.pageColor = [UIColor grayColor];
        //            [cell addSubview:scrollerView];
        //        }
        //
        //
        //        return cell;
        
        ZPFScrollerTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        //        self.scrollerView = [[ScrollerView alloc] initWithFrame:cell1.frame];
        self.scrollerView = [[ZPFScrollerView alloc] initWithFrame:CGRectMake(0, 0, ZPFWidth, 220)];
        self.scrollerView.delegate = self;
        //        NSLog(@"shuiwhudhwio");
        self.scrollerView.images = @[[UIImage imageNamed:@"0的副本.jpg"],
                                     [UIImage imageNamed:@"1的副本.jpg"],
                                     [UIImage imageNamed:@"2的副本.jpg"],
                                     [UIImage imageNamed:@"3的副本.jpg"],
                                     [UIImage imageNamed:@"4的副本.jpg"]];
        //        NSLog(@"=-=-=%ld", self.scrollerViewMutableArray.count);
        //        if (self.scrollerViewMutableArray) {
        //                scrollerView.images = self.scrollerViewMutableArray;
        //        }
        
        
        self.scrollerView.currentPageColor = [UIColor orangeColor];
        self.scrollerView.pageColor = [UIColor grayColor];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        
        [cell1 addSubview:self.scrollerView];
        
        return cell1;
    } else if (indexPath.section == 1) {
        ZPFNewsTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        //        cell2.textView.text = @"123";
//        cell2.textView.text = self.textViewMutableArray[indexPath.row];
        
        cell2.label.text = [self.centerTodayJsonModel.stories[indexPath.row] title];
        
//        cell2.label.text = self.textViewMutableArray[indexPath.row];
        cell2.pictureImageView.image = self.pictureImageViewMutableArray[indexPath.row];
//                cell2.pictureImageView.image = [UIImage imageNamed: self.pictureImageViewMutableArray[indexPath.row]];
        //        cell2.backgroundColor = [UIColor greenColor];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        return cell2;
    } else {
        ZPFNewsTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        //        cell3.textView.text = @"123";
//        cell3.textView.text = self.nextTextViewMutableArray[indexPath.row];
        cell3.label.text = self.nextTextViewMutableArray[indexPath.row];
        cell3.pictureImageView.image = self.nextPictureImageViewMutableArray[indexPath.row];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        return cell3;
    }
}

- (void)carouselView:(ZPFScrollerView *)carouselView indexOfClickedImageBtn:(NSUInteger )index {
    NSLog(@"点击了第%ld张图片",index);
}



@end

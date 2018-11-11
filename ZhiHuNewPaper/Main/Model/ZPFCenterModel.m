//
//  ZPFCenterModel.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCenterModel.h"

@implementation ZPFCenterModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textViewMutableArray = [[NSMutableArray alloc] init];
        self.pictureImageViewMutableArray = [[NSMutableArray alloc] init];
        self.scrollerViewMutableArray = [[NSMutableArray alloc] init];
//        [self creatWeb];
    }
    return self;
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
               
                
                for (int i = 0; i < self.centerTodayJsonModel.stories.count; i++) {
//                    ZPFCenterTodayStoriesJSONModel *storiesJsonModel = [[ZPFCenterTodayStoriesJSONModel alloc] initWithDictionary:dic[@"stories"][i] error:nil];
                    
                     ZPFCenterTodayStoriesJSONModel *storiesJsonModel = [[ZPFCenterTodayStoriesJSONModel alloc] initWithDictionary:dic[@"stories"][i] error:nil];
                    
//                    [self.textViewMutableArray addObject:storiesJsonModel.title];
                    
                    [self.textViewMutableArray addObject:storiesJsonModel];
                    
//                                     NSLog(@"%@", self.textViewMutableArray);
                    
//                    NSLog(@"====%@", self.pictureImageViewMutableArray);
                    
                    //数组转为字符串
//                    NSString *string1 = [storiesJsonModel.images componentsJoinedByString:@","];
//
//                    NSURL *url1 = [NSURL URLWithString:string1];
//
//                    NSData *data = [NSData dataWithContentsOfURL:url1];
//
//                    [self.pictureImageViewMutableArray addObject:data];

                    //UIImage *image = [UIImage imageWithData:data];

                    //[self.pictureImageViewMutableArray addObject:image];
//
                    
                }
                for (int i = 0; i < self.centerTodayJsonModel.top_stories.count; i++){
                    ZPFCenterTodayTop_storiesJSONModel *topStoriesModel = [[ZPFCenterTodayTop_storiesJSONModel alloc] initWithDictionary:dic[@"top_stories"][i] error:nil];
                    //                                        NSLog(@"-====%@", topStoriesModel.image);
                    
                   
                   // [self.scrollerViewMutableArray addObject:topStoriesModel.image];
                    
//                    NSURL *url2 = [NSURL URLWithString:topStoriesModel.image];
//
//                    NSData *data1 = [NSData dataWithContentsOfURL:url2];
//
//                    UIImage *image1 = [UIImage imageWithData:data1];
//                    [self.scrollerViewMutableArray addObject:image1];
                    
                    //                    NSLog(@"&&&&&&%ld", self.scrollerViewMutableArray.count);
                    //                    NSLog(@"%@", self.scrollerViewMutableArray);
                    
                }
                
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    [self.tableView reloadData];
//                }];
                
            } else {
                NSLog(@"%@", error);
            }
        }];
        [dataTask resume];
    });
}



@end

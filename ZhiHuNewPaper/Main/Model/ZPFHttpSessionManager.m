//
//  ZPFHttpSessionManager.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/9.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFHttpSessionManager.h"
#import "ZPFCenterTodayJSONModel.h"


@implementation ZPFHttpSessionManager

static ZPFHttpSessionManager *manager = nil;

+ (id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)fetchCoordinateDataWithPointID:(int)id succeed:(ZPFCenterTodayHandle)succeedBlock error:(ErrorHandle)errorBlock {
        NSString *string = @"https://news-at.zhihu.com/api/4/news/latest";
        NSString *urlString = [[NSString alloc] init];
        urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            

            if (data && error ==  nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                ZPFCenterTodayJSONModel *model = [[ZPFCenterTodayJSONModel alloc] initWithDictionary:dic error:&error];
                succeedBlock(model);
                
            } else {
//                NSLog(@"%@", error);
                errorBlock(error);
            }
        }];
    
        [dataTask resume];
}





@end

//
//  ZPFHttpSessionManager.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/9.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFHttpSessionManager.h"
#import "ZPFCenterTodayJSONModel.h"
#import "ZPFSelectJsonModel.h"
#import "ZPFCommentJSONModel.h"
#import "ZPFExtraCommentJSONModel.h"
#import "LHDataBaseManager.h"


@implementation ZPFHttpSessionManager

static ZPFHttpSessionManager *manager = nil;

+ (id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)fetchCoordinateDataWithsucceed:(ZPFCenterTodayHandle)succeedBlock error:(ErrorHandle)errorBlock {
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

- (void)fetchCoordinateDataWithPointTime:(NSString *)date succeed:(ZPFSelectTodayHandle)selectSucceedBlock error:(ErrorHandle)errorBlock {
        NSString *string = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@", date];
        NSString *urlString = [[NSString alloc] init];
        urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data && error ==  nil) {
                NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                ZPFSelectJsonModel *selectModel = [[ZPFSelectJsonModel alloc] initWithDictionary:dic1 error:&error];
                
                selectSucceedBlock(selectModel);
                
                    
            } else {
                errorBlock(error);
            }
        }];
            
        [dataTask resume];
}

- (void)fetchLongComment:(NSString *)idString succeed:(ZPFCommentHandle)commentSucceedBlock error:(ErrorHandle)errorBlock {
    NSString *string = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments", idString];
    NSString *urlString = [[NSString alloc] init];
    urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && error ==  nil) {
            NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            ZPFCommentJSONModel *commentModel = [[ZPFCommentJSONModel alloc] initWithDictionary:dic1 error:&error];
            
            commentSucceedBlock(commentModel);
        
        } else {
            errorBlock(error);
        }
    }];
    
    [dataTask resume];
}

- (void)fetchShortComment:(NSString *)idString succeed:(ZPFCommentHandle)shortCommentSucceedBlock error:(ErrorHandle)errorBlock {
    NSString *string = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments", idString];
    NSString *urlString = [[NSString alloc] init];
    urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && error ==  nil) {
            NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            ZPFCommentJSONModel *commentShortModel = [[ZPFCommentJSONModel alloc] initWithDictionary:dic1 error:&error];
            
            shortCommentSucceedBlock(commentShortModel);
            
        } else {
            errorBlock(error);
        }
    }];
    
    [dataTask resume];
}

- (void)fetchExtraComment:(NSString *)idString succeed:(ZPFExtraCommentHandle)extraCommentSucceedBlock error:(ErrorHandle)errorBlock {
    NSString *string = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story-extra/%@", idString];
    NSString *urlString = [[NSString alloc] init];
    urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && error ==  nil) {
            NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            ZPFExtraCommentJSONModel *extraCommentModel = [[ZPFExtraCommentJSONModel alloc] initWithDictionary:dic1 error:&error];
            extraCommentSucceedBlock(extraCommentModel);
            
        } else {
            errorBlock(error);
        }
    }];
    
    [dataTask resume];
}

@end

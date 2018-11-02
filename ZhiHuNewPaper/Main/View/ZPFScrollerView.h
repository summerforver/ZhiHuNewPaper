//
//  ZPFScrollerView.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZPFScrollerView;
@protocol ATCarouselViewDelegate <NSObject>
@optional
/**
 *  点击图片的回调事件
 */
- (void)carouselView:(ZPFScrollerView *)carouselView indexOfClickedImageBtn:(NSUInteger)index;
@end



@interface ZPFScrollerView : UIView <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;

//传入图片数组
@property (nonatomic, copy) NSArray *images;
//pageControl颜色设置
@property (nonatomic, strong) UIColor *currentPageColor;
@property (nonatomic, strong) UIColor *pageColor;
//是否竖向滚动
@property (nonatomic, assign, getter=isScrollDorectionPortrait) BOOL scrollDorectionPortrait;

@property (weak, nonatomic) id<ATCarouselViewDelegate> delegate;
@end

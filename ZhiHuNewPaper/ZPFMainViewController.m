//
//  ZPFMainViewController.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFMainViewController.h"
#import "ZPFLeftViewController.h"
#import "ZPFCenterViewController.h"
#import "ZPFOtherViewController.h"
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height


@interface ZPFMainViewController () <LeftControllerDelegate>
/**菜单控制器*/
@property (nonatomic, strong) ZPFLeftViewController *leftViewController;
/**用来存放和记录当前呈现的主控制器界面*/
@property(strong,nonatomic)UIViewController *contentController;
/**记录容器控制器中，要管理多少个这样的界面*/
@property(strong,nonatomic)NSArray *viewControllers;
/**标记当前菜单是打开还是关闭状态*/
@property(assign,nonatomic,readonly)BOOL isMenuOpen;
/**记录视图控制器在数组中的位置*/
@property(assign,nonatomic) NSUInteger controllerIndex;
/**判断动画是否正在执行*/
@property(assign,nonatomic,readonly)BOOL isAnimating;

@end

@implementation ZPFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMenuViewController];
    [self addContentControllers];
}

/**封装菜单界面*/
- (void)addMenuViewController
{
    //  创建菜单控制器
    [self setLeftViewController:[[ZPFLeftViewController alloc]init]];
    [self addChildViewController:self.leftViewController];
    [self.view addSubview:self.leftViewController.view];
    self.leftViewController.delegate = self;
}

/**添加子控制器对像*/
- (void)addContentControllers
{
    /*
     完成两个主控制视图的添加
     */
    ZPFCenterViewController *centerController = [[ZPFCenterViewController alloc]init];
    UINavigationController *navCenterController = [[UINavigationController alloc]initWithRootViewController:centerController];
    
    ZPFOtherViewController *otherController = [[ZPFOtherViewController alloc]init];
    UINavigationController *navOtherController = [[UINavigationController alloc]initWithRootViewController:otherController];
    
    [self setViewControllers:@[navCenterController, navOtherController]];
    [self setContentController:navCenterController];
    
  
}

/**完成控制器的添加和移除*/
-(void)setContentController:(UIViewController *)contentController
{
    if (_contentController == contentController){
        return;
    }
    
    //      内容控制器起始坐标不一致
    if (_contentController) {
        contentController.view.transform = _contentController.view.transform;
    }
    
    [_contentController.view removeFromSuperview];  //   移除旧的视图
    [_contentController removeFromParentViewController]; //   解除父子控制器关系
    
    //  增添传进来的视图
    _contentController = contentController;
    [self addChildViewController:contentController];
    [self.view addSubview:contentController.view];
    
    
}

/**侧边按钮的动画*/
- (void)openCloseMenu
{
    
    if (_isAnimating) {
        return;
    }
    [UIView animateWithDuration:0.1 animations:^{
        _isAnimating = YES;
        if(!_isMenuOpen){
            self.contentController.view.transform = CGAffineTransformMakeTranslation(220.0/375.0 * ZPFWidth, 0);
        }
        else {
            //           self.contentController.view.transform = CGAffineTransformMakeTranslation(CGRectGetMaxX(self.view.bounds), 0);
            self.contentController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        }
    }completion:^(BOOL finished) {
        _isMenuOpen = !_isMenuOpen;
        [self setContentController:self.viewControllers[self.controllerIndex]];
        if (!_isMenuOpen ) {
            [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                self.contentController.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                _isAnimating = NO;
            }];
        }
        else {
            _isAnimating = NO;
        }
        
    }];
    
    
}
/**代理方法的实现*/
- (void)leftController: (ZPFLeftViewController *)controller didSelectItemAtIndex: (NSUInteger)index;

{
    [self setControllerIndex:index];
    
    [self openCloseMenu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

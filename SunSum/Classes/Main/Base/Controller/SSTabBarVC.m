//
//  SSTabBarVC.m
//  SunSum
//
//  Created by hank on 2018/9/5.
//  Copyright © 2018年 hank. All rights reserved.
//

#import "SSTabBarVC.h"
#import "SSNavigationVC.h"
#import "SSHomePageVC.h"
//#import "SSThridHomeVC.h"
#import "SSSNewHomePageVC.h"
#import "SSStoreHomeVC.h"
#import "SSMemberHomeVC.h"
#import "SSShoppingCartVC.h"
//#import "SSMineHomeVC.h"
#import "SSNewMineHomeVC.h"
#import "ZLWebVC.h"
#import "SSProductShoppingCartVC.h"
#import "SSLoginVC.h"
#import "SSIMageVC.h"
#import "AppDelegate.h"
#import "SSMemberHomeVC.h"

//#import "SSSNewHomePageVC.h"
#import "SSFourHomeVC.h"
#import "SSBynamicHomeVC.h"
#import "SSFilterGoodVC.h"
#import "SSClerkPushTaskVC.h"
#import "SSFourClerkHomeVC.h"

@interface SSTabBarVC ()<UITabBarControllerDelegate>

@property (nonatomic, strong) SSNewMineHomeVC *mine;
@end

@implementation SSTabBarVC

- (void)dealloc{
    kNSNotificationCenterDealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    if(kCurrentUser.user_type == 3){
        // 1.初始化子控制器
        SSFourHomeVC *home = [[SSFourHomeVC alloc] init];
        [self addChildVc:home title:@"首页" image:@"home" selectedImage:@"home_s"];
        
        SSFilterGoodVC *store = [[SSFilterGoodVC alloc] initWithcategory_id:@"0" title:@"优选"];
        //    SSIMageVC *store = [[SSIMageVC alloc]initWithType:SSMainStoreStyle];
        [self addChildVc:store title:@"商城" image:@"store" selectedImage:@"store_s"];
        
        
        SSBynamicHomeVC *dynamic = [[SSBynamicHomeVC alloc] init];
        //    SSIMageVC *store = [[SSIMageVC alloc]initWithType:SSMainStoreStyle];
        [self addChildVc:dynamic title:@"动态" image:@"dynamic" selectedImage:@"dynamic_s"];
        
        
        SSClerkPushTaskVC *shopcart = [[SSClerkPushTaskVC alloc] init];
        [self addChildVc:shopcart title:@"任务" image:@"pushTask" selectedImage:@"pushTask_s"];
        
        self.mine = [[SSNewMineHomeVC alloc] init];
        [self addChildVc:self.mine  title:@"我的" image:@"mine" selectedImage:@"mine_s"];
    }else if (kCurrentUser.user_type == 5){
        SSFourClerkHomeVC *home = [[SSFourClerkHomeVC alloc] init];
        [self addChildVc:home title:@"首页" image:@"home" selectedImage:@"home_s"];
    
        SSBynamicHomeVC *dynamic = [[SSBynamicHomeVC alloc] init];
        [self addChildVc:dynamic title:@"动态" image:@"dynamic" selectedImage:@"dynamic_s"];
        
        self.mine = [[SSNewMineHomeVC alloc] init];
        [self addChildVc:self.mine  title:@"我的" image:@"mine" selectedImage:@"mine_s"];
    }
    [self getUnMeaasge];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName :kSSPink
                                                        } forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName :kSSblack
                                                        } forState:UIControlStateNormal];
    if([SSUserInfoModel isLogin]){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUnMeaasge) name:kUnMessage object:nil];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout) name:kUserLogout object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogin) name:kUserLogin object:nil];
}

- (void)userLogout{
    self.mine.tabBarItem.badgeValue = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kUnMessage object:nil];
}

- (void)userLogin{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUnMeaasge) name:kUnMessage object:nil];
}
- (void)getUnMeaasge{
    if([SSUserInfoModel isLogin]){
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSInteger unmessgae = appDelegate.unMessageCount;
            NSString *str = @(unmessgae).description;
            if(appDelegate.unMessageCount>99){
                str = @"99+";
            }
            self.mine.tabBarItem.badgeValue = unmessgae==0?nil:str;
        });
    }
}

#pragma mark - Private Method

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置子控制器的图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    childVc.title=title;
    SSNavigationVC *nav = [[SSNavigationVC alloc] initWithRootViewController:childVc];
    if([title isEqualToString:@"首页"]){
        childVc.title =@"鲜橙智店";
        childVc.tabBarItem.title=@"首页";
    }
    if([title isEqualToString:@"任务"]){
        childVc.title =@"发布任务";
        childVc.tabBarItem.title=@"任务";
    }
    [self addChildViewController:nav];
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{//每次点击都会执行的方法
    if([viewController.tabBarItem.title isEqualToString:@"购物车"]||[viewController.tabBarItem.title isEqualToString:@"我的"]||[viewController.tabBarItem.title isEqualToString:@"动态"]||[viewController.tabBarItem.title isEqualToString:@"任务"]){
        if([SSUserInfoModel isLogin]){
            return YES;
        }
        [SSWxLoginVC presentLoginVCWithSuccessHandler:^(id object) {
            
        } failHandler:^(id object) {
            
        }];
        return NO;
        
    }
    return YES;
    
}
@end

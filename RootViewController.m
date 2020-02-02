//
//  RootViewController.m
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.
//

#import "RootViewController.h"
#import "SDCycleScrollView.h"
#import "StoreViewController.h"
#import "SignInViewController.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollerView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"username"] == nil) {
        SignInViewController *signInVC = [[SignInViewController alloc] init];
        
        [self presentViewController:signInVC animated:YES completion:nil];
    }
    
    UIImage *myImage = [[UIImage imageNamed:@"tab_home_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.tabBarItem setSelectedImage:myImage];
    
    self.scrollerView.contentSize = CGSizeMake(WiGHTH, HEIGHT-110);
    SDCycleScrollView *sdView = [SDCycleScrollView cycleScrollViewWithFrame:self.headerView.bounds imageNamesGroup:@[@"can_3",@"can_4",@"can_5",@"can_6"]];
    [self.headerView addSubview:sdView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (IBAction)btnClick1:(id)sender {
    StoreViewController *storeVC = AllocWithStoryboardID(@"StoreViewController");
    storeVC.page = 2;
    UIButton *button = (UIButton *)sender;
    storeVC.title = button.titleLabel.text;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:storeVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
- (IBAction)btnClick2:(id)sender {
    StoreViewController *storeVC = AllocWithStoryboardID(@"StoreViewController");
    storeVC.page = 3;
    UIButton *button = (UIButton *)sender;
    storeVC.title = button.titleLabel.text;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:storeVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
- (IBAction)btnClick3:(id)sender {
    UIButton *button = (UIButton *)sender;
    StoreViewController *storeVC = AllocWithStoryboardID(@"StoreViewController");
    storeVC.page = 4;
    storeVC.title = button.titleLabel.text;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:storeVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
- (IBAction)btnClick4:(id)sender {
    UIButton *button = (UIButton *)sender;
    StoreViewController *storeVC = AllocWithStoryboardID(@"StoreViewController");
    storeVC.page = 5;
    storeVC.title = button.titleLabel.text;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:storeVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
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

//
//  OrderViewController.m
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderModel.h"
#define OrderUrl @"http://newapi.etaoshi.com/Supplier/GetDishList?channel=AppStore&deviceId=4AF3B943-11BD-4323-8C39-7D612CA5314A&food_type=1&platform=iPhone&shop_id=%@&version_code=310"


#import "YuDingViewController.h"
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UITableView *MenuTableView;
@property (nonatomic,strong) UITableView *DetailTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableDictionary *selectDict;
@property (nonatomic,strong) UILabel *allLabel;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    self.selectDict = [[NSMutableDictionary alloc] init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"预定" style:UIBarButtonItemStylePlain target:self action:@selector(btnClick:)];
    self.navigationItem.rightBarButtonItem = item;
    [self createTableView];
    [self dataLoad];
    [self createToolBar];
    // Do any additional setup after loading the view.
}
- (void)btnClick:(UIBarButtonItem *)item {
    YuDingViewController *yudingVC = AllocWithStoryboardID(@"YuDingViewController");
    yudingVC.shop_id = self.shop_id;
    [self.navigationController pushViewController:yudingVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createTableView {
    self.MenuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, HEIGHT) style:UITableViewStylePlain];
    self.MenuTableView.delegate = self;
    self.MenuTableView.dataSource = self;
    [self.view addSubview:self.MenuTableView];
    self.DetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(80, 64, WiGHTH-80, HEIGHT) style:UITableViewStyleGrouped];
    self.DetailTableView.delegate = self;
    self.DetailTableView.dataSource = self;
    [self.view addSubview:self.DetailTableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.MenuTableView) {
        return 1;
    }else {
        return self.dataArr.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.MenuTableView) {
        return self.dataArr.count;
    }else {
        return [self.dataArr[section][@"food_list"] count];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.font = [UIFont systemFontOfSize:8];
    [view addSubview:label];
    
    if (tableView == self.MenuTableView) {
        label.text = @"菜单";
    }else {
        label.text = [NSString stringWithFormat:@"%@",self.dataArr[section][@"category_name"]];
    }
    return view;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.DetailTableView) {
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.MenuTableView) {
        NSInteger f = 0;
        for (int i = 0; i < indexPath.row; i++) {
            f = f + [self.dataArr[i][@"food_list"] count];
        }
        [UIView animateWithDuration:.5f animations:^{
            self.DetailTableView.contentOffset = CGPointMake(0, 44 * f + 20 * indexPath.row);
        }];
       
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.MenuTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menu"];
            
        }
        cell.textLabel.text = self.dataArr[indexPath.row][@"category_name"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"menu"];
            
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"-" forState:UIControlStateNormal];
        btn.frame = CGRectMake(WiGHTH-80-100, 10, 20, 20);
        [cell.contentView addSubview:btn];
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn2 setTitle:@"+" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(subClick:) forControlEvents:UIControlEventTouchUpInside];
        btn2.frame = CGRectMake(WiGHTH-80-40, 10, 20, 20);
        [cell.contentView addSubview:btn2];
        //btn
        [btn2 addTarget:self action:@selector(subClick:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = btn.tag = indexPath.row+indexPath.section*1000;
        
        UILabel *label = [cell.contentView viewWithTag:100];
        [label removeFromSuperview];
        UILabel *Numlabel = [[UILabel alloc] initWithFrame:CGRectMake(WiGHTH-80-90, 10, 60, 20)];
        Numlabel.textAlignment = NSTextAlignmentCenter;
        NSNumber *orderId = self.dataArr[indexPath.section][@"food_list"][indexPath.row][@"food_id"];
        
        OrderModel *model = self.selectDict[orderId];
        if ([self.selectDict.allKeys containsObject:orderId]) {
            Numlabel.text = model.orderNumber;
        }else {
            Numlabel.text = @"0";
        }
        Numlabel.font = [UIFont systemFontOfSize:8];
        Numlabel.tag = 100;
        [cell.contentView addSubview:Numlabel];
        
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        cell.textLabel.text = self.dataArr[indexPath.section][@"food_list"][indexPath.row][@"food_name"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:8];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",self.dataArr[indexPath.section][@"food_list"][indexPath.row][@"food_price"]];
        return cell;

    }
    
}
- (void)subClick:(UIButton *)btn {
    NSInteger section = btn.tag / 1000;
    NSInteger row = btn.tag % 1000;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:section];
    UITableViewCell *cell = [self.DetailTableView cellForRowAtIndexPath:indexpath];
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    NSInteger num = label.text.integerValue;
    if ([btn.currentTitle isEqualToString:@"-"]) {
        if (num==0) {
            return;
        }else {
            num--;
        }
    }
    if ([btn.currentTitle isEqualToString:@"+"]) {
        num++;
    }
    label.text = [NSString stringWithFormat:@"%ld",num];
    
    NSString *orderName = self.dataArr[section][@"food_list"][row][@"food_name"];
    NSString *orderPrice = self.dataArr[section][@"food_list"][row][@"food_price"];
    NSNumber *FOODid = self.dataArr[section][@"food_list"][row][@"food_id"];
    OrderModel *model = [[OrderModel alloc] init];
    model.orderName = orderName;
    model.orderPrice = orderPrice;
    model.orderNumber = label.text;
    [self.selectDict setObject:model forKey:FOODid];
    
    NSInteger allMoney = 0;
    
    for ( NSNumber * key in self.selectDict.allKeys) {
        OrderModel *model = self.selectDict[key];
        allMoney = allMoney + model.orderNumber.integerValue * model.orderPrice.integerValue;
    }
    _allLabel.text = [NSString stringWithFormat:@"总价：%ld",allMoney];

    //UITableViewCell *cell = [self.DetailTableView cellForRowAtIndexPath:];
}

- (void)dataLoad {
    AFHTTPRequestOperationManager *homeRequest = [AFHTTPRequestOperationManager manager];
    
    NSString *HostUrl = [NSString stringWithFormat:OrderUrl,self.shop_id];
    
    [homeRequest GET:HostUrl  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status_code"] isEqualToNumber:@1]) {
            [self.dataArr addObjectsFromArray:responseObject[@"data"][@"category_list"] ];
            NSLog(@"%@",self.dataArr);
            [self.MenuTableView reloadData];
            [self.DetailTableView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    } ];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (void)createToolBar {
    self.allLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
       [self.navigationController.toolbar addSubview:self.allLabel];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"下单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Sure) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(WiGHTH-100, 0, 80, 40);
    [self.navigationController.toolbar addSubview:btn];
}
- (void)Sure {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否下单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
        
        }
            break;
        case 1: {
            NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
            NSMutableArray *saveDict = [[NSMutableArray alloc] init];
            for (NSString *key in self.selectDict.allKeys) {
                OrderModel *model = self.selectDict[key];
                NSDictionary *dict = @{@"ordername":model.orderName,@"orderprice":model.orderPrice,@"ordernum":model.orderNumber};
                [saveDict addObject:dict];
            }
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *plistPath1= [paths objectAtIndex:0];
            
            NSLog(@"%@",plistPath1);
            //得到完整的路径名
            NSString *fileName = [plistPath1 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",username]];
            NSFileManager *fm = [NSFileManager defaultManager];
            if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
                
                [saveDict writeToFile:fileName atomically:YES];
                NSLog(@"文件写入完成");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"下单成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
        }
            break;
        default:
            break;
    }
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

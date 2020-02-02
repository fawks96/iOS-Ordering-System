//
//  StoreViewController.m
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.
//

#import "StoreViewController.h"
#import "MXPullDownMenu.h"
#import "StoreCell.h"
#import "MJRefresh.h"
#define URL @"http://newapi.etaoshi.com/Supplier/SupplierLists?latitude=39.915763&longitude=116.434794&menu_id=%ld&order_type=0&page=%ld&page_size=10&platform=iPhone&sale_id=0&sort_id=%ld"
#import "StoreModel.h"
#import "OrderViewController.h"
#import "SearchViewController.h"
@interface StoreViewController ()<MXPullDownMenuDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger menuId;
    NSInteger sortId;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_page == 0) {
        _page = 1;
    }
    self.dataArr = [[NSMutableArray alloc] init];
    self.title = @"商家";
    [self createGoodTopView];
    [self createTableView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"🔍" style:UIBarButtonItemStylePlain target:self action:@selector(btnClick:)];
    self.navigationItem.rightBarButtonItem = item;

    // Do any additional setup after loading the view.
}
- (void)btnClick:(UIBarButtonItem *)item {
    SearchViewController *search = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:search animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createGoodTopView {
    NSArray *arr = @[@[@"全部菜系",@"中式",@"川菜",@"西餐",@"快餐"],@[@"默认排序",@"配送费低",@"起送费低"]];
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:arr selectedColor:[UIColor blackColor]];
    menu.delegate = self;
    menu.frame = CGRectMake(0, 64, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
}


- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
    NSLog(@"row:%d col:%d",row,column);
    if (column == 1) {
        if (row == 0) {
            sortId = 0;
        }else if (row == 1) {
            sortId = 8;
        }else if (row == 2) {
            sortId = 6;
        }
    }else if (column == 0) {
        if (row == 0) {
            menuId = 0;
        }else if (row == 1) {
            menuId = 16;
        }else if (row == 2) {
            menuId = 22;
        }else if (row == 3) {
            menuId = 38;
        }else if (row == 4) {
            menuId = 55;
        }
    }
    [self.dataArr removeAllObjects];
    [self dataLoad];

}
- (void)dataLoad {
    AFHTTPRequestOperationManager *homeRequest = [AFHTTPRequestOperationManager manager];
    
    NSString *HostUrl = [NSString stringWithFormat:URL,menuId,_page,sortId];
    
    [homeRequest GET:HostUrl  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if (_page == 1) {
            [self.dataArr removeAllObjects];
        }
        if ([responseObject[@"status_code"] isEqualToNumber:@1]) {
            if (![responseObject[@"data"][@"ListData"] isKindOfClass:[NSString class]]) {
                for (NSDictionary *dict in responseObject[@"data"][@"ListData"]) {
                    StoreModel *model = [[StoreModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataArr addObject:model];
                }
            }
            
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
            [self.tableView footerEndRefreshing];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
       
        
    } ];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 81;
}

- (void)addFooter
{   __weak StoreViewController *new = self;
    __weak UITableView *tableView = self.tableView;
    
    [self.tableView addFooterWithCallback:^{
        _page++;
        [new dataLoad];
    }];
}

- (void)addHeader
{
    __weak StoreViewController *vc = self;
    
    [self.tableView addHeaderWithCallback:^{
        
        [vc dataLoad];
    }];
    
    // 马上进入刷新状态
    //    [myTableView.header beginRefreshing];
    
}


- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64+49, WiGHTH, HEIGHT-64-49) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"store"];
    [self.view addSubview:self.tableView];
    [self addFooter];
    [self addHeader];
    self.tableView.headerBeginRefreshing;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"store"];
    StoreModel *model = self.dataArr[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.shop_icon] placeholderImage:[UIImage imageNamed:@"zanwu.jpg"]];;
    cell.lab1.text = model.shop_name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab2.text = [NSString stringWithFormat:@"配送费%@，起送费%@",model.shop_send_price,model.shop_delivery_price];
    cell.lab3.text = [NSString stringWithFormat:@"平均送达时间%@",model.shop_avg_send_time];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderViewController *order = [[OrderViewController alloc] init];
    StoreModel *model = self.dataArr[indexPath.row];
    order.title = model.shop_name;
    order.shop_id = model.shop_id;
    order.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:order animated:YES];

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

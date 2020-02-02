//
//  SearchViewController.m
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.
//

#import "SearchViewController.h"
#import "StoreModel.h"
#import "OrderViewController.h"
#import "StoreCell.h"
#define URl @"http://newapi.etaoshi.com/Supplier/SupplierLists?channel=AppStore&deviceId=4AF3B943-11BD-4323-8C39-7D612CA5314A&latitude=39.915763&longitude=116.434794&page=1&page_size=10&platform=iPhone&search_content=%@&version_code=310"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation SearchViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.dataArr = [[NSMutableArray alloc] init];
    [self createsearchBtn];
    // Do any additional setup after loading the view.
}
- (void)createsearchBtn {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"store"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (IBAction)searchClick:(id)sender {
    
    if ([self.searchText.text isEqualToString: @""]) {
        return;
    }
    [self.searchText resignFirstResponder];
    [self.dataArr removeAllObjects];
    [self dataLoad];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"store"];
    StoreModel *model = self.dataArr[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.shop_icon]];;
    cell.lab1.text = model.shop_name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab2.text = [NSString stringWithFormat:@"配送费%@，起送费%@",model.shop_send_price,model.shop_delivery_price];
    cell.lab3.text = [NSString stringWithFormat:@"平均送达时间%@",model.shop_avg_send_time];
    return cell;
    
    
}

- (void)dataLoad {
    AFHTTPRequestOperationManager *homeRequest = [AFHTTPRequestOperationManager manager];
    
    NSString *HostUrl = [NSString stringWithFormat:URl,_searchText.text];
    NSLog(@"%@",HostUrl);
    
    [homeRequest GET:[HostUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"status_code"] isEqualToNumber:@1]) {
            if ([responseObject[@"data"][@"ListData"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in responseObject[@"data"][@"ListData"]) {
                    StoreModel *model = [[StoreModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataArr addObject:model];
                }
                
            }else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"未找到相关商家" delegate: self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
            
            [self.tableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    } ];//拉面
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 81;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderViewController *order = [[OrderViewController alloc] init];
    StoreModel *model = self.dataArr[indexPath.row];
    order.title = model.shop_name;
    order.shop_id = model.shop_id;
    order.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:order animated:YES];
    
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

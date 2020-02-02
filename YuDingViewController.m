//
//  YuDingViewController.m
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.
//

#import "YuDingViewController.h"

#define YuDingUrl @"http://newapi.etaoshi.com/Supplier/SupplierDetail?channel=AppStore&deviceId=4AF3B943-11BD-4323-8C39-7D612CA5314A&platform=iPhone&shop_id=%@&version_code=310"

@interface YuDingViewController () <UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopDiZhi;
@property (weak, nonatomic) IBOutlet UIButton *peopleNumberBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (nonatomic, strong) NSArray *pickerArray;
@property (nonatomic, strong) UIView *sureView;
@property (nonatomic, copy) NSString *imageUrl;
@end

@implementation YuDingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预定店铺";
    self.peopleNumberBtn.layer.cornerRadius = 6;
    self.timeBtn.layer.cornerRadius = 6;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd号 HH:mm";
    NSDate *date = [NSDate date];
    [self.timeBtn setTitle:[formatter stringFromDate:date] forState:UIControlStateNormal];
    self.pickerArray = @[@"1人",@"2人",@"3人",@"4人",@"5人",@"6人",@"7人",@"8人",@"9人",@"10人",@"11人",@"12人",@"13人",@"13人以上"];
    [self createView];
    [self dataLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)Save:(id)sender {
    NSMutableDictionary *saveDict = [[NSMutableDictionary alloc] init];
   [saveDict setValue:self.shopName.text forKey:@"storeName"];
    [saveDict setValue:self.peopleNumberBtn.titleLabel.text forKey:@"storeNumber"];
    [saveDict setValue:self.timeBtn.titleLabel.text forKey:@"storeTime"];
    [saveDict setValue:self.imageUrl forKey:@"storeImageUrl"];
    
    NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    
    NSLog(@"%@",plistPath1);
    //得到完整的路径名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@Order.plist",username]];
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:fileName];
    if (dataArr == nil) {
        dataArr = [[NSMutableArray alloc] init];
    }
    [dataArr addObject:saveDict];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [dataArr writeToFile:fileName atomically:YES];
        NSLog(@"文件写入完成");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"预定成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }

    
}
- (void)createView {
    self.sureView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-240, WiGHTH, 40)];
    NSArray *names = @[@"取消",@"确定"];
    for (int i = 0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:names[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake((WiGHTH-100)*i+20, 0, 60, 40);
        [btn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [self.sureView addSubview:btn];
    }
    self.sureView.hidden = YES;
    [self.view addSubview:self.sureView];
}
- (void)sureClick:(UIButton *)btn {
    UIPickerView *picker = [self.view viewWithTag:1000];
    if (btn.tag == 100) {
        
    }
    if (btn.tag == 101) {
        
    }
    self.sureView.hidden = YES;
    [picker removeFromSuperview];
}

- (IBAction)peopleNumber:(id)sender {
    
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, HEIGHT-200, WiGHTH, 200)];
    pickerView.tag = 1000;
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    [pickerView selectRow:0 inComponent:0 animated:YES];
    self.sureView.hidden = NO;
}
- (IBAction)chooseTime:(id)sender {
    UIDatePicker *date = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT-200, WiGHTH, 200)];
    date.tag = 1000;
    date.backgroundColor = [UIColor whiteColor];
    [date addTarget:self action:@selector(dateClick:) forControlEvents:UIControlEventValueChanged];
    date.date = [NSDate date];
    [self.view addSubview:date];
    self.sureView.hidden = NO;
}

- (void)dateClick:(UIDatePicker *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd号 HH:mm";
    [self.timeBtn setTitle:[formatter stringFromDate:date.date] forState:UIControlStateNormal];
}

- (void)dataLoad {
    AFHTTPRequestOperationManager *homeRequest = [AFHTTPRequestOperationManager manager];
    
    NSString *HostUrl = [NSString stringWithFormat:YuDingUrl,self.shop_id];
    
    [homeRequest GET:HostUrl  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status_code"] isEqualToNumber:@1]) {
            NSDictionary *dataDict = [responseObject objectForKey:@"data"];
            self.imageUrl = dataDict[@"shop_icon"];
            [self.shopImageView sd_setImageWithURL:dataDict[@"shop_icon"] placeholderImage:[UIImage imageNamed:@"zanwu.jpg"]];
            self.shopName.text = [NSString stringWithFormat:@"店名:%@",dataDict[@"shop_name"]];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[dataDict[@"shop_address"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                self.shopDiZhi.text = [NSString stringWithFormat:@"店铺地址:%@",dataDict[@"shop_address"]];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    } ];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.peopleNumberBtn setTitle:self.pickerArray[row] forState:UIControlStateNormal];
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

//
//  MyViewController.m
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.


#import "MyViewController.h"
#import "FSMediaPicker.h"
#import "ChangeViewController.h"
#import "GuanyuViewController.h"
#import "SignInViewController.h"
#import "YuDingTableViewController.h"
#import "GouwucheTableViewController.h"

@interface MyViewController () <FSMediaPickerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIView *headerBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *qianmingLabel;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    UIImage *myImage = [[UIImage imageNamed:@"tab_more_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.tabBarItem setSelectedImage:myImage];
    //self.navigationController.title = @"我的";
    self.dataArr = [NSMutableArray arrayWithArray:@[@"我的菜单",@"我的预订",@"修改密码",@"我的签名",@"检查更新",@"关于"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    // 传递 0 代表是找在Documents 目录下的文件。
    
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    // DBNAME 是要查找的文件名字，文件全名
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"user"];
    NSMutableArray * arr = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //NSData *data= UIImagePNGRepresentation(seleImage);
    self.userNameLabel.text = [user objectForKey:@"username"];
    for (NSMutableDictionary*dict in arr) {
        if ([[dict objectForKey:@"username"] isEqualToString:[user objectForKey:@"username"]]) {
            if ([[dict objectForKey:@"userqianming"] isKindOfClass:[NSString class]]) {
                self.qianmingLabel.text = [dict objectForKey:@"userqianming"];
            }
        }
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerBackgroundView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 230;
}
- (void)createView {
    //self.tableView.tableHeaderView = self.headerBackgroundView;
    
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo)];
    self.headerImageView.userInteractionEnabled = YES;
    [self.headerImageView addGestureRecognizer:tapGesture];
    
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    // 传递 0 代表是找在Documents 目录下的文件。
    
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    // DBNAME 是要查找的文件名字，文件全名
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"user"];
    NSMutableArray * arr = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //NSData *data= UIImagePNGRepresentation(seleImage);
    
    for (NSMutableDictionary*dict in arr) {
        if ([[dict objectForKey:@"username"] isEqualToString:[user objectForKey:@"username"]]) {
            if ([[dict objectForKey:@"userimage"] isKindOfClass:[NSData class]]) {
                self.headerImageView.image = [UIImage imageWithData:[dict objectForKey:@"userimage"]];
            }
        }
        
    }
    self.headerImageView.clipsToBounds = YES;
    self.headerImageView.layer.cornerRadius = 50;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 30, WiGHTH-40, 40);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WiGHTH, 70)];
    
    [footerView addSubview:button];
    
    self.tableView.tableFooterView = footerView;
    
}

- (void)btnClick:(UIButton *)button {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:nil forKey:@"username"];
    [user synchronize];
    SignInViewController *signInVC = [[SignInViewController alloc] init];
    [self presentViewController:signInVC animated:YES completion:nil];
}

- (void)Actiondo {
    FSMediaPicker *mediaPicker = [[FSMediaPicker alloc] init];
    mediaPicker.delegate = self;
    [mediaPicker showFromView:self.headerBackgroundView];
}

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    //[self.headerImageView setTitle:nil forState:UIControlStateNormal];
    UIImage *seleImage;
    if (mediaPicker.editMode == FSEditModeNone) {
        [self.headerImageView setImage:mediaInfo.originalImage];
        seleImage = mediaInfo.originalImage;
    } else {
        UIImage *image = [self imageCompressForWidth:mediaPicker.editMode == FSEditModeCircular? mediaInfo.circularEditedImage:mediaInfo.editedImage targetWidth:300];
        seleImage = mediaInfo.editedImage;
        [self.headerImageView setImage:image];
        
    }
    self.headerImageView.clipsToBounds = YES;
    self.headerImageView.layer.cornerRadius = 50;
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    // 传递 0 代表是找在Documents 目录下的文件。
    
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    // DBNAME 是要查找的文件名字，文件全名
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"user"];
    NSMutableArray * arr = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data= UIImagePNGRepresentation(seleImage);
    int i = 0;
    for (NSMutableDictionary*dict in arr) {
        if ([[dict objectForKey:@"username"] isEqualToString:[user objectForKey:@"username"]]) {
            [dict setObject:data forKey:@"userimage"];
            NSDictionary *dic = [dict copy];
            [arr removeObjectAtIndex:i];
            [arr addObject:dic];
            if ([arr writeToFile:filePath atomically:YES]) {
                NSLog(@"图片修改成功");
            }
        }
        i ++;
    }
    //[self createHttpWithImage];
}

//指定宽度按比例缩放
- (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuseIdentifier"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArr[indexPath.row];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        ChangeViewController *changeVC = AllocWithStoryboardID(@"ChangeViewController");
        changeVC.textFieldText = @"请输入新签名";
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:changeVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }else if (indexPath.row == 2) {
        ChangeViewController *changeVC = AllocWithStoryboardID(@"ChangeViewController");
        changeVC.textFieldText = @"请输入新密码";
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:changeVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }else if (indexPath.row == 5) {
        GuanyuViewController *guanyuVC = AllocWithStoryboardID(@"GuanyuViewController");
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:guanyuVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }else if (indexPath.row == 4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"当前已是最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else if (indexPath.row == 1) {
        YuDingTableViewController *yudingVC = AllocWithStoryboardID(@"YuDingTableViewController");
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:yudingVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }else if (indexPath.row == 0) {
        GouwucheTableViewController *gouwuche = [[GouwucheTableViewController alloc] init];
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:gouwuche animated:YES];
        self.hidesBottomBarWhenPushed=NO;
     }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

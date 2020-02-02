//
//  RegisterViewController.m
//  ZYAddressbook
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *TextField1;
@property (weak, nonatomic) IBOutlet UITextField *TextField2;
@property (weak, nonatomic) IBOutlet UITextField *TextField3;
@property (weak, nonatomic) IBOutlet UIButton *ReturnBtn;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ReturnBtn.clipsToBounds = YES;
    self.ReturnBtn.layer.cornerRadius = 8;
    // Do any additional setup after loading the view.
}
- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.TextField1 resignFirstResponder];
    [self.TextField2 resignFirstResponder];
    [self.TextField3 resignFirstResponder];

}

- (IBAction)btnClick:(id)sender {
    if ([_TextField1.text isEqualToString:@""]) {
        [MyTools showAlert:@"请输入账号"];
        
        return;
    }else if ([_TextField2.text isEqualToString:@""]) {
        [MyTools showAlert:@"请输入密码"];
        
        return;
    }else if ([_TextField3.text isEqualToString:@""]) {
        [MyTools showAlert:@"请再次输入密码"];
        
        return;
    }else if (![_TextField3.text isEqualToString:_TextField2.text]) {
        [MyTools showAlert:@"两次密码输入不一致"];
        
        return;
    }else {
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        
        // 传递 0 代表是找在Documents 目录下的文件。
        
        NSString *documentDirectory = [directoryPaths objectAtIndex:0];
        
        // DBNAME 是要查找的文件名字，文件全名
        
        NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"user"];
        
        // 用这个方法来判断当前的文件是否存在，如果不存在，就创建一个文件
        
        if ( ![fileManager fileExistsAtPath:filePath]) {
            
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
            
        }
        NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        if (arr == nil) {
            arr = [NSMutableArray array];
        }
        NSDictionary *dic = @{@"username":_TextField1.text,@"userpassword":_TextField2.text,@"userimage":@""};
        [arr addObject:dic];
        if ([arr writeToFile:filePath atomically:YES]) {
            [MyTools showAlert:@"注册成功"];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
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

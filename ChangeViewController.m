//
//  ChangeViewController.m
//  订餐系统
//
//  Created by fawks96 on 16/6/15.
//  Copyright © 2016年 fawks96. All rights reserved.
//

#import "ChangeViewController.h"

@interface ChangeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *againTextField;
@property (weak, nonatomic) IBOutlet UIButton *returnBtn;

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改信息";
    if ([self.textFieldText isEqualToString:@"请输入新签名"]) {
        self.againTextField.hidden = YES;
    }
    self.returnBtn.layer.cornerRadius = 6;
    self.textField.placeholder = self.textFieldText;
    // Do any additional setup after loading the view.
}
- (IBAction)returnBtnClick:(id)sender {
    if ([self.textField.text isEqualToString:@""]) {
        [MyTools showAlert:@"不能输入空"];
    }else {
        NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        
        // 传递 0 代表是找在Documents 目录下的文件。
        
        NSString *documentDirectory = [directoryPaths objectAtIndex:0];
        
        // DBNAME 是要查找的文件名字，文件全名
        
        NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"user"];
        NSMutableArray * arr = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        int i = 0;
        if ([self.textFieldText isEqualToString:@"请输入新密码"]) {
            for (NSMutableDictionary*dict in arr) {
                if ([[dict objectForKey:@"username"] isEqualToString:[user objectForKey:@"username"]]) {
                    [dict setObject:self.textField.text forKey:@"userpassword"];
                    NSDictionary *dic = [dict copy];
                    [arr removeObjectAtIndex:i];
                    [arr addObject:dic];
                    if ([arr writeToFile:filePath atomically:YES]) {
                        NSLog(@"密码修改成功");
                    }
                }
                i ++;
            }
        }else {
            for (NSMutableDictionary*dict in arr) {
                if ([[dict objectForKey:@"username"] isEqualToString:[user objectForKey:@"username"]]) {
                    [dict setObject:self.textField.text forKey:@"userqianming"];
                    NSDictionary *dic = [dict copy];
                    [arr removeObjectAtIndex:i];
                    [arr addObject:dic];
                    if ([arr writeToFile:filePath atomically:YES]) {
                        NSLog(@"签名修改成功");
                    }
                }
                i ++;
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.textField isEnabled]) {
        [self.textField resignFirstResponder];
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

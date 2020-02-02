

#import <Foundation/Foundation.h>



#define DEFAULT_HIDE_DELAY 1.0

@interface MyTools : NSObject
+ (void)showAlert:(NSString*)alertString;
+ (BOOL)checkTel:(NSString *)str;
+ (BOOL)checkPasswordInput:(NSString *)text;
+ (NSString *)checkTheString:(NSString *)string;
+ (BOOL)checkValidateNumber:(NSString *)text;
+ (NSString *)getNowDateMethod;
+ (NSString *)replaceStringWithDataString:(NSString *)theString;
+ (float)checTheStringWithHight:(NSString *)theStr font:(float)font;
+ (NSString *)theStringreplaceString:(NSString *)theStr;
+ (float)checTheStringWithWidth:(NSString *)theStr font:(float)font;
+ (BOOL)validateEmail:(NSString *)email;
+ (UIColor *)colorWithHex:(NSString *)hexString;//十六进制转RGB
+ (NSString *)ChineseToUTf8Str:(NSString *)chineseStr;//将汉字转码
+ (NSString *)getAppVersion;//获取当前App版本号
+ (NSString *)getIOSDeviceInfo;//获得当前设备型号
//+(BOOL)checkIdentityCardNo:(NSString*)cardNo;//正则匹配用户身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//提示框
+ (void)showTextHud:(NSString *)text;
+ (void)hideHud;
+ (void)removeHudWindow;
+ (void)showTextHud:(NSString *)text delay:(NSTimeInterval)dalay;
+ (void)showOKHud:(NSString *)text delay:(NSTimeInterval)dalay;
+ (void)showNOHud:(NSString *)text delay:(NSTimeInterval)dalay;
//+ (void)showSmileHud:(NSString *)text delay:(NSTimeInterval)dalay;
+(void)showTextOnlyHud:(NSString *)text delay:(NSTimeInterval)delay;
//收藏成功
+ (void)showCollectSeccedHud:(NSString *)text delay:(NSTimeInterval)dalay;
//取消收藏成功
+ (void)showunCollectSeccedHud:(NSString *)text delay:(NSTimeInterval)dalay;

+(void)showWithLabelProgressWithText:(NSString *)text delay:(NSTimeInterval)delay;

+ (CGSize)setLabelText:(NSString *)string label:(UILabel *)label1;//自适应label
+(NSString *)getLaterDate:(NSDate *)beginDate sep:(int)month;
//时间格式转化
+ (NSString *)nowDateStringFromDate:(NSDate *)nowDate;
+ (NSDate *)nowDateFromString:(NSString *)dateStr;
//返回两个时间差
+ (NSString *)theTimeDifferenceFromOneTime:(NSDate *)firstDate anthorTime:(NSDate *)secondDate;

+(NSInteger)getSepMonthBeginDateStr:(NSString *)beginStr endDateStr:(NSString *)endStr;

+(CGSize)boundingRectWithSize:(CGSize)size str:(NSString *)str font:(int)font;

+(NSString *)separateStr:(NSString *)string;

+(CGSize)suitText:(NSString *)string withSize:(CGSize)size;

+(float)getPropertyFeeWithStartTime:(NSString *)startTime ByEndTime:(NSString *)endTime;


+(float)getPropertyFeeByStartTime:(NSDate *)comStartDate byEndTime:(NSDate *)comEndDate bypFee:(float)pFee byArea:(float)area withArray:(NSMutableArray *)arr;

+(NSDate *)getDateFromString:(NSString *)dateStr;

+ (BOOL)checkUserName : (NSString *) userName;

@end

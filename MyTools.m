

#import "MyTools.h"
#import "MBProgressHUD.h"
@implementation MyTools

static  MBProgressHUD *hud = nil;
static BOOL isAddHud;

+(MBProgressHUD *)sharedManager
{
    @synchronized(hud)
    {
        if(!hud)
        {
            hud = [[MBProgressHUD alloc]init];
            isAddHud = NO;
        }
    }
    return hud;
}
+(void)removeHudWindow
{
    [[MyTools sharedManager] removeFromSuperview];
    isAddHud = NO;
}
+ (void)addHudWindow:(MBProgressHUD *)hudMsg
{
    if (isAddHud == NO) {
        [[[UIApplication sharedApplication].windows objectAtIndex:[[UIApplication sharedApplication].windows count]-1] addSubview:hudMsg];
        isAddHud = YES;
    }
}
+ (void)showTextHud:(NSString *)text
{
    
    MBProgressHUD *hudMsg = [MyTools sharedManager];
    [self addHudWindow:hudMsg];
    hudMsg.mode = MBProgressHUDModeText;
    //hudMsg.animationType = MBProgressHUDAnimationZoomIn;//动画
    hudMsg.labelText = text;
    hudMsg.labelFont = [UIFont systemFontOfSize:14];
    hudMsg.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.80];//颜色
    hudMsg.margin = 10.f;
    hudMsg.yOffset = 150.f;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:1==0?DEFAULT_HIDE_DELAY:1];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:1 == 0?DEFAULT_HIDE_DELAY:1];
//    MBProgressHUD *hudMsg = [MyTools sharedManager];
//    [self addHudWindow:hudMsg];
//    [hudMsg.customView removeFromSuperview];
//    hudMsg.customView = nil;
//    hudMsg.mode = MBProgressHUDModeIndeterminate;
//    hudMsg.labelText = text;
//    [hudMsg show:YES];
    
}
+ (void)showTextHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [MyTools sharedManager];
    [self addHudWindow:hudMsg];
    [hudMsg.customView removeFromSuperview];
    hudMsg.customView = nil    ;
    hudMsg.mode = MBProgressHUDModeIndeterminate;
    hudMsg.labelText = text;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
}
+ (void)showOKHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [MyTools sharedManager];
    [self addHudWindow:hudMsg];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"ToolsImages.bundle"]];
    hudMsg.customView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[bundle pathForResource:@"37x-Checkmark@2x" ofType:@"png"]]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.labelText = text;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}
+ (void)showNOHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [MyTools sharedManager];
    [self addHudWindow:hudMsg];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"ToolsImages.bundle"]];
    hudMsg.customView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[bundle pathForResource:@"37x-Checkmark@2xx" ofType:@"png"]]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.labelText = text;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}
//收藏成功
+ (void)showCollectSeccedHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [MyTools sharedManager];
    [self addHudWindow:hudMsg];
   // NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"ToolsImages.bundle"]];
    hudMsg.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"评价星2"]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.labelText = text;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}
//取消收藏成功
+ (void)showunCollectSeccedHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    MBProgressHUD *hudMsg = [MyTools sharedManager];
    [self addHudWindow:hudMsg];
   // NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"ToolsImages.bundle"]];
    hudMsg.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"评价星1"]];
    hudMsg.mode = MBProgressHUDModeCustomView;
    hudMsg.labelText = text;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
    
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:dalay == 0?DEFAULT_HIDE_DELAY:dalay];
}

+(void)showTextOnlyHud:(NSString *)text delay:(NSTimeInterval)delay
{
    MBProgressHUD *hudMsg = [MyTools sharedManager];
    [self addHudWindow:hudMsg];
    hudMsg.mode = MBProgressHUDModeText;
    //hudMsg.animationType = MBProgressHUDAnimationZoomIn;//动画
    hudMsg.labelText = text;
    //hudMsg.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];//颜色
    hudMsg.margin = 10.f;
    hudMsg.yOffset = 150.f;
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:delay==0?DEFAULT_HIDE_DELAY:delay];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:delay == 0?DEFAULT_HIDE_DELAY:delay];
    
}
+(void)showWithLabelProgressWithText:(NSString *)text delay:(NSTimeInterval)delay
{
    MBProgressHUD *hudMsg = [MyTools sharedManager];
    [self addHudWindow:hudMsg];
    hudMsg.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hudMsg.labelText = text;
     [hudMsg show:YES];
     [hudMsg hide:YES afterDelay:delay == 0?DEFAULT_HIDE_DELAY:delay];
    // myProgressTask uses the HUD instance to update progress
    [hudMsg showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:delay == 0?DEFAULT_HIDE_DELAY:delay];

}

-(void)myProgressTask
{
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        MBProgressHUD *hudMsg = [MyTools sharedManager];
        hudMsg.progress = progress;
        usleep(50000);
    }
}

+ (void)hideHud
{
    [[MyTools sharedManager] hide:YES];
    [self removeHudWindow];
}
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//提示
+ (NSString *)theStringreplaceString:(NSString *)theStr
{
  NSArray * array= [theStr componentsSeparatedByString:@"!"];
    theStr = [array objectAtIndex:0];
    return theStr;
}
//+ (float)checTheStringWithHight:(NSString *)theStr font:(float)font
//{
//    CGSize titleSize = [theStr sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(ScreenWidth-30, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
//    
//    return titleSize.height;
//}
+ (float)checTheStringWithWidth:(NSString *)theStr font:(float)font
{
    CGSize titleSize = [theStr sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    return titleSize.width;
}

+ (void)showAlert:(NSString*)alertString
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:alertString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
//判断手机号码
+ (BOOL)checkTel:(NSString *)str
{
    //^((13[0-9])|(147)|(15[0-9])|(18[0-9]))\\d{8}$
    NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(177)|(18[025-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    NSString * PHS = @"^0(10|2[0-5789]|[3-9]\\d{2})\\d{7,8}$";
    NSPredicate *tePred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    BOOL isMatch = [pred evaluateWithObject:str] || [tePred evaluateWithObject:str];
    return isMatch;
}

+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//判断密码位数
+ (BOOL)checkPasswordInput:(NSString *)text
{
    //    NSString *Regex = @"{6,20}$";
    //    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    //    return [emailTest evaluateWithObject:text];
    
    if (text.length>=6) {
        return YES;
    }else{
        return NO;
    }
}
//判断验证码位数
+ (BOOL)checkValidateNumber:(NSString *)text
{
    if (text.length==4) {
        return YES;
    }else{
        return NO;
    }
}
//判断字符串是否为空 为空时 返回@“”
+ (NSString *)checkTheString:(NSString *)string
{
    NSString *smpSting = string.length>0?string:@"";
    return smpSting;
}
+ (NSString *)getNowDateMethod
{
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    //    date 显示为 2011-11-01 12:12:12
    return date;
}
+ (NSDate *)nowDateFromString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateStr];
    //    date 显示为 2011-11-01 12:12:12
    return date;
}
+ (NSString *)nowDateStringFromDate:(NSDate *)nowDate
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * date = [formatter stringFromDate:nowDate];
    //    date 显示为 2011-11-01 12:12:12
    return date;
}
+ (NSString *)replaceStringWithDataString:(NSString *)theString
{
    NSString *strUrl = [theString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    strUrl = [theString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"	" withString:@""];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"<p>" withString:@" "];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"</p>" withString:@" "];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"<br/>" withString:@" "];
    //    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"<>" withString:@" "];
    return strUrl ;
}
+ (NSString *)checkTheChatStringReplaceFace:(NSString *)theString faceArray:(NSMutableArray *)array
{
    NSRange range=[theString rangeOfString:@"[/"];
    NSRange range1=[theString rangeOfString:@"]"];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[theString substringToIndex:range.location]];
            NSString * strTmp = [theString substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            
            [theString stringByReplacingOccurrencesOfString:strTmp withString:@""];
            [array addObject:[theString substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[theString substringFromIndex:range1.location+1];
            [self checkTheChatStringReplaceFace:str faceArray:array];
        }else {
            NSString *nextstr=[theString substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[theString substringFromIndex:range1.location+1];
                [self checkTheChatStringReplaceFace:str faceArray:array];
            }else {
                
            }
        }
        
    } else if (theString != nil) {
        [array addObject:theString];
    }
    
    
    return theString;
}

//十六进制转RGB
+ (UIColor *)colorWithHex:(NSString *)hexString
{
    if (!hexString || hexString.length==0)
    {
        return nil;
    }
    
    NSString *str=hexString;
    
    if ( ! ([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]))
    {
        str=[NSString stringWithFormat:@"0x%@",hexString];
    }
    
    int rgb;
    sscanf([str cStringUsingEncoding:NSUTF8StringEncoding], "%i", &rgb);
    
    int red=rgb/(256*256)%256;
    int green=rgb/256%256;
    int blue=rgb%256;
    
    UIColor *color=[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    
    return color;
}
+ (NSString *)ChineseToUTf8Str:(NSString*)chineseStr
{
    
    NSString *UTf8Str = [chineseStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return UTf8Str;
}
+ (NSString *)getAppVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    //当前应用软件版本 比如：1.0.1
    NSString *appCurVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    //当前应用版本号码 int类型
    NSString *appCurVersionNum = [infoDic objectForKey:@"CFBundleVersion"];
    //NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    return appCurVersion;
    
}

+ (NSString *) getIOSDeviceInfo
{
   // [[UIDevice currentDevice] identifierForVendor];
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSString * info = [NSString stringWithFormat:@"手机别名: %@ 设备名称: %@ 手机型号: %@",userPhoneName,deviceName,phoneModel];
    return info;
}
#pragma mark - label 自适应 -
+ (CGSize)setLabelText:(NSString *)string label:(UILabel *)label1
{
    label1.text = string;
    //label1.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0f];;
    CGSize size1 =[label1.text sizeWithFont:label1.font constrainedToSize:CGSizeMake(211, 20) lineBreakMode:NSLineBreakByCharWrapping];
    label1.numberOfLines =1;
    return size1;
}

+(CGSize)suitText:(NSString *)string withSize:(CGSize)size
{
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:@
     {
     NSFontAttributeName: [UIFont systemFontOfSize:14]
     }];
    CGRect rect = [attributedText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size;
}

+ (CGSize)boundingRectWithSize:(CGSize)size str:(NSString *)str font:(int)font
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    
    CGSize retSize = [str boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
+(NSString *)separateStr:(NSString *)str
{
    NSArray *arr = [str componentsSeparatedByString:@" "];
    NSString *Str = [arr objectAtIndex:0];
    return Str;
}


+(float)getPropertyFeeByStartTime:(NSDate *)comStartDate byEndTime:(NSDate *)comEndDate bypFee:(float)pFee byArea:(float)area withArray:(NSMutableArray *)arr
{
    float amountFee = 0.0;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    if (arr.count==0) {
        amountFee = [self getPropertyFeeByStartTime:comStartDate byEndTime:comEndDate bypFee:pFee byArea:area];
    }else{
        NSMutableArray *array =[self rankArr:arr];
        for (NSDictionary *tmpDic in array) {
            NSString *staStr = [self separateStr:[tmpDic objectForKey:@"beginDate"]];
            NSString *endStr = [self separateStr:[tmpDic objectForKey:@"endDate"]];
            
            NSDate *startDate = [formatter dateFromString:staStr];
            
            NSDate *endDate = [formatter dateFromString:endStr];
            
            float sFee = [[tmpDic objectForKey:@"specialFee"] floatValue];
            if ([startDate compare:comStartDate]==NSOrderedDescending&&[startDate compare:comEndDate]==NSOrderedAscending) {
                if ([endDate compare:comEndDate]==NSOrderedAscending) {
//                  CLog(@"tmpdic1==%@缴费日期包含规则日期",tmpDic);//（b1---【b2-----e2】--e1）
                   NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:startDate];
                    amountFee+=[self getPropertyFeeByStartTime:comStartDate byEndTime:yesterday bypFee:pFee byArea:area];
                    amountFee+=[self getPropertyFeeByStartTime:startDate byEndTime:endDate bypFee:sFee byArea:area];
                    comStartDate = [NSDate dateWithTimeInterval:60*60*24 sinceDate:endDate];
                }else{
//                    CLog(@"tmpdic1==%@的结束时间不在缴费时间段内,开始时间在缴费时间端内",tmpDic);//（b1---【b2---e1）----e2】
                    NSDate *yesterday = [NSDate dateWithTimeInterval:-60 * 60 * 24 sinceDate:startDate];
                    amountFee+=[self getPropertyFeeByStartTime:comStartDate byEndTime:yesterday bypFee:pFee byArea:area]; //计算b1 - b2时间段
                    amountFee+=[self getPropertyFeeByStartTime:startDate byEndTime:comEndDate bypFee:sFee byArea:area];//计算b2 - e1时间段
                    comStartDate = comEndDate;
                    break;
                    
                }
            }else if ([startDate compare:comStartDate]==NSOrderedAscending){
                if ([endDate compare:comStartDate]==NSOrderedDescending&&[endDate compare:comEndDate]==NSOrderedAscending) {
                    
//                    CLog(@"tmpdic1==%@开始时间不在在缴费时间段内，结束时间在缴费时间段内",tmpDic);////【b2---(b1---e2】----e1)
                    amountFee+=[self getPropertyFeeByStartTime:comStartDate byEndTime:endDate bypFee:sFee byArea:area];//计算b1 - e2时间段
                    comStartDate = [NSDate dateWithTimeInterval:60*60*24 sinceDate:endDate];//因为e2已经算过费用,所以将开始时间设置为e2的后一天
                    
                    
                }else if([endDate compare:comStartDate]==NSOrderedAscending){
//                    CLog(@"tmpdic1==%@都不在缴费时间段内",tmpDic);
                    amountFee+=[self getPropertyFeeByStartTime:comStartDate byEndTime:comEndDate bypFee:pFee byArea:area];
                    comStartDate = comEndDate;
                    break;
                    
                }else if([endDate compare:comEndDate]==NSOrderedDescending){
//                    CLog(@"tmpdic1==%@规则日期包含缴费日期",tmpDic);
                    amountFee+=[self getPropertyFeeByStartTime:comStartDate byEndTime:comEndDate bypFee:sFee byArea:area];
                    comStartDate = comEndDate;
                    break;
                }
            }else if ([startDate compare:comStartDate]==NSOrderedDescending){
//                CLog(@"tmpdic1==%@不在缴费时间段内",tmpDic);
                amountFee+=[self getPropertyFeeByStartTime:comStartDate byEndTime:comEndDate bypFee:pFee byArea:area];
                comStartDate = comEndDate;
                break;
                
            }
            
        }
        
        if ([comStartDate compare:comEndDate]==NSOrderedAscending) {
            amountFee+=[self getPropertyFeeByStartTime:comStartDate byEndTime:comEndDate bypFee:pFee byArea:area];
        }
        
        
        
        
    }
    
    return amountFee;
}


+(float)getPropertyFeeByStartTime:(NSDate *)startDate byEndTime:(NSDate *)endDate bypFee:(float)pFee byArea:(float)area
{
    
    float money = 0.0;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //NSString * date = [formatter stringFromDate:nowDate];
    NSString *startTime = [formatter stringFromDate:startDate];
    
    NSString *endTime = [formatter stringFromDate:endDate];
  
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDate *comStartDate = [self getDateFromString:startTime];
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:comStartDate];
    NSInteger startmonths = [components month];
    NSInteger startyears = [components year];
    NSInteger startday = [components day];
    //NSLog(@"day>>>%ld  months>>>%ld year>>>%ld",(long)startday,(long)startmonths,(long)startyears);
    NSInteger startdays = [self getDaysOfMonthByYear:startyears Month:startmonths];
    //NSLog(@"startdays>>>>%ld",(long)startdays);
    NSInteger startSep = startdays-startday;
    //NSLog(@"startSep>>>>%ld",(long)startSep);
    float price = pFee*area;
   
    
    NSDate *comEndDate = [self getDateFromString:endTime];
    
    NSDateComponents *endComponet = [gregorian components:unitFlags fromDate:comEndDate];
    NSInteger endmonths = [endComponet month];
    NSInteger endyears = [endComponet year];
    NSInteger endday = [endComponet day];
    //NSLog(@"day>>>%ld  months>>>%ld year>>>%ld",(long)endday,(long)endmonths,(long)endyears);
   
    if (endyears == startyears&&endmonths == startmonths) {
        money+=(price/startdays)*((endday-startday)+1);
        
    }else
    {
        //NSInteger sepMonth = [self getSepMonthBeginDateStr:startTime endDateStr:endTime];
        money+=(price/startdays)*(startSep+1);//开始相差的天数
        
        NSInteger enddays = [self getDaysOfMonthByYear:endyears Month:endmonths];
        //NSLog(@"enddays>>>>%ld",(long)enddays);
        money+=(price/enddays)*endday;
        NSInteger sepMonth = (endyears-startyears)*12+(endmonths-startmonths-1);
        
        //NSLog(@"sepMonth>>>%ld",(long)sepMonth);
        money+=price*sepMonth;
    }
    
    
    return money;
}

//按时间排序
+(NSMutableArray *)rankArr:(NSMutableArray *)arr
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
       NSInteger count = arr.count;
    for ( int j = 0; j<count-1; j++) {
        for (int i = 0; i<count-j-1; i++) {
            NSDictionary *dic1 = [arr objectAtIndex:i];
            NSString *startTime1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"beginDate"]];
            NSDate *startDate1 = [formatter dateFromString:startTime1];
            
            NSDictionary *dic2 = [arr objectAtIndex:i+1];
            NSString *startTime2 = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"beginDate"]];
            NSDate *startDate2 = [formatter dateFromString:startTime2];
            
            if ([startDate1 compare:startDate2]==NSOrderedDescending) {
                [arr exchangeObjectAtIndex:i  withObjectAtIndex:i+1];
            }
            
        }
    }
    
    return arr;
    
}

//获取前一天
//+(NSDate *)getFormDateFromdate:(NSDate *)date
//{
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit;
//    NSDateComponents *components = [gregorian components:unitFlags fromDate:date];
//    NSInteger startmonths = [components month];
//    NSInteger startyears = [components year];
//    NSInteger startday = [components day];
//    NSString *timeStr = [NSString stringWithFormat:@"%d-%d-%d",startyears,startmonths,startday-1];
//     NSDate *yesDate = [self nowDateFromString:timeStr];
//    return yesDate;
//}

+(NSDate *)getDateFromString:(NSString *)dateStr
{
     NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromdate=[format dateFromString:dateStr];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate:fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    //NSLog(@"fromdate=%@",fromDate);
    return fromDate;
}

-(NSInteger)getDaysBetweenStartDateStr:(NSString *)beginStr endDateStr:(NSString *)endStr
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags =  NSDayCalendarUnit;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *fromdate=[format dateFromString:beginStr];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate:fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    //NSLog(@"fromdate=%@",fromDate);
    
    NSDate *enddate = [format dateFromString:endStr];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:enddate];
    NSDate *localeDate = [enddate  dateByAddingTimeInterval:interval];
    //NSLog(@"enddate=%@",localeDate);
    NSDateComponents *components = [gregorian components:unitFlags fromDate:fromDate toDate:localeDate options:0];
    NSInteger days = [components day];
    return days;
}

+(NSInteger)getDaysOfMonthByYear:(NSInteger)year Month:(NSInteger)month
{
    int days = 0;
    
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
    {
        days = 31;
    }
    else if (month == 4 || month == 6 || month == 9 || month == 11)
    {
        days = 30;
    }
    else
    { // 2月份，闰年29天、平年28天
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
        {
            days = 29;
        }
        else
        {
            days = 28;
        }
    }
    
    return days;
}
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z一-龥]{2,12}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}


@end

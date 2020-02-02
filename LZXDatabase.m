

#import "LZXDatabase.h"
#import "FMDatabase.h"

@implementation LZXDatabase
{
    //fmdb 数据库操作
    FMDatabase *_database;
}
//单例函数
+ (LZXDatabase *)sharedDatabase {
    static LZXDatabase * database = nil;
    @synchronized(self) {
        if (database == nil) {
            database = [[self alloc] init];
        }
    }
    return database;
}
/*
-（void) sqlit3_create {
 NSString *databasePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent: @"sqlcipher.db"];
 sqlite3 *db;
 if (sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
    const char* key = [@"BIGSecret" UTF8String];
    sqlite3_key(db, key, strlen(key));
    if (sqlite3_exec(db, (const char*) "SELECT count(*) FROM sqlite_master;", NULL, NULL, NULL) == SQLITE_OK) {
        // password is correct, or, database has been initialized
        
    } else {
        // incorrect password!
    }
    sqlite3_close(db);
}
    */
- (id)init {
    if (self = [super init]) {
        
        
        NSString *dataPath = [self getFullPathForDataFile:@"userInfo.db"];
        //或者是userInfo.sqlite
        //创建一个database
        _database = [[FMDatabase alloc] initWithPath:dataPath];
        //创建database 之后 要打开数据库文件
        if ([_database open]) {//如果存在直接打开 不存在 创建再打开
            //打开成功
            [self creatTable];
            //这里 数据库我们只打开一次
            //数据也可以在每次进行增删改查的时候 再打开，执行完之后 关闭，
            
        }else {
            NSLog(@"open database failed!%@",_database.lastErrorMessage);
        }
    }
    return self;
}

#pragma mark - 创建表
- (void)creatTable {
    //创建表的sql语句 这里可以创建多张表
    NSArray * sqls = @[@"create table if not exists user(serial integer  Primary Key Autoincrement,username Varchar(256),uid Varchar(256),headimage Varchar(1024),lastactivity Varchar(256))"];
    for (NSString *sql in sqls) {
        BOOL isSuccess = [_database executeUpdate:sql];
        if (isSuccess) {
            NSLog(@"执行创建表操作成功");
        }else {
            NSLog(@"creat Table failed:%@",_database.lastErrorMessage);
        }
    }
}


//获取 数据库文件在Documents的全路径
- (NSString *)getFullPathForDataFile:(NSString *)fileName {
    NSString *docPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:docPath]) {
        //检测Documents 是否存在
        //返回 fileName 在Documents 中的路径
        return [docPath stringByAppendingFormat:@"/%@",fileName];
    }else {
        NSLog(@"Documents不存在");
        //不存在的话可以自己创建一个 Documents
        return nil;
    }
}
//检测 数据库 是否存在 某个数据
- (BOOL)isExistsModel:(UserModel *)model {
    NSString *sql = @"select * from user where uid = ?";
    //查找 返回一个集合
    FMResultSet *rs = [_database executeQuery:sql,model.uid];
    //如果有下一条数据 就是表示 肯定存在 数据
    if ([rs next]) {
        return YES;
    }
    return NO;
}

//向数据库 中增加一个数据
- (void)insertModel:(UserModel *)model {
    //增加的sql 语句
    //值 一般 用占位符 ?  ?对应的值 必须是对象地址类型
    NSString *sql = @"insert into user(username,uid,headimage,lastactivity) values (?,?,?,?)";
    if ([self isExistsModel:model]) {
        NSLog(@"要增加的数据已经存在uid:%@",model.uid);
    }else {
        
        //不存在那么增加
        BOOL isSuccess = [_database executeUpdate:sql,model.username,model.uid,model.headimage,model.headimage];
        if (!isSuccess) {
            NSLog(@"insert model failed:%@",_database.lastErrorMessage);
        }
    }
}

//增加 多个数据
/*
 对数据库操作的时候 ，每次 插入数据 都有一次对数据的写操作(文件io操作/读写)
 下面插入多条数据 那么就会频繁进行 文件io操作，执行效率是很低的。
 这时 我们一般要开启 事务选项，开启之后 那么在插入多条数据的时候，首先会把这些数据先放在内存，不会写入数据库文件中,当提交事务之后 就会把存在内存中的数据 一块批量写入数据库文件 (写文件只有一次)
 */

- (void)insertMoreModels:(NSArray *)modelArr isBeginTransaction:(BOOL)isBegin{
    if (isBegin) {//YES 表示要开始事务
#if 0  
        //不考虑有异常的情况 开启事务
        [_database beginTransaction];
        //遍历数据一个一个增加
        for (UserModel*model in modelArr) {
            [self insertModel:model];
        }
        [_database commit];
#endif
        //开启事务之后 考虑可能会发生异常
        BOOL isError = NO;
       
        @try {
            
            //@try 可能会出现异常的代码
            //开启事务 准备 插入多个数据
            [_database beginTransaction];
            //遍历数据一个一个增加
            for (UserModel*model in modelArr) {
                //开启事务之后 会先把数据放在内存中
                [self insertModel:model];
            }
        }
        @catch (NSException *exception) {
            //如果上面代码有异常了，那么捕获这个异常
            NSLog(@"exception_reason:%@ name:%@",exception.reason,exception.name);
            //标记一下有异常
            isError = YES;
            [_database rollback];//数据库操作有异常的话要回滚，回滚到数据库初始状态
        }
        @finally {
            //不管有没有异常 这段代码都会 执行
            if (isError == NO) {
                //没有异常
                //提交事务  这时会把放在内存中的数据一次性写入磁盘数据库文件
                [_database commit];
            }
        }

    }else{
        //常规操作 不开启事务 频繁 操作io 效率低
        for (UserModel*model in modelArr) {
            [self insertModel:model];
        }
    }
}

//从数据库中删除指定的数据 根据uid 删除
- (void)deleteModelDataFormUid:(NSString *)uid {
    NSString *sql = @"delete from user where uid = ?";
    BOOL isSuccess = [_database executeUpdate:sql,uid];
    if (!isSuccess) {
        NSLog(@"delete failed!:%@",_database.lastErrorMessage);
    }
}

//删除所有表中数据
- (void)deleteAllData {
    NSString *sql = @"delete from user";
    BOOL isSuccess = [_database executeUpdate:sql];
    if (!isSuccess) {
        NSLog(@"delete failed!:%@",_database.lastErrorMessage);
    }
}


//修改数据中的数据
//根据uid 修改指定的数据
- (void)updateModelDataFromUid:(NSString *)uid newModel:(UserModel *)newModel {
    //表示字段的值 才用? 占位符
    NSString *sql = @"update user set username=?,headimage=?,lastactivity=? where uid=?";
    BOOL isSuccess = [_database executeUpdate:sql,newModel.username,newModel.headimage,newModel.lastactivity,uid];
    if (!isSuccess) {
        NSLog(@"update failed :%@",_database.lastErrorMessage);
    }
}
//查找数据库中所有的数据
- (NSArray *)readAllData {
    NSString *sql = @"select * from user";
    //执行查询语句
    FMResultSet *rs = [_database executeQuery:sql];
    
    NSMutableArray *arr = [NSMutableArray array];
    //遍历集合 把数据 放入数据模型 再把数据模型放入一个数组
    
    while ([rs next]) {
        UserModel *model = [[UserModel alloc] init];
        //解析每个字段放入数据模型
        model.username = [rs stringForColumn:@"username"];
        model.uid = [rs stringForColumn:@"uid"];
        model.headimage = [rs stringForColumn:@"headimage"];
        model.lastactivity = [rs stringForColumn:@"lastactivity"];
        [arr addObject:model];
        [model release];
    }
    return arr;
}

//查找 指定页指定的条数的数据
//从数据库中的指定索引开始 数据30条数据
- (NSArray *)readDataBeginIndex:(NSInteger)index count:(NSInteger)count{
    
    
    NSString *sql = @"select * from user limit ?,?";
    
    //NSString *sql = [NSString stringWithFormat:@"select * from user limit %d,%d",index,count];
    //? 这里对应数字对象
    
    //执行查询语句
    FMResultSet *rs = [_database executeQuery:sql,@(index),@(count)];
    
    NSMutableArray *arr = [NSMutableArray array];
    //遍历集合 把数据 放入数据模型 再把数据模型放入一个数组
    
    while ([rs next]) {
        UserModel *model = [[UserModel alloc] init];
        //解析每个字段放入数据模型
        model.username = [rs stringForColumn:@"username"];
        model.uid = [rs stringForColumn:@"uid"];
        model.headimage = [rs stringForColumn:@"headimage"];
        model.lastactivity = [rs stringForColumn:@"lastactivity"];
        [arr addObject:model];
        [model release];
    }
    return arr;
}
// 根据 uid 升序进行查找
- (NSArray *)readAllDataByTime {
    //最终返回一个数组 数组中 uid 是升序
    NSString *sql = @"select * from user order by uid asc";
    //执行查询语句
    FMResultSet *rs = [_database executeQuery:sql];
    
    NSMutableArray *arr = [NSMutableArray array];
    //遍历集合 把数据 放入数据模型 再把数据模型放入一个数组
    
    while ([rs next]) {
        UserModel *model = [[UserModel alloc] init];
        //解析每个字段放入数据模型
        model.username = [rs stringForColumn:@"username"];
        model.uid = [rs stringForColumn:@"uid"];
        model.headimage = [rs stringForColumn:@"headimage"];
        model.lastactivity = [rs stringForColumn:@"lastactivity"];
        [arr addObject:model];
        [model release];
    }
    return arr;
}
//获取 数据库的数据的条数
- (NSInteger)getDataCount {
    //查询 表的记录条数
    NSString *sql = @"select COUNT(*) from user";
    FMResultSet *rs = [_database executeQuery:sql];
    //这个 查找之后就一条数据
    //返回 一列数据 count(*) 值就是条数
    
    //NSInteger count = [rs intForColumn:@"count(*)"];
    NSInteger count = [rs intForColumnIndex:0];
    
    return count;
}
@end





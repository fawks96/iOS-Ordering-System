

#import <Foundation/Foundation.h>
#import "UserModel.h"

/*
 一个应用程序 一般都有 很多界面 而且这些界面 有可能 要共享数据，或者每个界面 要做一些本地持久化存储 ，那么这时 我们需要设计一个类(采用单例设计模式)，(单例是可以在整个程序中进行共享数据)
 //下面我们实现的一个类 就是一个操作数据库的一个单例类，把界面的数据 进行本地存储 ，存储到数据库中
 //一般数据中 有一张 或者 多张表  一张表对应一个数据模型 如果一个张表存了10条记录 说明 存了 10 数据模型的数据
 
 */

@interface LZXDatabase : NSObject

//单例函数
+ (LZXDatabase *)sharedDatabase;

//向数据库 中增加一个数据
- (void)insertModel:(UserModel *)model;

//增加 多个数据
- (void)insertMoreModels:(NSArray *)modelArr isBeginTransaction:(BOOL)isBegin;

//从数据库中删除指定的数据 根据uid 删除
- (void)deleteModelDataFormUid:(NSString *)uid;

//删除所有表中数据
- (void)deleteAllData;

//修改数据中的数据
- (void)updateModelDataFromUid:(NSString *)uid newModel:(UserModel *)newModel;
//查找数据库中所有的数据
- (NSArray *)readAllData;

//查找 指定页指定的条数的数据
//从 数据库中的 第index 条开始找 count 条数据
- (NSArray *)readDataBeginIndex:(NSInteger)index count:(NSInteger)count;

// 根据 uid 升序进行查找
- (NSArray *)readAllDataByTime;
//获取 数据库的数据的条数
- (NSInteger)getDataCount;


@end



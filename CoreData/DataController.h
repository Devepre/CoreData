#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataController : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (instancetype)initWithCompletionBlock:(void(^)(NSManagedObjectContext *))completionBlock;
- (void)saveContext;

@end

#import <UIKit/UIKit.h>
#import "DataDelegate.h"

#import <CoreData/CoreData.h>
#import "CoreData+CoreDataModel.h"
@class NSFetchedResultsController;

@interface UniversityListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) id<DataDelegate> delegate;

@property (strong, nonatomic) NSFetchedResultsController<NSManagedObject *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

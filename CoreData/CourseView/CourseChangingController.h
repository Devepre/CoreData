#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreData+CoreDataModel.h"
@class NSFetchedResultsController;

@interface CourseChangingController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext    *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField        *nameField;
@property (strong, nonatomic) NSFetchedResultsController<NSManagedObject *> *fetchedResultsController;

@property (nonatomic, strong) NSManagedObject           *currentObject;

@end

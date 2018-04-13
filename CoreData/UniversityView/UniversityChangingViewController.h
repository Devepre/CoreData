#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreData+CoreDataModel.h"
@class NSFetchedResultsController;

@interface UniversityChangingViewController : UITableViewController <UITextFieldDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext    *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField        *nameField;
@property (strong, nonatomic) NSFetchedResultsController<NSManagedObject *> *fetchedResultsController;

@end

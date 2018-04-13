#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DataDelegate.h"

@interface CourseListViewController : UITableViewController <DataDelegate, NSFetchedResultsControllerDelegate>

@end

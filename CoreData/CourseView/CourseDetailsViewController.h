#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreData+CoreDataModel.h"

@interface CourseDetailsViewController : UITableViewController

@property (nonatomic, strong) NSManagedObject           *currentObject;

@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *universityNameLabel;

@end

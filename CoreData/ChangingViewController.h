#import <UIKit/UIKit.h>

@interface ChangingViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext    *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField        *nameField;

@end

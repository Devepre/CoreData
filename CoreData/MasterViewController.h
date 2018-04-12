#import <UIKit/UIKit.h>
#import "DataDelegate.h"

@interface MasterViewController : UITableViewController

@property (weak, nonatomic) id<DataDelegate> delegate;

@end

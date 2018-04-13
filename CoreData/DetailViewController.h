#import <UIKit/UIKit.h>
#import "DataDelegate.h"

@interface DetailViewController : UITableViewController <DataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

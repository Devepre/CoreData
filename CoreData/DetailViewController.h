#import <UIKit/UIKit.h>
#import "DataDelegate.h"

@interface DetailViewController : UIViewController <DataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

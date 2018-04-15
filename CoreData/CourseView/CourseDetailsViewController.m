#import "CourseDetailsViewController.h"

@interface CourseDetailsViewController ()

@end

@implementation CourseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.courseNameLabel.text = [self.currentObject valueForKey:@"name"];
    self.branchNameLabel.text = [self.currentObject valueForKey:@"branch"];
    self.universityNameLabel.text = [self.currentObject valueForKeyPath:@"belongsToUniversity.name"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

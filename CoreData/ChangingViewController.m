#import "ChangingViewController.h"
#import "DataController.h"

#import <CoreData/CoreData.h>
#import "CoreData+CoreDataModel.h"

#define OBJECT_CLASS UniversityMO
#define OBJECT_KEY @"name"
#define BATCH_SIZE 20

@interface ChangingViewController ()

@end

@implementation ChangingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.managedObjectContext = [DataController sharedInstance].managedObjectContext;
    self.tableView.separatorColor = [UIColor clearColor];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Actions

- (IBAction)doneAction:(UIBarButtonItem *)sender {
    NSLog(@"%@", self.nameField.text);
    
    [self insertNewObjectWithName:self.nameField.text];
}

#pragma mark - Additional Methods

- (void)insertNewObjectWithName:(NSString *)name {
    OBJECT_CLASS *newManagedObject = [[OBJECT_CLASS alloc] initWithContext:self.managedObjectContext];
    
    newManagedObject.name = name;
    
    // Save the context
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }

    [self.navigationController popViewControllerAnimated:YES];
}

@end

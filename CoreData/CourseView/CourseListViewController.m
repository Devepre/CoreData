#import "CourseListViewController.h"
#import "DataController.h"
#import "CoreData+CoreDataModel.h"
#import "CourseChangingController.h"
#import "CourseDetailsViewController.h"

#define OBJECT_CLASS CourseMO
#define OBJECT_CLASS_STRING @"Course"
#define OBJECT_KEY @"name"
#define BATCH_SIZE 20
#define CACHE_NAME @"Master"

@interface CourseListViewController ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController<NSManagedObject *> *fetchedResultsController;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSManagedObject *currentObject;

@end

@implementation CourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.managedObjectContext = [DataController sharedInstance].managedObjectContext;
}

#pragma mark - Delegate method

- (void)dataSelected:(NSObject *)data {
    self.currentObject = (NSManagedObject *)data;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withEvent:managedObject];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell withEvent:(NSManagedObject *)event {
    cell.textLabel.text = [event valueForKey:OBJECT_KEY];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    return indexPath;
}

#pragma mark - Navigation

- (void)viewWillAppear:(BOOL)animated {
    self.fetchedResultsController = nil;
    [NSFetchedResultsController deleteCacheWithName:CACHE_NAME];
    [self.tableView reloadData];
    
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"changingSegue"]) {
        CourseChangingController *vc = segue.destinationViewController;
        vc.currentObject = self.currentObject;
    } else if ([segue.identifier isEqualToString:@"detailSegue"]) {
        CourseDetailsViewController *vc = segue.destinationViewController;
        NSManagedObject *selectedObject = [self.fetchedResultsController objectAtIndexPath:self.indexPath];
        vc.currentObject = selectedObject;
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController<NSManagedObject *> *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<NSManagedObject *> *fetchRequest = OBJECT_CLASS.fetchRequest;
    [fetchRequest setFetchBatchSize:BATCH_SIZE];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"belongsToUniversity = %@ ", self.currentObject];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:OBJECT_KEY ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController<NSManagedObject *> *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                                                initWithFetchRequest:fetchRequest
                                                                                managedObjectContext:self.managedObjectContext
                                                                                sectionNameKeyPath:nil
                                                                                cacheName:CACHE_NAME];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end

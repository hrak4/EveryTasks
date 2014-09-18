//
//  MasterViewController.h
//  EveryTasks
//
//  Created by OkadaHiroaki on 2014/09/09.
//  Copyright (c) 2014年 HiroakiOkada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Title.h"
#import "DatePickerController.h"
@class DetailViewController;
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property Title *toDoItem;
@property (strong) NSMutableArray *toDoItems;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITableView *toDoList;
@property (strong, nonatomic) NSDate *saveDate;

@end

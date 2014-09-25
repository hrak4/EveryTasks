//
//  MasterViewController.m
//  EveryTasks
//
//  Created by OkadaHiroaki on 2014/09/09.
//  Copyright (c) 2014年 HiroakiOkada. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "DatePickerController.h"
#import "Detail.h"
#import "Title.h"
#import "CustomTableViewCell.h"
#import "AppDelegate.h"

@interface MasterViewController ()
{
    //BOOL _IsVisible;
}
//メソッド内で毎回作った場合データが破棄されてしまうので、この画面全体でデータを保持するためにselfにプロパティを作った
@property (nonatomic) NSMutableDictionary *notifications;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController
@synthesize detailViewController = _detailViewController;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

//画面が表示されるたびに行われる処理
-(void) viewWillDisappear:(BOOL)animated
{
     [self.tableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    // fetch to do items from the persistent data store
//    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
//    //Descriptor：エンティティから情報をとってくる場合に欲しいデータの条件を書く
//    NSSortDescriptor *displayOrder = [[NSSortDescriptor alloc] initWithKey:@"summary" ascending:YES];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Title"];
//    [fetchRequest shouldRefreshRefetchedObjects];
//    
//    //@[]は配列
//    [fetchRequest setSortDescriptors:@[displayOrder]];
//    self.toDoItems = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
//    
    //reload the table, and scroll to the bottom
    [self.tableView reloadData];
  
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.notifications = [NSMutableDictionary new];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    // カスタムセルを使用（nibを登録）
    UINib *nib = [UINib nibWithNibName:@"CustomTableViewCell"bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.detailViewController.detailItem = nil;
        self.detailViewController.managedObjectContext = self.fetchedResultsController.managedObjectContext;
    } else {
        [self performSegueWithIdentifier:@"createDetail" sender:self];
    }
    

//    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
//    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
//    
//    // If appropriate, configure the new managed object.
//    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//    [newManagedObject setValue:[NSDate date] forKey:@"summary"];
//    
//    // Save the context.
//    NSError *error = nil;
//    if (![context save:&error]) {
//         // Replace this implementation with code to handle the error appropriately.
//         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
}



/*
 *View1を右にスワイプされた時のアニメーションメソッド
 ***/
- (IBAction)myView_SwipeRight:(UISwipeGestureRecognizer*)sender
{
//    NSLog(@"右にスワイプ");
    //スライドさせたセルを認識（datePickerを保存）
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[sender locationInView:self.tableView]];
//    NSLog(@"%d",indexPath.row);


// スワイプしたときに、スワイプしたセルが持っているデータの中身を参照c
//Title *title = [self.fetchedResultsController objectAtIndexPath:indexPath];
//NSLog(@"%@", title);


    //coreDateに時間を保存
    //title.date = self.saveDate;
    
//    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[sender locationInView:self.tableView]];

//    UITouch *touch = [[sender allTouches] anyObject];
//    CGPoint touchPoint = [touch locationInView:self.tableView];
//    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];

    
    
    //ナビゲーションコントローラーの機能で画面遷移
    [self nextScreen:indexPath];
}


//datePickerへの画面遷移のメソッド
- (IBAction)nextScreen:(NSIndexPath *)indexPath
{
    //modalviewの背景を透明にする
    // 画面遷移エフェクトがなくなるので、そこは独自実装 モーダルビューのviewDidAppear:(BOOL)animatedに記述
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    // スワイプされた時のCoreDataオブジェクトを取得
    Title *title = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // モーダルで表示
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Storyboard ID を指定して画面遷移
    DatePickerController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DatePickerController"];
    controller.detailItem = title;
    controller.selectnum = indexPath.row;
    
    
    // controllerにNavigationController を新たに付与
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:controller];
    // 画面遷移のアニメーションを設定
    nc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    // UINavigationControllerに向けてモーダルで画面遷移
    [self presentViewController:nc animated:NO completion:nil];
    
    
}

//time　LocalNotification
//- (void) notification
//{
//    
//}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];

    
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   
   // セルが持っているデータの中身を参照
    Title *title = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.titleCell.text = title.summary;
    cell.dateCell.text = title.dateView;
    
    //現在日付取得
    NSDate *now = [[NSDate date]init];
    
    //日付をどうゆうフォーマットで文字にするかを決めている。
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //表示方法が変わる（"/"だったり）年月日の順番やどこまで表示するかなど（日までや時間までなど）
    df.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    
    //String型のtitle.dateViewをDate型に変換
//NSLog(@"%@", title.dateView);
    NSDateFormatter* inPutformatter = [[NSDateFormatter alloc]init];
    inPutformatter.dateFormat = @"yyyy/MM/dd HH:mm";
    //@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    inPutformatter.timeZone = [NSTimeZone defaultTimeZone];
    NSDate* inPut = [inPutformatter dateFromString:title.dateView];
 //   NSDate* inPut = [inPutformatter dateFromString:title.dateView];
    
//////////////////////////////////////////////////////////////////////////////
//    NSLog(@"inPutデータはここに表示=== %@",inPut);
    
    
    
    
    
    // dateAとdateBの時間の間隔を取得(dateA - dateBなイメージ)
    NSTimeInterval since;
    since = [inPut timeIntervalSinceDate:now];
//    NSLog(@"日時の差は%f",since);
    
    /*******通知されていないnotification を取る
     *****************************************/
    UIApplication *app = [UIApplication sharedApplication];
    //NSArray *notification = [[NSArray alloc] initWithArray:app.scheduledLocalNotifications copyItems:YES];
    //LocalNotificationを全部キャンセル
    [app cancelAllLocalNotifications];
    
    //notificationで通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    /*************
     現在時刻と通知したい時刻との差の時間を計算する。
     ***************/
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:since];
    localNotification.alertBody = title.summary;
    //defaultTimeZoneにするとiPhoneで設定している時間になる（地域で設定も可）
    localNotification.timeZone = [NSTimeZone defaultTimeZone];

    //notificationデータを辞書データで管理しようとする
    NSString *cellIndex = [NSString stringWithFormat:@"%d", indexPath.row];
    //allKeysとはnotificationが持っているkeyを全て持ってきている。
    //その中で今スワイプされてきたものが含まれているかチェックするのがcontainsObject
    if ([[self.notifications allKeys] containsObject:cellIndex]) {
        [self.notifications removeObjectForKey:cellIndex];
        [self.notifications setObject:localNotification forKey:cellIndex];
    } else {
        [self.notifications setObject:localNotification forKey:cellIndex];
    }

    
    for (NSString *key in [self.notifications allKeys]) {
        UILocalNotification *notification = self.notifications[key];
        NSDate *fireDate = notification.fireDate;
        NSDate *now = [NSDate new];
        //通知設定時間が現在より昔の設定だった場合、通知する必要がないので、削除する。
        if ([fireDate compare:now] == NSOrderedAscending) {
            [self.notifications removeObjectForKey:key];
        }
    }
    
    //通知の最終設定
    for (NSString *key in [self.notifications allKeys]) {
        [app scheduleLocalNotification:self.notifications[key]];
    }

    
    //Delegateからデータを取得
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    NSString *inPut = appDelegate.inPut;
//    
//    //coreDateに時間を保存
//    //title.date = self.saveDate;
//
//    title.dateView = inPut;
    
//    if (title.dateView != nil) {
//        
//        cell.dateCell.text = title.dateView;
//    }
    
    
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    df.dateFormat = @"yyyy/MM/dd　HH:mm";

    //Delegateからデータを取得
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    NSDate *inPut = appDelegate.inPut;
    
    
    
//    NSLog(@"masterセーブデータは%@",[df stringFromDate:_saveDate]);
    
    
    
    //セルにチェックマークを付ける
    // NSManagedObject *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
//    BOOL completed = [[toDoItem valueForKey:@"completed"] boolValue];
//    if (completed)
//    {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else
//    {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    //右にスワイプした時の認識
//    UISwipeGestureRecognizer* swipeRightGesture =
//    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(myView_SwipeRight:)];
//    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
//    [cell addGestureRecognizer:swipeRightGesture];
    

    UISwipeGestureRecognizer* swipeRightGesture =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(myView_SwipeRight:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [cell addGestureRecognizer:swipeRightGesture];
    //tableViewの色指定
    tableView.backgroundColor =[UIColor lightTextColor];
  //  [cell setBackgroundColor:[UIColor color];
   
  // cell.dateCell.text = @"日付";
     [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView sRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        Title *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        self.detailViewController.detailItem = selectedObject;
        self.detailViewController.managedObjectContext = self.fetchedResultsController.managedObjectContext;
        [self performSegueWithIdentifier:@"showDetail" sender:nil];
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"createDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Title *selectedobject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:selectedobject];
    }

    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = sender;
        Title *selectedobject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        DetailViewController *controller = [segue destinationViewController];
//        controller.detailItem = selectedobject;
        [[segue destinationViewController] setDetailItem:selectedobject];
    }
    
    [[segue destinationViewController] setManagedObjectContext:self.fetchedResultsController.managedObjectContext];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Title" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Title *title = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CustomTableViewCell *dateCell = [[CustomTableViewCell alloc] init];
    dateCell.dateCell.text = title.dateView;

}

@end

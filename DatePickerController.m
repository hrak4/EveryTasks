//
//  DatePickerController.m
//  EveryTasks
//
//  Created by OkadaHiroaki on 2014/09/12.
//  Copyright (c) 2014年 HiroakiOkada. All rights reserved.
//

#import "DatePickerController.h"
#import "MasterViewController.h"
#import "AppDelegate.h"
#import "Title.h"


@interface DatePickerController ()

@end

@implementation DatePickerController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *alphaColor = [self.view.backgroundColor colorWithAlphaComponent:0.8]; //透過率
    self.view.backgroundColor = alphaColor;
    
}

//Doneを押されたときの処理
- (IBAction)commitButtonClicked:(id)sender
{
    /********
    dateを保存する処理
    *********/
     //現在日付取得
    NSDate *now = [[NSDate date]init];
    
    //日付をどうゆうフォーマットで文字にするかを決めている。
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //表示方法が変わる（"/"だったり）年月日の順番やどこまで表示するかなど（日までや時間までなど）
    df.dateFormat = @"yyyy/MM/dd　HH:mm:ss";
    
    //日付を文字列に変更
    NSLog(@"現在の日時は%@",[df stringFromDate:now]);
    
    
    /*********
     datePikcerに入力された日時を取得
    **********/
     //日付をどうゆうフォーマットで文字にするかを決めている。
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    //表示方法が変わる（"/"だったり）年月日の順番やどこまで表示するかなど（日までや時間までなど）
    df1.dateFormat = @"yyyy/MM/dd　HH:mm:00";
    NSDate *inPut = self.datePicker.date;
    //秒が00の文字列が入る
    NSString *adjust = [df1 stringFromDate:inPut];
    //秒数が0の形でdate型に戻している
    inPut = [df1 dateFromString:adjust];
    NSLog(@"inPut入力された日時は%@", [df1 stringFromDate:inPut]);
    
    /*******************************************************************
     セルに表示したい時間
     *******************************************************************/
    
    NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
    df2.dateFormat = @"yyyy/MM/dd　HH:mm";
    
    
    //date =[df2 stringFromDate:inPut];

    // Get the date from core data
//    
//    NSString *dateStr = [[NSObject valueForKey:@"date"] description];
//    // Parse from string to date
//    NSDate *date = [df2 dateFromString:dateStr ];
//    
//    // Set the date formatter to the format that I actually want
//    [df2 setDateFormat:@"dd/MM/yy HH:mm"];
//    
//    // Set the text on the date label
//    _nowDate = [df2 stringFromDate:date];
//    
//

    //MasterViewに保存
//    MasterViewController *saveDate1 = [[MasterViewController alloc]init];
//    saveDate1.saveDate =inPut;
//    NSLog(@"セーブデータ%@",[df1 stringFromDate:saveDate1.saveDate]);
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.inPut = [df2 stringFromDate:inPut];
     
//    _nowDate= [df2 stringFromDate:inPut];
//     NSLog(@"取得された日時は%@",_nowDate);
    
    
    
    // dateAとdateBの時間の間隔を取得(dateA - dateBなイメージ)
    NSTimeInterval since;
    since = [inPut timeIntervalSinceDate:now];
    NSLog(@"日時の差は%f",since);
    
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
    localNotification.alertBody = [NSString stringWithFormat:@"%.1f秒経過しました",since];
    //defaultTimeZoneにするとiPhoneで設定している時間になる（地域で設定も可）
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    
    //前の画面に戻る
    [self dismissViewControllerAnimated:YES completion:nil];
}
//Cancelを押されたときの処理
- (IBAction)cancelButtonClicked:(id)sender
{
    NSLog(@"Tapされました");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    
    // DatePicerが半透明効果のせいでアニメーションしないので自前で書く
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    [UIView beginAnimations:nil context:nil];
    [self.view setFrame:CGRectMake(0, h, w, h)];
    [UIView setAnimationDuration:0.4f];
    [self.view setFrame:CGRectMake(0, 0, w, h)];
    [UIView commitAnimations];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)returnScreen:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

@end

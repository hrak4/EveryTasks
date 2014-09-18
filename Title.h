//
//  Title.h
//  EveryTasks
//
//  Created by OkadaHiroaki on 2014/09/17.
//  Copyright (c) 2014年 HiroakiOkada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Detail;

@interface Title : NSManagedObject

@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) Detail *detail;

@end

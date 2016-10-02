//
//  FixtureDate.m
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "FixtureDate.h"
#import "Division.h"

NSString * const kFixtureDateIDKey = @"id";
NSString * const kFixtureDateDivisionKey = @"division";
NSString * const kFixtureDateDateKey = @"date";
NSString * const kFixtureDateDateNumberKey = @"dateNumber";
NSString * const kFixtureDateSuspendedReasonKey = @"suspendedReason";
NSString * const kFixtureDateIsSuspendedKey = @"isSuspended";

@implementation FixtureDate

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    self = [super init];
    
    if (self != nil) {
        if (![dictInfo isKindOfClass:[NSNull class]]) {
            self.id = dictInfo[kFixtureDateIDKey];
            self.division = [[Division alloc] initWithDictionary:[dictInfo objectForKey:kFixtureDateDivisionKey]];
            self.date = dictInfo[kFixtureDateDateKey];
            self.dateNumber = dictInfo[kFixtureDateDateNumberKey];
            self.suspendedReason = dictInfo[kFixtureDateSuspendedReasonKey];
            self.isSuspended = [(NSNumber *)dictInfo[kFixtureDateIsSuspendedKey] boolValue];
        }
    }
    
    return self;
}

@end

//
//  FixtureMatchInfo.h
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FixtureDate.h"
#import "Team.h"

@interface FixtureMatchInfo : NSObject

@property (nonatomic, weak) NSNumber *id;
@property (nonatomic, weak) NSNumber *longitude;
@property (nonatomic, weak) NSNumber *latitude;
@property (nonatomic)  FixtureDate *fixtureDate;
@property (nonatomic)  Team *homeTeam;
@property (nonatomic)  Team *awayTeam;
@property (nonatomic)  NSString *lastUpdateDate;
@property (nonatomic)  NSString *fieldNumber;
@property (nonatomic)  NSString *hour;
@property (nonatomic)  NSString *homeGoals;
@property (nonatomic)  NSString *awayGoals;
@property (nonatomic)  NSString *mapCode;
@property (nonatomic)  NSString *heading;

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo;

@end

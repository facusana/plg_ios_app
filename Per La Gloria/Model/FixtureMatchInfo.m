//
//  FixtureMatchInfo.m
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "FixtureMatchInfo.h"

NSString * const kFixtureMatchInfoIDKey = @"id";
NSString * const kFixtureMatchInfoFixtureDateKey = @"fixtureDate";
NSString * const kFixtureMatchInfoHomeTeamKey = @"homeTeam";
NSString * const kFixtureMatchInfoAwayTeamKey = @"awayTeam";
NSString * const kFixtureMatchInfoLastUpdateDateKey = @"lastUpdateDate";
NSString * const kFixtureMatchInfoFieldNumberKey = @"fieldNumber";
NSString * const kFixtureMatchInfoHourKey = @"hour";
NSString * const kFixtureMatchInfoHomeGoalsKey = @"homeGoals";
NSString * const kFixtureMatchInfoAwayGoalsKey = @"awayGoals";
NSString * const kFixtureMatchInfoMapCodeKey = @"mapCode";
NSString * const kFixtureMatchInfoLatitudeKey = @"latitude";
NSString * const kFixtureMatchInfoLongitudeKey = @"longitude";
NSString * const kFixtureMatchInfoHeadingKey = @"heading";

@implementation FixtureMatchInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    self = [super init];
    
    if (self != nil) {
        if (![dictInfo isKindOfClass:[NSNull class]]) {
            self.id = dictInfo[kFixtureMatchInfoIDKey];
            self.fixtureDate = [[FixtureDate alloc] initWithDictionary:dictInfo[kFixtureMatchInfoFixtureDateKey]];
            self.homeTeam = [[Team alloc] initWithDictionary:dictInfo[kFixtureMatchInfoHomeTeamKey]];
            self.awayTeam = [[Team alloc] initWithDictionary:dictInfo[kFixtureMatchInfoAwayTeamKey]];
            self.lastUpdateDate = dictInfo[kFixtureMatchInfoLastUpdateDateKey];
            self.fieldNumber= dictInfo[kFixtureMatchInfoFieldNumberKey];
            self.hour = dictInfo[kFixtureMatchInfoHourKey];
            self.homeGoals = dictInfo[kFixtureMatchInfoHomeGoalsKey];
            self.awayGoals = dictInfo[kFixtureMatchInfoAwayGoalsKey];
            self.mapCode = dictInfo[kFixtureMatchInfoMapCodeKey];
            self.longitude = dictInfo[kFixtureMatchInfoLongitudeKey];
            self.latitude = dictInfo[kFixtureMatchInfoLatitudeKey];
            self.heading = dictInfo[kFixtureMatchInfoHeadingKey];
        }
    }
    
    return self;
}

@end

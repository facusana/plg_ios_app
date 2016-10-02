//
//  Team.h
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tactic.h"

@interface Team : NSObject
@property (nonatomic) BOOL isSelected;

@property (nonatomic) NSNumber *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic) BOOL isActive;
@property (nonatomic) NSNumber *position;
@property (nonatomic) NSNumber *points;
@property (nonatomic) NSNumber *gamesPlayed;
@property (nonatomic) NSNumber *wins;
@property (nonatomic) NSNumber *ties;
@property (nonatomic) NSNumber *losses;
@property (nonatomic) NSNumber *goalsFor;
@property (nonatomic) NSNumber *goalsAgainst;
@property (nonatomic) NSNumber *goalDifference;
@property (nonatomic) NSNumber *avgGoalForPerMatch;
@property (nonatomic) NSNumber *avgGoalAgainstPerMatch;
@property (nonatomic, strong) Tactic *tactic;

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo;

@end

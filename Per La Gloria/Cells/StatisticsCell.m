//
//  StatisticsCell.m
//  Per La Gloria
//
//  Created by Seneta Yuriy on 10.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "StatisticsCell.h"

@implementation StatisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithTeam:(Team *)team withPosition:(NSUInteger)position {
    self.equipoLabel.text = team.name;
    self.ptsLabel.text = team.points.stringValue;
    self.PJLabel.text = team.gamesPlayed.stringValue;
    self.PGLabel.text = team.wins.stringValue;
    self.PELabel.text = team.ties.stringValue;
    self.PPLabel.text = team.losses.stringValue;
    self.GFLabel.text = team.goalsFor.stringValue;
    self.GCLabel.text = team.goalsAgainst.stringValue;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)position];
}

@end

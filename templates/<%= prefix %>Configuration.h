//
//  PGDMConfiguration.h
//  DeMorgen
//
//  Created by Hannes Verlinde on 25/02/14.
//  Copyright (c) 2014 In the Pocket. All rights reserved.
//

#import "ITPConfiguration.h"

@interface <%= prefix %>Configuration : ITPConfiguration

@property (nonatomic, copy, readonly) NSString *baseURL;

@end

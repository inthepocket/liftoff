//
//  <%= prefix %>Configuration.h
//  DeMorgen
//
//  Created by Hannes Verlinde on 25/02/14.
//  Copyright (c) 2014 In the Pocket. All rights reserved.
//

#import "ITPConfiguration.h"

@interface <%= prefix %>Configuration : ITPConfiguration

/**
* The base URL of the API
*
* @return A string representing the base URL of the API
*/
@property (nonatomic, copy, readonly) NSString *baseURL; // TODO: Change this to reflect your own configuration values (see the <environment>.plist files)

@end

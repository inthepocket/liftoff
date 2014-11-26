//
//  UINavigationBar+<%= prefix %>Appearance.h
//  <%= project_name %>
//
//  Created by <%= author %> on <%= Time.now.strftime("%-m/%-d/%y") %>
//  Copyright (c) <%= Time.now.strftime('%Y') %> <%= company %>. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (<%= prefix %>Appearance)

+ (void)customizeAppearance;
- (void)customizeInstance;

@end

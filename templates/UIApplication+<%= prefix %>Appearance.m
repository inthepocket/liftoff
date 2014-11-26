//
//  UIApplication+<%= prefix %>Appearance.m
//  <%= project_name %>
//
//  Created by <%= author %> on <%= Time.now.strftime("%-m/%-d/%y") %>
//  Copyright (c) <%= Time.now.strftime('%Y') %> <%= company %>. All rights reserved.
//

#import "UIApplication+<%= prefix %>Appearance.h"

#import "UINavigationBar+<%= prefix %>Appearance.h"

@implementation UIApplication (<%= prefix %>Appearance)

- (void)customizeAppearance
{
    [UINavigationBar customizeAppearance];

    // TODO: Add more customization logic here,
    // split it up in appearance categories on the UI class
}

@end

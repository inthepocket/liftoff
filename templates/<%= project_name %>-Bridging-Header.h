#ifndef <%= project_name %>_Bridging_Header_h
#define <%= project_name %>_Bridging_Header_h

<% if enable_googleanalytics %>#import <GoogleAnalytics-iOS-SDK/GAI.h><% end %>
<% if enable_parse %>#import <Parse/Parse.h><% end %>

#endif

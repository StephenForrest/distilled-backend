require 'segment/analytics'

Analytics = Segment::Analytics.new({
                                     write_key: 'SEGMENT_WRITE_KEY',
                                     on_error: proc { |_status, msg| print msg }
                                   })

 Analytics.identify(
   user_id: current_user.id,
   traits: {
     email: current_user.email,
     name: current_user.name
   }
 )

 Analytics.track(
   user_id: current_user.id,
   event: 'User Signed In',
   properties: {
     email: current_user.email,
     name: current_user.name
   }
 )

 Analytics.track(
   user_id: current_user.id,
   event: 'User Signed Out',
   properties: {
     email: current_user.email,
     name: current_user.name
   }
 )

 Analytics.track(
   user_id: current_user.id,
   event: 'User Created',
   properties: {
     email: current_user.email,
     name: current_user.name
   }
 )

 Analytics.track(
   user_id: current_user.id,
   event: 'User Updated',
   properties: {
     email: current_user.email,
     name: current_user.name
   }
 )

 Analytics.track(
   user_id: current_user.id,
   event: 'User Created Goal',
   properties: {
     email: current_user.email,
     name: current_user.name
   }
 )

 Analytics.track(
   user_id: current_user.id,
   event: 'User Created Measurement',
   properties: {
     email: current_user.email,
     name: current_user.name
   }
 )

 Analytics.group(
   user_id: current_user.id,
   group_id: current_workspace.id,
   traits: {
     name: current_workspace.name
   }
 )

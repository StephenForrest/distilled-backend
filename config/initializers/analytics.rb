Analytics = Segment::Analytics.new({
    write_key: 'SEGMENT_WRITE_KEY',
    on_error: Proc.new { |status, msg| print msg }
})

Analytics.identify(
    user_id: current_user.id,
    traits: {
      name: current_user.name,
      email: current_user.email,
      created_at: current_user.created_at,
      profile_pic: current_user.profile_pic
    })

Analytics.group(
    user_id: current_user.id,
    group_id: current_user.workspaces.first.id,
    traits: {
        name: current_user.workspaces.first.name,
        created_at: current_user.workspaces.first.created_at
    })

Analytics.track(
    user_id: current_user.id,
    event: user_sessions.first.login_type,
    properties: {
        name: current_user.name,
        email: current_user.email,
        created_at: current_user.created_at,
        profile_pic: current_user.profile_pic
    })

Analytics.track(
    user_id: current_user.id,
    event: user_sessions.SignOutMutation.session_id,
    properties: {
        name: current_user.name,
        email: current_user.email,
        created_at: current_user.created_at,
        profile_pic: current_user.profile_pic
    })

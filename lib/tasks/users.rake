namespace :users do
  desc "merge one user in another one"
  task :merge, [:target_id, :from_id] => [:environment] do |task, args|
    target_user = User.find(args[:target_id])
    from_user = User.find(args[:from_id])

    puts "will merge: #{from_user.name}(id: #{from_user.id}) in #{target_user.name}(id: #{target_user.id})"
    puts "#{target_user.name} has #{target_user.subscriptions.count} subscriptions"
    puts "#{target_user.name} has #{target_user.ranks.count} ranks"
    puts "#{target_user.name} has #{target_user.creations.count} creations"
    puts "#{target_user.name} has #{target_user.badges.count} badges"
    puts "#{from_user.name} has #{from_user.subscriptions.count} subscriptions"
    puts "#{from_user.name} has #{from_user.ranks.count} ranks"
    puts "#{from_user.name} has #{from_user.creations.count} creations"
    puts "#{from_user.name} has #{from_user.badges.count} badges"

    from_user.subscriptions.update_all(user_id: target_user.id)
    from_user.ranks.update_all(user_id: target_user.id)
    from_user.creations.update_all(author_id: target_user.id)
    from_user.badges.update_all(user_id: target_user.id)

    puts "Migrated"
    puts "#{target_user.name} has #{target_user.subscriptions.count} subscriptions"
    puts "#{target_user.name} has #{target_user.ranks.count} ranks"
    puts "#{target_user.name} has #{target_user.creations.count} creations"
    puts "#{target_user.name} has #{target_user.badges.count} badges"
    puts "#{from_user.name} has #{from_user.subscriptions.count} subscriptions"
    puts "#{from_user.name} has #{from_user.ranks.count} ranks"
    puts "#{from_user.name} has #{from_user.creations.count} creations"
    puts "#{from_user.name} has #{from_user.badges.count} badges"
  end
end

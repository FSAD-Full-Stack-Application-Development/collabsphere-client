# Clean seeds file - admin user creation only

# Create admin user (always run on startup)
def create_admin_user
  begin
    admin_email = 'admin@collab.com'
    admin = User.find_or_initialize_by(email: admin_email)
    admin.full_name = 'Site Admin'
    admin.password = 'admin123'
    admin.password_confirmation = 'admin123'
    admin.system_role = 'admin'
    admin.save!(validate: false)
    puts "Seed: ensured admin user #{admin_email} exists"
    $stdout.flush
  rescue => e
    puts "Seed: failed to create admin user: #{e.message}"
  end
end

# Only create admin user on startup (not demo data)
create_admin_user()
# Profile User Seeds - Three Representative User Personas
require_relative '../../config/environment'

puts "\n=========================================="
puts "CREATING PROFILE USER PERSONAS"
puts "==========================================\n"

# Clean up existing profile users
User.where(email: [
  'sarah.student@collabsphere.com',
  'michael.mentor@collabsphere.com',
  'jessica.admin@collabsphere.com'
]).destroy_all

# 1. STUDENT PROFILE - Araya Suwan
puts "Creating Student Profile: Araya Suwan..."
araya = User.create!(
  # Basic authentication
  email: "araya.student@collabsphere.com",
  password: "password123",
  password_confirmation: "password123",
  system_role: "user",
  
  # (a) Picture & (b) Name
  full_name: "Araya Suwan",
  avatar_url: "https://i.pravatar.cc/300?img=1",
  bio: "Second-year Computer Science student at Asian Institute of Technology passionate about mobile app development and IoT. Love creating tech solutions for local community problems!",
  
  # (b) Personal information
  age: 22,
  occupation: "Computer Science Student",
  
  # Academic information
  country: "Thailand",
  university: "Asian Institute of Technology",
  department: "Computer Science",
  
  # (c) Short-term and long-term goals
  short_term_goals: "Complete my IoT project for smart farming in rural Thailand. Find collaborators for Bangkok Tech Hackathon 2025. Learn Flutter for cross-platform mobile development.",
  long_term_goals: "Graduate with first-class honors and work at a Thai tech startup. Build apps that help bridge the digital divide in Southeast Asia. Eventually start my own edtech company focused on Thai students.",
  
  # (d) Immediate questions
  immediate_questions: "How can I find team members interested in agricultural technology? What funding is available for student-led social impact projects? Are there mentors with experience in Thai tech industry?",
  
  # (f) Computer equipment and connection
  computer_equipment: "ASUS VivoBook (i5, 8GB RAM), 24-inch external monitor, wireless mouse and keyboard, USB-C hub for connectivity",
  connection_type: "University WiFi (50 Mbps), home fiber internet (100 Mbps)"
)
puts "✓ Created: #{araya.full_name} - #{araya.occupation}"

# 2. MENTOR/PROFESSIONAL PROFILE - Somchai Pattana
puts "\nCreating Professional/Mentor Profile: Somchai Pattana..."
somchai = User.create!(
  # Basic authentication
  email: "somchai.mentor@collabsphere.com",
  password: "password123",
  password_confirmation: "password123",
  system_role: "user",
  
  # (a) Picture & (b) Name
  full_name: "Somchai Pattana",
  avatar_url: "https://i.pravatar.cc/300?img=12",
  bio: "12+ years in software engineering and cloud architecture. Currently Tech Lead at Agoda. Passionate about mentoring Thai students and growing the local tech ecosystem.",
  
  # (b) Personal information
  age: 38,
  occupation: "Tech Lead & Part-time Mentor",
  
  # Academic information
  country: "Thailand",
  university: "Chulalongkorn University (Alumni)",
  department: "Computer Engineering",
  
  # (c) Short-term and long-term goals
  short_term_goals: "Mentor 5-7 students from Thai universities this semester. Help organize Bangkok DevFest 2025. Share real-world cloud architecture experience with student teams.",
  long_term_goals: "Build a strong mentorship network connecting Thai students with industry professionals. Establish a tech incubator for student startups in Bangkok. Give back to Thai tech education through guest lectures and workshops.",
  
  # (d) Immediate questions
  immediate_questions: "Which student projects need guidance on scalable architecture? How can I help students prepare for careers at international tech companies? What challenges do Thai CS students face that I can address?",
  
  # (f) Computer equipment and connection
  computer_equipment: "MacBook Pro M2 Max (32GB RAM), LG UltraWide 34-inch monitor, mechanical keyboard (custom-built), iPad Air for meetings",
  connection_type: "Home fiber optic (500 Mbps), office ethernet (1 Gbps)"
)
puts "✓ Created: #{somchai.full_name} - #{somchai.occupation}"

# 3. ADMIN PROFILE - Nattapong Kwan
puts "\nCreating Admin Profile: Nattapong Kwan..."
nattapong = User.create!(
  # Basic authentication
  email: "nattapong.admin@collabsphere.com",
  password: "password123",
  password_confirmation: "password123",
  system_role: "admin",
  
  # (a) Picture & (b) Name
  full_name: "Nattapong Kwan",
  avatar_url: "https://i.pravatar.cc/300?img=33",
  bio: "Managing CollabSphere platform for Southeast Asian universities. Passionate about connecting Thai students with regional and global opportunities while ensuring safe online collaboration.",
  
  # (b) Personal information
  age: 33,
  occupation: "Platform Administrator & Community Manager",
  
  # Academic information
  country: "Thailand",
  university: "Asian Institute of Technology (Alumni)",
  department: "Information and Communication Technologies",
  
  # (c) Short-term and long-term goals
  short_term_goals: "Reduce spam and improve content moderation for Thai language posts. Increase Thai university participation by 40%. Launch region-specific features for Southeast Asian students.",
  long_term_goals: "Build the largest student collaboration network in Southeast Asia. Expand to all major Thai universities and ASEAN region. Create funding partnerships with Thai tech companies for student projects.",
  
  # (d) Immediate questions
  immediate_questions: "How can we better moderate multilingual content (Thai/English)? What features would help Thai students collaborate across universities? How do we attract more industry partners from Thailand?",
  
  # (f) Computer equipment and connection
  computer_equipment: "Dell XPS 15 (i7, 32GB RAM), dual Dell UltraSharp 27-inch monitors, ergonomic keyboard and mouse, standing desk converter",
  connection_type: "Office fiber optic (300 Mbps), home True fiber internet (500 Mbps)"
)
puts "✓ Created: #{nattapong.full_name} - #{nattapong.occupation}"

puts "\n=========================================="
puts "PROFILE USERS CREATED SUCCESSFULLY"
puts "==========================================\n"
puts "Login credentials for testing:"
puts "  Student:  araya.student@collabsphere.com / password123"
puts "  Mentor:   somchai.mentor@collabsphere.com / password123"
puts "  Admin:    nattapong.admin@collabsphere.com / password123"
puts "\nAccess profiles at:"
puts "  GET /api/v1/profiles/#{araya.id}"
puts "  GET /api/v1/profiles/#{somchai.id}"
puts "  GET /api/v1/profiles/#{nattapong.id}"
puts "=========================================\n"

# Comprehensive Test Seeds for CollabSphere
# This file creates extensive test data for all application features
require_relative '../../config/environment'

puts "\n" + "="*60
puts "COLLABSPHERE COMPREHENSIVE TEST DATA SEEDING"
puts "="*60 + "\n"

# Clean up existing data (in reverse dependency order)
puts "⚠️  SKIPPING cleanup - preserving existing data\n"

# ============================================================================
# 1. USERS - Create diverse user profiles
# ============================================================================
puts "👥 Creating Users..."

users_data = [
  # Students
  {
    email: "test.student1@ait.ac.th", full_name: "Test Ananya Singh", age: 21, occupation: "CS Student",
    country: "Thailand", university: "Asian Institute of Technology", department: "Computer Science",
    bio: "Passionate about AI and machine learning. Looking for collaborators on NLP projects.",
    avatar_url: "https://i.pravatar.cc/300?img=1"
  },
  {
    email: "test.student2@chula.ac.th", full_name: "Test Pravat Chaisorn", age: 22, occupation: "Engineering Student",
    country: "Thailand", university: "Chulalongkorn University", department: "Computer Engineering",
    bio: "IoT enthusiast working on smart city solutions. Experienced with Arduino and Raspberry Pi.",
    avatar_url: "https://i.pravatar.cc/300?img=2"
  },
  {
    email: "test.student3@kmutt.ac.th", full_name: "Test Siriporn Wong", age: 20, occupation: "IT Student",
    country: "Thailand", university: "King Mongkut's University of Technology Thonburi", department: "Information Technology",
    bio: "Web developer specializing in React and Node.js. Interested in full-stack development.",
    avatar_url: "https://i.pravatar.cc/300?img=3"
  },
  {
    email: "test.student4@ku.ac.th", full_name: "Test Thanakorn Srisuk", age: 23, occupation: "Data Science Student",
    country: "Thailand", university: "Kasetsart University", department: "Statistics",
    bio: "Data scientist with expertise in Python, R, and machine learning algorithms.",
    avatar_url: "https://i.pravatar.cc/300?img=4"
  },
  {
    email: "test.student5@mahidol.ac.th", full_name: "Test Nattaya Boon", age: 21, occupation: "Bioinformatics Student",
    country: "Thailand", university: "Mahidol University", department: "Bioinformatics",
    bio: "Combining biology and computer science to solve healthcare challenges.",
    avatar_url: "https://i.pravatar.cc/300?img=5"
  },

  # Mentors/Professionals
  {
    email: "test.mentor1@agoda.com", full_name: "Test Somsak Techavanich", age: 35, occupation: "Senior Software Engineer",
    country: "Thailand", university: "Chulalongkorn University", department: "Computer Engineering",
    bio: "10+ years in software engineering. Currently at Agoda. Love mentoring students in system design.",
    avatar_url: "https://i.pravatar.cc/300?img=10"
  },
  {
    email: "test.mentor2@shopee.com", full_name: "Test Piyanut Jindaprasert", age: 32, occupation: "Tech Lead",
    country: "Thailand", university: "Asian Institute of Technology", department: "Computer Science",
    bio: "Tech Lead at Shopee. Expert in distributed systems and cloud architecture.",
    avatar_url: "https://i.pravatar.cc/300?img=11"
  },
  {
    email: "test.mentor3@grab.com", full_name: "Test Kittipong Wattanaporn", age: 38, occupation: "Engineering Manager",
    country: "Thailand", university: "King Mongkut's University of Technology Thonburi", department: "Computer Engineering",
    bio: "Engineering Manager at Grab. Passionate about mobile development and team leadership.",
    avatar_url: "https://i.pravatar.cc/300?img=12"
  },

  # Additional users for testing
  {
    email: "test.user1@test.com", full_name: "Test User 1", age: 25, occupation: "Developer",
    country: "Thailand", university: "Test University", department: "Computer Science",
    bio: "Test user for development purposes.",
    avatar_url: "https://i.pravatar.cc/300?img=20"
  },
  {
    email: "test.user2@test.com", full_name: "Test User 2", age: 26, occupation: "Designer",
    country: "Thailand", university: "Test University", department: "Design",
    bio: "UI/UX designer with a passion for user-centered design.",
    avatar_url: "https://i.pravatar.cc/300?img=21"
  }
]

users = []
users_data.each do |user_data|
  if User.exists?(email: user_data[:email])
    user = User.find_by(email: user_data[:email])
    puts "  ✓ Skipping existing user: #{user.full_name} (#{user.email})"
  else
    user = User.create!(user_data.merge(
      password: "password123",
      password_confirmation: "password123",
      system_role: "user"
    ))
    puts "  ✓ Created: #{user.full_name} (#{user.email})"
  end
  users << user
end

# Admin user
if User.exists?(email: "test.admin@collabsphere.com")
  admin = User.find_by(email: "test.admin@collabsphere.com")
  puts "  ✓ Skipping existing admin: #{admin.full_name} (#{admin.email})"
else
  admin = User.create!(
    email: "test.admin@collabsphere.com",
    full_name: "Test System Admin",
    password: "admin123",
    password_confirmation: "admin123",
    system_role: "admin",
    age: 30,
    occupation: "Administrator",
    country: "Thailand",
    university: "System",
    department: "Administration",
    bio: "Platform administrator",
    avatar_url: "https://i.pravatar.cc/300?img=99"
  )
  puts "  ✓ Created: #{admin.full_name} (#{admin.email}) - ADMIN"
end
users << admin

puts "✅ Users created: #{users.count}\n"

# ============================================================================
# 2. TAGS - Create technology and topic tags
# ============================================================================
puts "🏷️  Creating Tags..."

tags_data = [
  # Programming Languages
  "JavaScript", "Python", "Java", "C++", "C#", "Ruby", "Go", "Swift", "Kotlin", "Dart", "TypeScript", "PHP", "R", "MATLAB",

  # Web Technologies
  "React", "Vue.js", "Angular", "Node.js", "Express", "Django", "Flask", "Spring", "Laravel", "Rails",

  # Mobile Development
  "Flutter", "React Native", "iOS", "Android", "Xamarin",

  # Data & AI
  "Machine Learning", "Deep Learning", "AI", "Data Science", "Big Data", "TensorFlow", "PyTorch", "Pandas", "NumPy",

  # DevOps & Cloud
  "Docker", "Kubernetes", "AWS", "Azure", "GCP", "CI/CD", "Jenkins", "GitLab CI", "GitHub Actions",

  # Databases
  "MySQL", "PostgreSQL", "MongoDB", "Redis", "Elasticsearch",

  # Other Technologies
  "Blockchain", "IoT", "Cybersecurity", "AR/VR", "Game Development", "API Development", "Microservices",

  # Domains
  "Healthcare", "Education", "Agriculture", "Finance", "E-commerce", "Social Impact", "Sustainability", "Smart Cities",

  # Skills
  "Full-Stack", "Frontend", "Backend", "Mobile", "DevOps", "Data Analysis", "UI/UX", "Product Management"
]

tags = []
tags_data.each do |tag_name|
  if Tag.exists?(tag_name: tag_name)
    tag = Tag.find_by(tag_name: tag_name)
    puts "  ✓ Skipping existing tag: #{tag.tag_name}"
  else
    tag = Tag.create!(tag_name: tag_name)
    puts "  ✓ Created tag: #{tag.tag_name}"
  end
  tags << tag
end
puts "✅ Tags created: #{tags.count}\n"

# ============================================================================
# 3. USER TAGS - Associate users with their skills/expertise
# ============================================================================
puts "🔗 Creating User-Tag Associations..."

# Assign tags to users based on their profiles
user_tag_assignments = {
  users[0] => ["Python", "Machine Learning", "AI", "Data Science"], # Ananya - AI/ML student
  users[1] => ["JavaScript", "IoT", "Arduino", "Raspberry Pi", "Smart Cities"], # Pravat - IoT student
  users[2] => ["JavaScript", "React", "Node.js", "Full-Stack", "Web Development"], # Siriporn - Web dev student
  users[3] => ["Python", "R", "Data Science", "Machine Learning", "Statistics"], # Thanakorn - Data science student
  users[4] => ["Python", "Bioinformatics", "Healthcare", "Data Analysis"], # Nattaya - Bioinformatics student
  users[5] => ["Java", "Spring", "Microservices", "System Design", "Cloud Architecture"], # Somsak - Senior engineer
  users[6] => ["Python", "Distributed Systems", "Cloud Architecture", "DevOps"], # Piyanut - Tech lead
  users[7] => ["Swift", "iOS", "Android", "Mobile", "Flutter"], # Kittipong - Mobile expert
  users[8] => ["JavaScript", "React", "Full-Stack"], # Test user 1
  users[9] => ["UI/UX", "Product Management", "Design"] # Test user 2
}

user_tag_assignments.each do |user, user_tags|
  user_tags.each do |tag_name|
    tag = tags.find { |t| t.tag_name == tag_name }
    if tag && !UserTag.exists?(user: user, tag: tag)
      UserTag.create!(user: user, tag: tag)
    end
  end
end
puts "✅ User-tag associations created\n"

# ============================================================================
# 4. PROJECTS - Create diverse projects with different statuses
# ============================================================================
puts "📁 Creating Projects..."

projects_data = [
  {
    title: "AI-Powered Crop Disease Detection",
    description: "Developing a mobile app that uses computer vision and machine learning to identify crop diseases in real-time. Farmers can take photos of their crops and get instant diagnosis with treatment recommendations.",
    status: "Ongoing",
    visibility: "public",
    owner: users[0], # Ananya
    tags: ["Python", "Machine Learning", "AI", "Mobile", "Agriculture", "Healthcare"]
  },
  {
    title: "Smart Traffic Management System",
    description: "IoT-based traffic management system using sensors and AI to optimize traffic flow in Bangkok. Real-time data collection and predictive analytics for congestion prevention.",
    status: "Ongoing",
    visibility: "public",
    owner: users[1], # Pravat
    tags: ["IoT", "Python", "Smart Cities", "AI", "Data Science"]
  },
  {
    title: "E-Learning Platform for Rural Schools",
    description: "Full-stack web application providing quality educational content to rural Thai schools. Features offline content delivery, progress tracking, and teacher dashboards.",
    status: "Ongoing",
    visibility: "public",
    owner: users[2], # Siriporn
    tags: ["React", "Node.js", "Full-Stack", "Education", "Web Development"]
  },
  {
    title: "Financial Fraud Detection System",
    description: "Machine learning system to detect fraudulent transactions in real-time. Using advanced algorithms to analyze transaction patterns and flag suspicious activities.",
    status: "Completed",
    visibility: "public",
    owner: users[3], # Thanakorn
    tags: ["Python", "Machine Learning", "Finance", "Data Science", "Big Data"]
  },
  {
    title: "Genomic Data Analysis Pipeline",
    description: "Bioinformatics pipeline for analyzing genomic sequencing data. Tools for variant calling, annotation, and clinical interpretation of genetic mutations.",
    status: "Ongoing",
    visibility: "public",
    owner: users[4], # Nattaya
    tags: ["Python", "Bioinformatics", "Healthcare", "Data Analysis"]
  },
  {
    title: "Microservices E-commerce Platform",
    description: "Scalable e-commerce platform built with microservices architecture. Features include product catalog, shopping cart, payment processing, and order management.",
    status: "Ongoing",
    visibility: "private",
    owner: users[5], # Somsak
    tags: ["Java", "Spring", "Microservices", "E-commerce", "Cloud Architecture"]
  },
  {
    title: "Real-time Chat Application",
    description: "High-performance chat application supporting real-time messaging, file sharing, and group conversations. Built with modern web technologies and scalable architecture.",
    status: "Completed",
    visibility: "public",
    owner: users[6], # Piyanut
    tags: ["JavaScript", "Node.js", "Web Development", "Real-time", "Microservices"]
  },
  {
    title: "AR Shopping Experience",
    description: "Augmented reality mobile app for virtual try-on and product visualization. Users can see how furniture, clothing, and other products look in their space.",
    status: "Ideation",
    visibility: "public",
    owner: users[7], # Kittipong
    tags: ["AR/VR", "Mobile", "iOS", "Android", "E-commerce"]
  },
  {
    title: "Blockchain-based Voting System",
    description: "Secure and transparent voting system using blockchain technology. Ensures election integrity while maintaining voter privacy and anonymity.",
    status: "Ideation",
    visibility: "public",
    owner: users[8], # Test user 1
    tags: ["Blockchain", "JavaScript", "Cybersecurity", "Full-Stack"]
  },
  {
    title: "Mental Health Support App",
    description: "Mobile application providing mental health resources, mood tracking, and connections to professional help. Features anonymous chat support and wellness content.",
    status: "Ongoing",
    visibility: "public",
    owner: users[9], # Test user 2
    tags: ["Mobile", "Healthcare", "UI/UX", "Social Impact"]
  },
  {
    title: "Sustainable Urban Farming Network",
    description: "Platform connecting urban farmers with consumers. Features include crop planning, yield prediction, and direct marketplace for locally grown produce.",
    status: "Ongoing",
    visibility: "public",
    owner: users[0], # Ananya
    tags: ["React", "Node.js", "Agriculture", "Sustainability", "E-commerce"]
  },
  {
    title: "AI Language Learning Assistant",
    description: "Intelligent language learning app using NLP and spaced repetition. Personalized learning paths with real-time pronunciation feedback.",
    status: "Ongoing",
    visibility: "public",
    owner: users[3], # Thanakorn
    tags: ["AI", "Mobile", "Education", "Machine Learning", "NLP"]
  },
  {
    title: "Smart Waste Management System",
    description: "IoT-enabled waste collection optimization using sensors and route planning algorithms. Reduces collection costs and improves recycling rates.",
    status: "Ideation",
    visibility: "public",
    owner: users[1], # Pravat
    tags: ["IoT", "Python", "Smart Cities", "Data Science", "Sustainability"]
  },
  {
    title: "Telemedicine Platform",
    description: "Secure video consultation platform for rural healthcare. Features appointment scheduling, medical record management, and prescription tracking.",
    status: "Ongoing",
    visibility: "public",
    owner: users[4], # Nattaya
    tags: ["React", "Web Development", "Healthcare", "Telemedicine", "Full-Stack"]
  },
  {
    title: "Game Development Framework",
    description: "Cross-platform game development framework with physics engine, multiplayer support, and asset management. Built for indie developers.",
    status: "Completed",
    visibility: "public",
    owner: users[7], # Kittipong
    tags: ["C++", "Game Development", "Cross-platform", "Open Source"]
  },
  {
    title: "Climate Change Monitoring Dashboard",
    description: "Real-time environmental monitoring dashboard using satellite data and IoT sensors. Tracks air quality, water levels, and deforestation patterns.",
    status: "Ongoing",
    visibility: "public",
    owner: users[1], # Pravat
    tags: ["Python", "Data Science", "IoT", "Sustainability", "Big Data"]
  },
  {
    title: "Peer-to-Peer Learning Platform",
    description: "Social learning platform where students teach each other. Features skill matching, session scheduling, and progress tracking with micro-credentials.",
    status: "Ideation",
    visibility: "public",
    owner: users[2], # Siriporn
    tags: ["React", "Education", "Social Impact", "Full-Stack", "Community"]
  },
  {
    title: "Automated Code Review Tool",
    description: "AI-powered code review assistant that identifies bugs, security vulnerabilities, and suggests improvements. Integrates with GitHub and GitLab.",
    status: "Ongoing",
    visibility: "public",
    owner: users[5], # Somsak
    tags: ["AI", "DevOps", "Cybersecurity", "CI/CD", "Machine Learning"]
  },
  {
    title: "Virtual Reality Therapy",
    description: "VR-based exposure therapy for anxiety and PTSD treatment. Immersive environments with therapist-guided sessions and progress tracking.",
    status: "Ideation",
    visibility: "private",
    owner: users[9], # Test user 2
    tags: ["VR", "Healthcare", "Mental Health", "Therapy", "Innovation"]
  },
  {
    title: "Decentralized Social Network",
    description: "Blockchain-based social network prioritizing user privacy and data ownership. Features encrypted messaging and decentralized content storage.",
    status: "Ongoing",
    visibility: "public",
    owner: users[8], # Test user 1
    tags: ["Blockchain", "Cybersecurity", "Privacy", "Decentralized", "Social"]
  },
  {
    title: "Smart Grid Energy Management",
    description: "AI-driven energy distribution optimization for smart grids. Predicts demand patterns and balances renewable energy sources efficiently.",
    status: "Ongoing",
    visibility: "public",
    owner: users[6], # Piyanut
    tags: ["AI", "IoT", "Energy", "Smart Grid", "Sustainability"]
  },
  {
    title: "Cultural Heritage Preservation App",
    description: "Mobile app for documenting and preserving Thai cultural heritage. Features AR reconstruction of historical sites and oral history collections.",
    status: "Ideation",
    visibility: "public",
    owner: users[0], # Ananya
    tags: ["Mobile", "AR/VR", "Cultural Heritage", "Education", "Social Impact"]
  },
  {
    title: "Supply Chain Transparency Platform",
    description: "Blockchain-enabled supply chain tracking from farm to consumer. Ensures food safety and fair trade practices in agricultural products.",
    status: "Ongoing",
    visibility: "public",
    owner: users[3], # Thanakorn
    tags: ["Blockchain", "Supply Chain", "Agriculture", "Transparency", "Food Safety"]
  },
  {
    title: "AI-Powered Legal Assistant",
    description: "Legal document analysis and contract review automation. Uses NLP to identify clauses, risks, and suggest improvements.",
    status: "Completed",
    visibility: "private",
    owner: users[5], # Somsak
    tags: ["AI", "Legal Tech", "NLP", "Automation", "Enterprise"]
  },
  {
    title: "Community Disaster Response Network",
    description: "Real-time disaster coordination platform connecting volunteers, emergency services, and affected communities. Features resource mapping and communication tools.",
    status: "Ongoing",
    visibility: "public",
    owner: users[4], # Nattaya
    tags: ["Emergency Response", "Community", "Real-time", "Mapping", "Social Impact"]
  },
  {
    title: "Personal Finance Management App",
    description: "AI-driven personal finance app with automated budgeting, investment recommendations, and financial goal tracking.",
    status: "Ongoing",
    visibility: "public",
    owner: users[2], # Siriporn
    tags: ["Mobile", "Finance", "AI", "Personal Finance", "FinTech"]
  }
]

projects = []
projects_data.each do |project_data|
  tags_list = project_data.delete(:tags)
  owner = project_data.delete(:owner)
  
  project = Project.find_or_create_by!(title: project_data[:title]) do |p|
    p.description = project_data[:description]
    p.status = project_data[:status]
    p.visibility = project_data[:visibility]
    p.owner = owner
  end
  
  if project.previously_new_record?
    # Create project-tag associations
    tags_list.each do |tag_name|
      tag = tags.find { |t| t.tag_name == tag_name }
      ProjectTag.create!(project: project, tag: tag) if tag
    end

    # Create project stats (this should be handled by after_create callback, but let's ensure it)
    unless project.project_stat
      ProjectStat.create!(
        project: project,
        total_views: rand(50..500),
        total_votes: rand(0..50),
        total_comments: rand(0..20)
      )
    end

    puts "  ✓ Created: #{project.title} (#{project.status})"
  else
    puts "  ✓ Skipping existing project: #{project.title} (#{project.status})"
  end
  projects << project
end
puts "✅ Projects created: #{projects.count}\n"

# ============================================================================
# 5. COLLABORATIONS - Create collaboration relationships
# ============================================================================
puts "🤝 Creating Collaborations..."

collaborations_data = [
  { project: projects[0], user: users[1], project_role: "member" }, # Pravat joins Ananya's AI project
  { project: projects[0], user: users[3], project_role: "member" }, # Thanakorn joins AI project
  { project: projects[1], user: users[0], project_role: "member" }, # Ananya joins IoT project
  { project: projects[2], user: users[9], project_role: "member" }, # Test user 2 joins e-learning
  { project: projects[4], user: users[3], project_role: "member" }, # Thanakorn joins bioinformatics
  { project: projects[5], user: users[6], project_role: "member" }, # Piyanut joins microservices
  { project: projects[7], user: users[8], project_role: "member" }, # Test user 1 joins AR project
]

collaborations = []
collaborations_data.each do |collab_data|
  collaboration = Collaboration.find_or_create_by!(
    project: collab_data[:project],
    user: collab_data[:user]
  ) do |c|
    c.project_role = collab_data[:project_role]
  end
  collaborations << collaboration
end
puts "✅ Collaborations created: #{collaborations.count}\n"

# ============================================================================
# 6. COLLABORATION REQUESTS - Create pending requests
# ============================================================================
puts "📨 Creating Collaboration Requests..."

collaboration_requests_data = [
  { project: projects[0], user: users[5], status: "pending", message: "I'd love to mentor your AI project and share my experience with ML deployment." },
  { project: projects[1], user: users[7], status: "pending", message: "I'm interested in the IoT aspects of your traffic management system." },
  { project: projects[2], user: users[5], status: "pending", message: "I can help with the system architecture for your e-learning platform." },
  { project: projects[4], user: users[0], status: "pending", message: "My AI background could help with the data analysis pipeline." },
]

collaboration_requests = []
collaboration_requests_data.each do |request_data|
  request = CollaborationRequest.find_or_create_by!(
    project: request_data[:project],
    user: request_data[:user],
    status: request_data[:status]
  ) do |cr|
    cr.message = request_data[:message] if request_data[:message]
  end
  collaboration_requests << request
end
puts "✅ Collaboration requests created: #{collaboration_requests.count}\n"

# ============================================================================
# 7. COMMENTS - Create discussion threads
# ============================================================================
puts "💬 Creating Comments..."

comments_data = [
  { project: projects[0], user: users[1], content: "Great project! Have you considered using transfer learning with pre-trained models to improve accuracy?" },
  { project: projects[0], user: users[0], content: "Thanks! Yes, we're planning to use ResNet50 as our base model. What do you think about the dataset size?" },
  { project: projects[0], user: users[3], content: "I can help with data preprocessing. We should also consider data augmentation techniques." },
  { project: projects[1], user: users[0], content: "The IoT architecture looks solid. Have you thought about using LoRaWAN for long-range communication?" },
  { project: projects[2], user: users[9], content: "For the UI design, I suggest using a clean, minimal approach that's easy for rural teachers to navigate." },
  { project: projects[4], user: users[3], content: "For genomic analysis, you might want to look into tools like GATK for variant calling." },
  { project: projects[5], user: users[6], content: "The microservices architecture looks good. Consider using Kubernetes for orchestration." },
]

comments = []
comments_data.each do |comment_data|
  comment = Comment.create!(comment_data)
  comments << comment
end
puts "✅ Comments created: #{comments.count}\n"

# ============================================================================
# 8. VOTES - Create project votes
# ============================================================================
puts "👍 Creating Votes..."

# Create some upvotes for projects
projects.each do |project|
  # Random users vote on projects
  voters = users.sample(rand(0..5))
  voters.each do |voter|
    next if voter == project.owner # Don't let owners vote on their own projects
    Vote.find_or_create_by!(
      project: project,
      user: voter
    ) do |v|
      v.vote_type = ["up", "down"].sample
    end
  end
end
puts "✅ Votes created\n"

# ============================================================================
# 9. FUNDING REQUESTS - Create funding needs
# ============================================================================
puts "💰 Creating Funding Requests..."

funding_requests_data = [
  { project: projects[0], funder: users[0], amount: 500.0, status: "pending" },
  { project: projects[1], funder: users[1], amount: 300.0, status: "pending" },
  { project: projects[2], funder: users[2], amount: 200.0, status: "pending" },
  { project: projects[4], funder: users[4], amount: 1000.0, status: "pending" },
]

funding_requests = []
funding_requests_data.each do |funding_data|
  funding_request = FundingRequest.find_or_create_by!(
    project: funding_data[:project],
    funder: funding_data[:funder],
    status: funding_data[:status]
  ) do |fr|
    fr.amount = funding_data[:amount]
  end
  funding_requests << funding_request
  puts "  ✓ Created/found funding request: #{funding_data[:funder].full_name} -> #{funding_data[:project].title} ($#{funding_data[:amount]})"
end
puts "✅ Funding requests created: #{funding_requests.count}\n"

# ============================================================================
# 10. FUNDS - Create donations to funding requests
# ============================================================================
puts "💸 Creating Funds..."

funds_data = [
  { project: projects[0], funder: users[5], amount: 100.0 },
  { project: projects[0], funder: users[6], amount: 50.0 },
  { project: projects[2], funder: users[7], amount: 50.0 },
]

funds = []
funds_data.each do |fund_data|
  fund = Fund.create!(fund_data)
  funds << fund
end
puts "✅ Funds created: #{funds.count}\n"

# ============================================================================
# 11. RESOURCES - Create project resources
# ============================================================================
puts "📚 Creating Resources..."

resources_data = [
  { project: projects[0], added_by: users[0], title: "Crop Disease Dataset", description: "Collection of 10,000+ images of healthy and diseased crops", url: "https://example.com/crop-dataset" },
  { project: projects[0], added_by: users[3], title: "ML Model Training Guide", description: "Step-by-step guide for training CNN models on crop disease detection", url: "https://example.com/ml-guide" },
  { project: projects[1], added_by: users[1], title: "IoT Sensor Schematics", description: "Circuit diagrams and pinouts for traffic sensors", url: "https://example.com/iot-schematics" },
  { project: projects[2], added_by: users[2], title: "UI Mockups", description: "Figma designs for the e-learning platform interface", url: "https://example.com/ui-mockups" },
  { project: projects[4], added_by: users[4], title: "Bioinformatics Tools", description: "Collection of scripts and tools for genomic analysis", url: "https://github.com/example/bioinformatics-tools" },
]

resources = []
resources_data.each do |resource_data|
  resource = Resource.create!(resource_data)
  resources << resource
end
puts "✅ Resources created: #{resources.count}\n"

# ============================================================================
# 12. MESSAGES - Create private messages between users
# ============================================================================
puts "💌 Creating Messages..."

messages_data = [
  { sender: users[0], receiver: users[1], content: "Hey Pravat! I saw you're working on IoT projects. Want to collaborate on the AI crop detection system?", is_read: true },
  { sender: users[1], receiver: users[0], content: "Hi Ananya! That sounds interesting. I'd love to help with the hardware side of things.", is_read: true },
  { sender: users[5], receiver: users[0], content: "Hello Ananya, I noticed your AI project. I'd be happy to mentor you on ML deployment strategies.", is_read: false },
  { sender: users[2], receiver: users[9], content: "Hi! I love your UI/UX suggestions on the e-learning project. Can we discuss the design further?", is_read: false },
]

messages = []
messages_data.each do |message_data|
  message = Message.create!(message_data)
  messages << message
end
puts "✅ Messages created: #{messages.count}\n"

# ============================================================================
# 13. REPORTS - Create some reports for moderation
# ============================================================================
puts "🚨 Creating Reports..."

reports_data = [
  { reporter: users[8], reportable: comments[0], reason: "spam", description: "This comment appears to be promotional spam", status: "pending" },
  { reporter: users[9], reportable: projects[8], reason: "inappropriate", description: "Project content may not be suitable for academic environment", status: "resolved" },
]

reports = []
reports_data.each do |report_data|
  report = Report.create!(report_data)
  reports << report
end
puts "✅ Reports created: #{reports.count}\n"

# ============================================================================
# 14. NOTIFICATIONS - Create notifications for users
# ============================================================================
puts "🔔 Skipping Notifications (requires notifiable associations)..."
notifications = []
# notifications_data = [
#   { user: users[0], notification_type: "collaboration_request", message: "#{users[5].full_name} wants to mentor your project", read: false },
#   { user: users[1], notification_type: "new_message", message: "You've been invited to join #{projects[0].title}", read: true },
#   { user: users[2], notification_type: "project_comment", message: "#{users[9].full_name} commented on your project", read: false },
#   { user: users[3], notification_type: "project_vote", message: "Someone upvoted your fraud detection project", read: true },
#   { user: users[4], notification_type: "funding_verified", message: "You received funding for your bioinformatics project", read: false },
# ]

# notifications = []
# notifications_data.each do |notification_data|
#   notification = Notification.create!(notification_data)
#   notifications << notification
# end
puts "✅ Notifications skipped: 0\n"

# ============================================================================
# SUMMARY
# ============================================================================
puts "\n" + "="*60
puts "TEST DATA SEEDING COMPLETED SUCCESSFULLY!"
puts "="*60
puts "\n📊 SUMMARY:"
puts "  👥 Users: #{users.count}"
puts "  🏷️  Tags: #{tags.count}"
puts "  📁 Projects: #{projects.count}"
puts "  🤝 Collaborations: #{collaborations.count}"
puts "  📨 Collaboration Requests: #{collaboration_requests.count}"
puts "  💬 Comments: #{comments.count}"
puts "  👍 Votes: #{Vote.count}"
puts "  💰 Funding Requests: #{funding_requests.count}"
puts "  💸 Funds: #{funds.count}"
puts "  📚 Resources: #{resources.count}"
puts "  💌 Messages: #{messages.count}"
puts "  🚨 Reports: #{reports.count}"
puts "  🔔 Notifications: #{notifications.count}"

puts "\n🔐 LOGIN CREDENTIALS:"
puts "  Admin: test.admin@collabsphere.com / admin123"
users.select { |u| u.email.include?('test.student') || u.email.include?('test.mentor') }.first(5).each do |user|
  puts "  #{user.full_name}: #{user.email} / password123"
end

puts "\n🎯 TEST SCENARIOS TO TRY:"
puts "  • Browse projects by tags (AI, IoT, Web Development)"
puts "  • Send collaboration requests"
puts "  • Create comments and discussions"
puts "  • Vote on projects"
puts "  • Donate to funding requests"
puts "  • Send private messages"
puts "  • Report inappropriate content (as admin)"
puts "  • Check notifications"
puts "  • Upload and share resources"

puts "\n" + "="*60 + "\n"
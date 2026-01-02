# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a default admin user for development/testing
begin
	admin_email = 'admin@collab.com'
	admin = User.find_or_initialize_by(email: admin_email)
	admin.full_name = 'Site Admin'
	# set password to 'admin' as requested; bypass validations to allow short password in dev only
	admin.password = 'admin'
	admin.password_confirmation = 'admin'
	admin.system_role = 'admin'
	# Save without validations to ensure creation even if password length is short for development convenience
	admin.save!(validate: false)
	puts "Seed: ensured admin user #{admin_email} exists"
rescue => e
	puts "Seed: failed to create admin user: #{e.message}"
end

# Old sample data section skipped - using realistic demo data section below instead
puts "Seed: skipping old sample data sections"
$stdout.flush

# Old sample reports section skipped - using realistic demo reports below instead

	# Sample users
	sample_users = [
		{ 
			full_name: 'Alice Developer', 
			email: 'alice@example.com', 
			password: 'password1',
			country: 'USA',
			university: 'MIT',
			department: 'Computer Science'
		},
		{ 
			full_name: 'Bob Designer', 
			email: 'bob@example.com', 
			password: 'password1',
			country: 'UK',
			university: 'Cambridge',
			department: 'Design'
		},
		{ 
			full_name: 'Carol Researcher', 
			email: 'carol@example.com', 
			password: 'password1',
			country: 'Canada',
			university: 'University of Toronto',
			department: 'AI Research'
		},
		{ 
			full_name: 'David Engineer', 
			email: 'david@example.com', 
			password: 'password1',
			country: 'USA',
			university: 'Stanford',
			department: 'Engineering'
		},
		{ 
			full_name: 'Emma Scientist', 
			email: 'emma@example.com', 
			password: 'password1',
			country: 'Germany',
			university: 'TU Munich',
			department: 'Physics'
		}
	]

	sample_users.each do |u|
		user = User.find_or_initialize_by(email: u[:email])
		user.full_name = u[:full_name]
		user.password = u[:password]
		user.password_confirmation = u[:password]
		user.system_role ||= 'user'
		user.country = u[:country]
		user.university = u[:university]
		user.department = u[:department]
		user.save!
	end

	users = User.where(email: sample_users.map { |s| s[:email] })

	# Sample tags - expanded list
	tag_names = [
		'ruby', 'rails', 'python', 'javascript', 'typescript', 'java', 'cpp', 'go', 'rust', 'swift',
		'product', 'design', 'ui', 'ux', 'frontend', 'backend', 'fullstack', 'devops', 'cloud',
		'ai', 'ml', 'data-science', 'nlp', 'computer-vision', 'deep-learning',
		'education', 'research', 'academic', 'tutorial', 'learning',
		'blockchain', 'crypto', 'web3', 'ethereum', 'solidity',
		'iot', 'embedded', 'hardware', 'robotics', 'automation',
		'mobile', 'ios', 'android', 'react-native', 'flutter',
		'web', 'api', 'microservices', 'graphql', 'rest',
		'database', 'sql', 'nosql', 'mongodb', 'postgresql',
		'security', 'cybersecurity', 'authentication', 'encryption',
		'testing', 'ci-cd', 'docker', 'kubernetes', 'aws',
		'game-dev', 'unity', 'unreal', '3d', 'graphics',
		'open-source', 'community', 'collaboration', 'hackathon',
		'sustainability', 'healthcare', 'fintech', 'edtech', 'social-impact',
		'data-visualization', 'analytics', 'big-data', 'data-engineering'
	]
	tag_names.each do |tn|
		Tag.find_or_create_by!(tag_name: tn)
	end

	tags = Tag.where(tag_name: tag_names)

	# Sample projects
	sample_projects = [
		{
			title: 'Campus Collaboration Platform',
			description: 'A platform to connect students and mentors for project collaboration.',
			owner_email: 'alice@example.com',
			status: 'Ideation',
			visibility: 'public',
			tag_names: ['ruby', 'product', 'web']
		},
		{
			title: 'Design System for Startups',
			description: 'A modular design system to speed up product development.',
			owner_email: 'bob@example.com',
			status: 'Ongoing',
			visibility: 'public',
			tag_names: ['design', 'product', 'web']
		},
		{
			title: 'AI Research Toolkit',
			description: 'Tools and notebooks for reproducible AI research.',
			owner_email: 'carol@example.com',
			status: 'Ongoing',
			visibility: 'private',
			tag_names: ['ai', 'education']
		},
		{
			title: 'Blockchain for Supply Chain',
			description: 'Decentralized supply chain tracking system.',
			owner_email: 'david@example.com',
			status: 'Completed',
			visibility: 'public',
			tag_names: ['blockchain', 'product']
		},
		{
			title: 'IoT Smart Home Hub',
			description: 'Centralized control system for IoT devices.',
			owner_email: 'emma@example.com',
			status: 'Ongoing',
			visibility: 'public',
			tag_names: ['iot', 'mobile']
		}
	]

	sample_projects.each do |p|
		owner = User.find_by(email: p[:owner_email])
		next unless owner

		project = Project.find_or_initialize_by(title: p[:title])
		project.description = p[:description]
		project.owner = owner
		project.status = p[:status]
		project.visibility = p[:visibility]
		project.save!

		# Attach tags
		p[:tag_names].each do |tn|
			tag = Tag.find_by(tag_name: tn)
			next unless tag
			ProjectTag.find_or_create_by!(project: project, tag: tag)
		end

		# Add collaborators (other sample users, max 3 per project)
		collaborator_candidates = users.where.not(id: owner.id).sample(rand(1..3))
		collaborator_candidates.each_with_index do |u, idx|
			Collaboration.find_or_create_by!(project: project, user: u) do |c|
				c.project_role = idx == 0 ? :member : :viewer
			end
		end

		# Add comments to public projects
		if project.visibility == 'public'
			commenters = users.where.not(id: owner.id).sample(rand(2..4))
			commenters.each do |commenter|
				Comment.find_or_create_by!(
					project: project,
					user: commenter,
					content: "Great project! Looking forward to seeing more updates."
				)
			end
		end

		# Add votes
		voters = users.sample(rand(3..8))
		voters.each do |voter|
			Vote.find_or_create_by!(project: project, user: voter) do |v|
				v.vote_type = rand > 0.2 ? 'up' : 'down'
			end
		end

		# Add funding for some projects
		if rand > 0.5 && project.visibility == 'public'
			funders = users.where.not(id: owner.id).sample(rand(1..3))
			funders.each do |funder|
				Fund.find_or_create_by!(project: project, funder: funder) do |f|
					f.amount = [100, 250, 500, 1000, 2500].sample
					f.funded_at = rand(1..30).days.ago
				end
			end
		end

		# Ensure project stat exists and set some numbers for demo
		ps = project.project_stat || ProjectStat.create!(project: project, total_views: 0, total_votes: 0, total_comments: 0)
		ps.update(
			total_views: rand(50..500), 
			total_votes: project.votes.where(vote_type: 'up').count, 
			total_comments: project.comments.count
		)
	end

	puts "Seed: sample data created (users: #{User.count}, projects: #{Project.count}, tags: #{Tag.count})"
=end
rescue => e
	puts "Seed: failed creating sample data: #{e.message}"
end

# Skip old sample reports - we create better ones in realistic demo data section
=begin
# Create sample reports
begin
	puts "Seed: skipping old sample reports (using realistic demo reports instead)"
	
	# Get users and projects
	reporters = User.where.not(system_role: 'admin').limit(3)
	reported_users = User.where.not(system_role: 'admin').offset(1).limit(2)
	reported_projects = Project.limit(2)
	
	if reporters.any? && reported_users.any?
		# Report a user for spam
		Report.find_or_create_by!(
			reporter: reporters.first,
			reportable: reported_users.first,
			reason: 'Spam'
		) do |r|
			r.description = 'User is posting spam content repeatedly in project comments'
			r.status = 'pending'
		end
		
		# Report a user for inappropriate behavior (resolved)
		Report.find_or_create_by!(
			reporter: reporters.second,
			reportable: reported_users.second,
			reason: 'Inappropriate behavior'
		) do |r|
			r.description = 'User posted offensive comments in multiple projects'
			r.status = 'resolved'
			r.resolved_by = User.find_by(system_role: 'admin')
			r.resolved_at = 2.days.ago
		end
		
		# Report a user for harassment (dismissed)
		Report.find_or_create_by!(
			reporter: reporters.last,
			reportable: reported_users.first,
			reason: 'Harassment'
		) do |r|
			r.description = 'Sending inappropriate messages'
			r.status = 'dismissed'
			r.resolved_by = User.find_by(system_role: 'admin')
			r.resolved_at = 1.day.ago
		end
	end
	
	if reporters.any? && reported_projects.any?
		# Report a project for misleading information
		Report.find_or_create_by!(
			reporter: reporters.first,
			reportable: reported_projects.first,
			reason: 'Misleading information'
		) do |r|
			r.description = 'Project description contains false claims about capabilities'
			r.status = 'pending'
		end
		
		# Report a project for copyright violation (resolved)
		Report.find_or_create_by!(
			reporter: reporters.second,
			reportable: reported_projects.second,
			reason: 'Copyright violation'
		) do |r|
			r.description = 'Project uses copyrighted material without permission'
			r.status = 'resolved'
			r.resolved_by = User.find_by(system_role: 'admin')
			r.resolved_at = 3.days.ago
		end
		
		# Report a project for inappropriate content
		Report.find_or_create_by!(
			reporter: reporters.last,
			reportable: reported_projects.first,
			reason: 'Inappropriate content'
		) do |r|
			r.description = 'Project contains offensive images'
			r.status = 'reviewing'
		end
	end
	
	# Create some tag and comment reports if they exist
	if reporters.any?
		# Report a tag
		tag = Tag.first
		if tag
			Report.find_or_create_by!(
				reporter: reporters.first,
				reportable: tag,
				reason: 'Offensive tag'
			) do |r|
				r.description = 'Tag name is inappropriate'
				r.status = 'pending'
			end
		end
		
		# Report a comment if any exists
		comment = Comment.first
		if comment
			Report.find_or_create_by!(
				reporter: reporters.second,
				reportable: comment,
				reason: 'Spam'
			) do |r|
				r.description = 'Comment contains spam links'
				r.status = 'pending'
			end
		end
	end
	
	puts "Seed: sample reports created (total reports: #{Report.count})"
=end
rescue => e
	puts "Seed: failed creating sample reports: #{e.message}"
end

	begin
		puts "Seed: creating realistic demo data with interconnected users, funding, and collaborations"
		$stdout.flush

		# Larger pools for diversity (intentionally include case variations)
		countries = ['Nepal', 'nepal', 'NEPAL', 'USA', 'United States', 'india', 'India', 'Germany', 'UK', 'Brazil', 'Canada', 'Australia', 'China', 'Nigeria', 'France', 'Japan', 'South Korea']
		universities = ['MIT', 'mit', 'Stanford', 'stanford', 'Cambridge', 'Oxford', 'TU Munich', 'University of Toronto', 'Kathmandu University', 'Tribhuvan University', 'IIT Bombay', 'NUS', 'ETH Zurich']
		departments = ['Computer Science', 'computer science', 'Design', 'Engineering', 'Physics', 'AI Research', 'Business', 'Economics', 'Data Science', 'Robotics']
		first_names = %w[Alex Sam Jamie Taylor Jordan Casey Morgan Riley Avery Quinn Robin Dakota Skyler Corey Rowan Sage Phoenix Emery Blake Drew Parker Reese Cameron Finley Harper]
		last_names = %w[Smith Johnson Williams Brown Jones Miller Davis Garcia Rodriguez Martinez Wilson Anderson Thomas Taylor Moore Jackson Martin Lee Thompson White Harris Clark Lewis Robinson Walker Hall]
		extra_tags = %w[
			python javascript typescript java cpp go rust swift kotlin scala
			react vue angular svelte nextjs express django flask fastapi
			tensorflow pytorch keras scikit-learn pandas numpy
			aws azure gcp firebase heroku netlify vercel
			postgresql mysql mongodb redis elasticsearch
			docker kubernetes jenkins gitlab-ci github-actions
			nlp computer-vision reinforcement-learning gan transformer
			blockchain ethereum solidity smart-contracts defi nft
			iot arduino raspberry-pi sensors actuators
			game-dev unity unreal godot phaser
			3d-modeling blender maya animation
			cybersecurity penetration-testing encryption oauth jwt
			agile scrum kanban jira confluence
			graphql rest soap websocket grpc
			testing jest mocha pytest selenium cypress
			accessibility performance-optimization seo pwa
			social-impact civic-tech sustainability climate-tech
			healthcare medtech biotech pharmaceutical
			fintech payment-systems trading algorithmic-trading
			edtech e-learning mooc lms gamification
			ar vr xr metaverse spatial-computing
			quantum-computing edge-computing serverless
			open-source community mentorship hackathon
			data-pipeline etl data-warehouse olap
			business-intelligence dashboard reporting analytics
		]

		# Ensure extra tags exist
		(extra_tags + tag_names).uniq.each do |tn|
			Tag.find_or_create_by!(tag_name: tn.downcase)
		end

		# Create diverse users with different activity patterns
		150.times do |i|
			fn = first_names.sample
			ln = last_names.sample
			email = "user#{i+1}@example.com"
			u = User.find_or_initialize_by(email: email)
			u.full_name = "#{fn} #{ln}"
			u.password = 'password123'
			u.password_confirmation = 'password123'
			u.country = countries.sample
			u.university = universities.sample
			u.department = departments.sample
			u.save!
		end

		all_users = User.where("email LIKE ?", "user%@example.com").to_a
		
		# Identify power users (10% of users are very active)
		power_users = all_users.sample((all_users.count * 0.1).to_i)
		moderate_users = (all_users - power_users).sample((all_users.count * 0.3).to_i)
		casual_users = all_users - power_users - moderate_users

		# Realistic project data with compelling titles and descriptions
		realistic_projects = [
			{ title: "EduChain - Blockchain for Academic Credentials", desc: "Decentralized platform for verifying and sharing academic credentials globally. Using blockchain to prevent credential fraud.", tags: %w[blockchain education smart-contracts solidity], status: "Ongoing", viral: true },
			{ title: "HealthAI - Medical Diagnosis Assistant", desc: "AI-powered diagnostic tool helping doctors identify diseases from medical imaging. Trained on 50k+ medical scans.", tags: %w[ai healthcare computer-vision tensorflow python], status: "Completed", viral: true },
			{ title: "Climate Dashboard - Real-time Environmental Data", desc: "Interactive dashboard visualizing climate data from satellites and sensors worldwide. Open source for researchers.", tags: %w[sustainability data-visualization python react open-source], status: "Ongoing", viral: true },
			{ title: "CodeMentor - AI Pair Programming", desc: "AI assistant that helps students learn programming through interactive code review and suggestions.", tags: %w[ai edtech nlp python javascript], status: "Ongoing", viral: false },
			{ title: "FinGuard - Personal Finance Security", desc: "ML-based fraud detection system for personal banking. Prevents unauthorized transactions in real-time.", tags: %w[fintech security ml python cybersecurity], status: "Completed", viral: true },
			{ title: "FoodShare - Community Food Distribution", desc: "Mobile app connecting food donors with community kitchens to reduce waste and fight hunger.", tags: %w[social-impact mobile react-native firebase], status: "Ongoing", viral: false },
			{ title: "QuantumSim - Quantum Computing Simulator", desc: "Educational quantum computing simulator for students. Visualizes quantum states and gates.", tags: %w[quantum-computing education python react 3d], status: "Ideation", viral: false },
			{ title: "SmartFarm - IoT Agriculture System", desc: "IoT sensor network for precision agriculture. Monitors soil, weather, and crop health automatically.", tags: %w[iot agriculture sensors arduino sustainability], status: "Ongoing", viral: true },
			{ title: "LegalBot - AI Legal Document Assistant", desc: "NLP tool for analyzing legal documents and contracts. Helps startups understand legal agreements.", tags: %w[nlp ai legal-tech python tensorflow], status: "Ongoing", viral: false },
			{ title: "GameForge - Collaborative Game Development", desc: "Platform for indie game developers to collaborate on games. Built-in version control and asset sharing.", tags: %w[game-dev unity collaboration open-source], status: "Ongoing", viral: true },
			{ title: "DataPipe - No-Code Data Pipeline Builder", desc: "Visual tool for building ETL pipelines without coding. Supports 50+ data sources.", tags: %w[data-engineering etl no-code python], status: "Completed", viral: true },
			{ title: "VoiceGuard - Deepfake Audio Detection", desc: "AI system detecting synthetic voice in audio recordings. Combats misinformation and fraud.", tags: %w[ai cybersecurity ml audio-processing python], status: "Ongoing", viral: true },
			{ title: "EcoRoute - Sustainable Transportation Planner", desc: "Route planner optimizing for lowest carbon footprint. Considers public transport, biking, walking.", tags: %w[sustainability mobile algorithms optimization], status: "Ongoing", viral: false },
			{ title: "MindfulSpace - VR Meditation Platform", desc: "Virtual reality environments designed for meditation and mental wellness. Scientifically validated.", tags: %w[vr healthcare unity mental-health], status: "Ongoing", viral: false },
			{ title: "CodeReview AI - Automated Code Analysis", desc: "ML-based code review tool finding bugs, security issues, and suggesting improvements.", tags: %w[ai devops security python testing], status: "Completed", viral: true }
		]

		created_projects = []
		
		# Create viral/popular projects first (these will get more engagement)
		realistic_projects.each_with_index do |proj_data, idx|
			owner = power_users.sample
			project = Project.create!(
				title: proj_data[:title],
				description: proj_data[:desc],
				owner: owner,
				status: proj_data[:status],
				visibility: 'public'
			)
			
			# Attach tags
			proj_data[:tags].each do |tag_name|
				tag = Tag.find_by("LOWER(tag_name) = ?", tag_name.downcase) || Tag.find_or_create_by!(tag_name: tag_name.downcase)
				ProjectTag.create!(project: project, tag: tag)
			end
			
			created_projects << { project: project, viral: proj_data[:viral] }
		end

		# Create additional projects with varied popularity
		65.times do |i|
			owner = [power_users, moderate_users, casual_users].sample.sample
			adjectives = ['Collaborative', 'Intelligent', 'Next-Gen', 'Distributed', 'Adaptive', 'Autonomous', 'Real-time', 'Scalable']
			nouns = ['Platform', 'System', 'Toolkit', 'Framework', 'Hub', 'Network', 'Service', 'Solution']
			domains = ['Healthcare', 'Education', 'Finance', 'Social', 'Gaming', 'Research', 'Enterprise', 'Mobile']
			
			project = Project.create!(
				title: "#{adjectives.sample} #{domains.sample} #{nouns.sample}",
				description: "Innovative solution addressing key challenges in #{domains.sample.downcase}. Built with modern tech stack for scalability and performance.",
				owner: owner,
				status: ['Ideation', 'Ongoing', 'Completed'].sample,
				visibility: rand > 0.2 ? 'public' : 'private'
			)
			
			# Attach 2-5 tags
			Tag.all.sample(rand(2..5)).each do |tag|
				ProjectTag.create!(project: project, tag: tag)
			end
			
			created_projects << { project: project, viral: rand > 0.7 }
		end

		# Now add realistic interactions
		created_projects.each do |proj_hash|
			project = proj_hash[:project]
			is_viral = proj_hash[:viral]
			next if project.visibility == 'private'
			
			# Determine engagement level
			if is_viral
				collaborator_count = rand(5..10)
				voter_count = rand(50..150)
				comment_count = rand(20..60)
				funder_count = rand(15..40)  # Increased funding
				view_count = rand(5000..25000)
			else
				collaborator_count = rand(1..4)
				voter_count = rand(5..30)
				comment_count = rand(2..12)
				funder_count = rand(2..12)  # Increased minimum funding
				view_count = rand(100..2000)
			end
			
			# Add collaborators (often from same university or country)
			potential_collabs = all_users.where.not(id: project.owner.id)
			same_university = potential_collabs.where(university: project.owner.university).to_a
			same_country = potential_collabs.where(country: project.owner.country).to_a
			
			collaborators = (same_university.sample(collaborator_count/2) + same_country.sample(collaborator_count/3) + potential_collabs.sample(collaborator_count/3)).uniq.take(collaborator_count)
			
			collaborators.each_with_index do |collab, idx|
				Collaboration.create!(
					project: project,
					user: collab,
					project_role: idx < 2 ? 'member' : 'viewer'
				)
			end
			
			# Add votes (mostly upvotes for good projects)
			voters = (power_users.sample(voter_count/3) + moderate_users.sample(voter_count/3) + casual_users.sample(voter_count/3)).uniq.take(voter_count)
			voters.each do |voter|
				Vote.create!(
					project: project,
					user: voter,
					vote_type: rand > 0.15 ? 'up' : 'down'
				)
			end
			
			# Add meaningful comments
			comment_templates = [
				"This is exactly what we need in the #{project.tags.first&.tag_name || 'tech'} space! Would love to contribute.",
				"Great work on this project! Have you considered integrating with #{Tag.all.sample.tag_name}?",
				"I've been working on something similar. Would be great to collaborate and share insights.",
				"The architecture looks solid. How are you handling scalability?",
				"Impressive progress! Any plans for open sourcing the codebase?",
				"This could be a game changer. Have you thought about commercialization?",
				"Really well documented. Makes it easy to understand the goals.",
				"I'd love to use this in my research. Is there an API available?",
				"The UI/UX is intuitive. Great attention to detail!",
				"How can I help? I have experience with #{Tag.all.sample.tag_name}."
			]
			
			commenters = (power_users + moderate_users).sample(comment_count)
			commenters.each do |commenter|
				Comment.create!(
					project: project,
					user: commenter,
					content: comment_templates.sample
				)
			end
			
			# Add funding (larger amounts for viral projects, from engaged users)
			if funder_count > 0
				# Funders are often collaborators, commenters, or power users
				potential_funders = (collaborators + commenters + power_users + moderate_users.sample(10)).uniq.take(funder_count)
				
				potential_funders.each do |funder|
					amount = if is_viral
						[500, 750, 1000, 1500, 2500, 3000, 5000, 7500, 10000].sample  # Wider range including larger amounts
					else
						[25, 50, 75, 100, 150, 250, 500, 750, 1000].sample  # Better distribution
					end
					
					Fund.create!(
						project: project,
						funder: funder,
						amount: amount,
						funded_at: rand(1..90).days.ago
					)
				end
			end
			
			# Update project stats
			ps = project.project_stat || ProjectStat.create!(project: project, total_views: 0, total_votes: 0, total_comments: 0)
			ps.update!(
				total_views: view_count,
				total_votes: project.votes.where(vote_type: 'up').count,
				total_comments: project.comments.count
			)
		end
		
		# Add extensive realistic reports for moderation testing
		puts "Seed: creating comprehensive reports for moderation..."
		$stdout.flush
		
		public_projects = Project.where(visibility: 'public').to_a
		reportable_projects = public_projects.sample(60)  # Report more projects
		all_comments = Comment.all.to_a
		reportable_comments = all_comments.sample(30)  # Report some comments
		reportable_users = all_users.sample(20)  # Report some users
		reporters = (power_users + moderate_users).sample(15)
		admin_user = User.find_by(system_role: 'admin')
		
		project_report_reasons = [
			{ reason: 'Spam', desc: 'Project description contains promotional links and spam content', likely: 0.7 },
			{ reason: 'Misleading information', desc: 'Project claims are not substantiated and appear to be misleading', likely: 0.6 },
			{ reason: 'Copyright violation', desc: 'Project uses copyrighted code without proper attribution', likely: 0.5 },
			{ reason: 'Inappropriate content', desc: 'Project contains inappropriate or offensive material', likely: 0.4 },
			{ reason: 'Duplicate project', desc: 'This is a duplicate of an existing project', likely: 0.3 },
			{ reason: 'Scam/Fraud', desc: 'Project appears to be fraudulent and asking for money under false pretenses', likely: 0.3 }
		]
		
		user_report_reasons = [
			{ reason: 'Spam', desc: 'User is posting spam content across multiple projects' },
			{ reason: 'Harassment', desc: 'User is harassing other community members' },
			{ reason: 'Inappropriate behavior', desc: 'User posted offensive comments in multiple projects' },
			{ reason: 'Fake profile', desc: 'User profile appears to be fake or impersonating someone' }
		]
		
		comment_report_reasons = [
			{ reason: 'Spam', desc: 'Comment contains spam links' },
			{ reason: 'Offensive content', desc: 'Comment contains offensive language' },
			{ reason: 'Harassment', desc: 'Comment is harassing another user' },
			{ reason: 'Off-topic', desc: 'Comment is completely off-topic and derails discussion' }
		]
		
		# Report projects
		reportable_projects.each do |proj|
			report_data = project_report_reasons.sample
			next if rand > report_data[:likely]
			
			status_options = ['pending', 'reviewing', 'resolved', 'dismissed']
			chosen_status = status_options.sample
			
			report = Report.create!(
				reporter: reporters.sample,
				reportable: proj,
				reason: report_data[:reason],
				description: report_data[:desc],
				status: chosen_status
			)
			
			# Add resolution data for resolved/dismissed reports
			if ['resolved', 'dismissed'].include?(chosen_status) && admin_user
				report.update!(
					resolved_by: admin_user,
					resolved_at: rand(1..30).days.ago
				)
			end
		end
		
		# Report comments
		reportable_comments.each do |comment|
			next if rand > 0.4
			report_data = comment_report_reasons.sample
			chosen_status = ['pending', 'reviewing', 'resolved', 'dismissed'].sample
			
			report = Report.create!(
				reporter: reporters.sample,
				reportable: comment,
				reason: report_data[:reason],
				description: report_data[:desc],
				status: chosen_status
			)
			
			if ['resolved', 'dismissed'].include?(chosen_status) && admin_user
				report.update!(
					resolved_by: admin_user,
					resolved_at: rand(1..30).days.ago
				)
			end
		end
		
		# Report users
		reportable_users.each do |user|
			next if rand > 0.5 || user.system_role == 'admin'
			report_data = user_report_reasons.sample
			chosen_status = ['pending', 'reviewing', 'resolved', 'dismissed'].sample
			
			report = Report.create!(
				reporter: reporters.sample,
				reportable: user,
				reason: report_data[:reason],
				description: report_data[:desc],
				status: chosen_status
			)
			
			if ['resolved', 'dismissed'].include?(chosen_status) && admin_user
				report.update!(
					resolved_by: admin_user,
					resolved_at: rand(1..30).days.ago
				)
			end
		end

		total_funding = Fund.sum(:amount).to_f.round(2)
		puts "Seed: realistic demo data created!"
		puts "  - Users: #{User.count}"
		puts "  - Projects: #{Project.count} (#{Project.where(visibility: 'public').count} public)"
		puts "  - Collaborations: #{Collaboration.count}"
		puts "  - Funds: #{Fund.count} (Total: $#{total_funding})"
		puts "  - Comments: #{Comment.count}"
		puts "  - Votes: #{Vote.count}"
		puts "  - Tags: #{Tag.count}"
		puts "  - Reports: #{Report.count}"
		$stdout.flush
	rescue => e
		puts "Seed: failed creating realistic demo data: #{e.message}"
		puts e.backtrace
	end

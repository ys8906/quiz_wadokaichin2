# Separating environments for each seed
load(Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb"))

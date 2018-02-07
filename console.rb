# load dependencies
require('pry-byebug')
require_relative('models/bounty.rb')

# create some bounty instances for DATABASE
bounty1 = Bounty.new({
  'name' => 'Han Solo',
  'bounty' => '224190',
  'danger_level' => 'severe',
  'cashed_in' => 'false'
})

bounty2 = Bounty.new({
  'name' => 'Mara Jade',
  'bounty' => '60000',
  'danger_level' => 'high',
  'cashed_in' => 'false'
})

bounty3 = Bounty.new({
  'name' => 'Lando Calrissian',
  'bounty' => '105000',
  'danger_level' => 'medium',
  'cashed_in' => 'false'
})

bounty4 = Bounty.new({
  'name' => 'Mon Mothma',
  'bounty' => '75000',
  'danger_level' => 'low',
  'cashed_in' => 'false'
})

bounty5 = Bounty.new({
  'name' => 'Luke Skywalker',
  'bounty' => '250000',
  'danger_level' => 'severe',
  'cashed_in' => 'false'
})

# create our bounties
bounty1.save()
bounty2.save()
bounty3.save()
bounty4.save()
bounty5.save()

# we caught that bloody Solo
## update the instance
bounty1.cashed_in = 'true'
## update the database
bounty1.update()

# delete Mara Jade from DB
bounty2.delete()



# assign DB contents to bounties var
bounties = Bounty.all()

bounty = Bounty.find('Han Solo')

# find all bounties with a DANGER_LEVEL of SEVERE
bounty_data = Bounty.find_by('danger_level', 'severe')

# if you want to delete the whole Database
# Bounty.delete_all

binding.pry
return nil
